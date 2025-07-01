module 0x285bdab7a780e632fbbf93dc087bc2a2728c2701c0f30bf531d2841d5b521c9c::bbn {
    struct BBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<BBN>(arg0, 6, b"BBN", b"bigben", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRpYCAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERFCTdsGTPiTLoV5RPQ/sVN3ir1WUDggWAIAAJAPAJ0BKoAAgAA+bTKWSSQioiEjErkYgA2JaQASDP5yYz2Yg+ORMqTbzDAXJrUQDoIWtRsL8+oATTMsLsybMB7gAGD2Lu60zQihQhduhtRlegRNG+uQODxxbnKqbP9VsVUhaUvXrrdRM3w2UDIZ+czPQPQ+pQZ7nTqKGohbhufUAdBC2QAA/vytEAAk25W8m7hS9UexuxSdEpJekyudXk1xij2f4BM+QShbn1ZKjCuHIFrKVU2zCLYJBbuurJEz2Y8QnPiJ9nWV/s+ICnzFcWP+AwlCc5XIzu44vewpy2OTnxkQyVMPYd95YbqeSqZJbdoF/SKbbgEOABTmt17UaclCM2CN9ocF2qSLZNtdzu9fxhOgIjMdt5ViYBK+YbbddX4LVtiUytAgC+RPOANbdzfj6+pqWYkgjlzx1Hdr4TCTCY7rwxtrOI+M3oGZ2P4vlLtxAvJ7aghyPh4xEhPdRoWUijoxiU3iSacBpF9CHZ8KldkWdvML4eoezPHCzUbCQ5zgCla6UwplxIHZnlQolOZ1emIZlOhql1rbIE20t6633E+xQJk5WWjInAqkGaYjBQuJOXvFI0E4MRcI6vZme4IR1KHeXgtfGtC6jcToax0y0Vfg+XE8jV1TwP9FQbS10dVuzVUtOKHyTE76dhEjbjVQ1x2tbCz/ztDCdu7sErWGSRVe6w5g6+F7YZDows+/rKCaA0CW1kmMt6qmRdLlRh7VkbP4b2uTFXmaeZBsVK4TCpgm/fHHFHjZkxOJerApJASYWm//UGteC+r9Iwkf9Q1wAAyjgAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

