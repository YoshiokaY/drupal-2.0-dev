/**
 * My Theme - Main TypeScript Entry
 */

declare const Drupal: {
  behaviors: Record<string, {
    attach: (context: Document | Element, settings: unknown) => void;
  }>;
};

declare function once(
  id: string,
  selector: string,
  context?: Document | Element
): Element[];

Drupal.behaviors.myTheme = {
  attach(context: Document | Element, _settings: unknown): void {
    once('my-theme-init', 'body', context).forEach(() => {
      initTheme();
    });
  },
};

function initTheme(): void {
  // Theme initialization logic
}
