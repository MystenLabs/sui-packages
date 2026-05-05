module 0x29cf3276d2ec93abf92f9c260a6e31ad569c3a6edd1d4f0c0ad16df41b8d998b::bfs {
    struct BFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<BFS>(arg0, 6, b"BFS", b"Bule Fish Sui", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRpQAAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBcAAAABDzD/ERGCTNom/k33m4NBRP8ngGb+HgBWUDggVgAAALAGAJ0BKoAAgAA+bTaZSaQjIqEgiACADYlpbt0AAd0XiE5iftMXtLVYUqSCP2AgKk/u4rnleeQR+wEBWE6AAP77nv2I7RSmgxWKzsphQAAAABBYAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

