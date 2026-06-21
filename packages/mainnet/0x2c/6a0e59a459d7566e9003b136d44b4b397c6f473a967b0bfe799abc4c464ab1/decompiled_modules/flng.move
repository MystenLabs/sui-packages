module 0x2c6a0e59a459d7566e9003b136d44b4b397c6f473a967b0bfe799abc4c464ab1::flng {
    struct FLNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<FLNG>(arg0, 6, b"FLNG", b"Fleeng", b"Official FLNG token. ", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRs4DAABXRUJQVlA4IMIDAADwFgCdASqAAIAAPm0ylUekIqIhKRR5CIANiWUA1uIQPz/y95GdJ24fmA87n0c+cz1MG9BYCB/QOrtXk/4ThB13t6761/nfQDFFf61/xvUYz6vS3owekyMKRxEhFq4YbdVXk7z79qHcq0A6bIjA5bhwCd2FwhZXmoFX9+x56Er8Qg0vfVQTjuqhHV2g2zJa33nK02r7C3e9D8GsJ0kyWYlh4s6O8W1S2V2fqkQEeBHVYh5MB6TsnM7hht1VeT5dFAAA/vnnA2x1llRf/iHNbe5TWIAADbFgfrHa8GfaB4m/MicCsZ4bPg1A4NEfsQXPxqyFTKysvMdxCbWpI+9YqJ+VDk66Dh5sF5y+yhvfYKozTat1co8Wvc+eRIwnXR40jjbTLAu7ScC5l9mtLiEcAJ8ze92wppH/usW/65VExIgXw6nklxc2J5FiwHmZ/9pl0SktJZnumcJeKKHdD97mVLj3H+8mz+l0JS+ze1ZUT2QulbDNqMucE/P37Q4B2MVPuWch5UPeXEkAj4taKnKDnvbII5pOFGBG0NllqCGVkRhU4EtYGj6VE3Wyqznvc3y03Kf/Gn8NOVBTfbcOkJEVrx3zLX4M+y2d8c3SBR6UeiGgzvcG/zklQd7CLNbpIEgMMCZGhIOMvx8L5Wbh0v97SGVwNXBR/ve3qaqJPOX52DnfhYLBqy++pVTTcqnj53DHafzQzd7YKZ8ZzCsrULsPLF9uWx+pDN+oBHOL/6ciJ+hhNT3tQDpxuRZGzMbgOFFwbmON9/6w6l18szgLR7IhaMlFjd8RbiXJxdFkzS3PuKQnFB0kjYUBbnBaWGYWLnjf2xOefj37w5BL3K4roBCbM0r6NSUxRrVxFgS/sZ+NO8+wk40sKvFfkA4AhQ2OuaoboQ0eit1jE0B5EOjrFaBsk48dmTJCDw+rKn6c69CugC3u//K5QMqTkjeFLcpgXS0QVdbtDBI0xyh/2joM/2j9TRgEN/SpihLsfdVnwDQ1noFYnmjMrK8fUvbo3d0hu2n3c62z7zD6KquDM8M8Lfl4N3GTWLc7dW48ttH75jve1wmH6DmLZ66RCl/y/lKynKuLMyX4lVnyxUZtBuTnwA2THkU1R8OJsv61s+P3jT5NWK/XrXTy+6r5cOYKvG5qZieSHa8GEeHwjvh5aHkwzHm6VgMJZNYM9L+TUxpdrlzYb3JFT/xQRDDQA2PmaoSDN5sKqlxTgpXjhJmgRgfmPHwN9jeCOqXLcPEoZFbwAalEVrs5Q3PQn9GvJ4AAAAbF2UAAAAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

