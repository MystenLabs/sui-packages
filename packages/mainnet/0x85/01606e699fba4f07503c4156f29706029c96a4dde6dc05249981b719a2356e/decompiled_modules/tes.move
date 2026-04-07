module 0x8501606e699fba4f07503c4156f29706029c96a4dde6dc05249981b719a2356e::tes {
    struct TES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<TES>(arg0, 6, b"TES", b"Test ", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRjgBAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERFCTdsGTPmTLoR9RPQ/IZ/3D/lWUDgg+gAAAJAJAJ0BKoAAgAA+bTaaSSQjIqEiGAhogA2JaW7dJe1oqwmnnLjZiF7ILGFiI72XMV3+P/NLHWbhSgtaCeFfOE/JuW+mSuMPu192F4cFFb511kFbagAA/vv9XNUIot547BZBsz9GqSwjCMnVtBjhtPmXJ120h6Lx3XegtpufKntBHTZWP7raiCgP/dbf736ntxCi92n5jHA3DoQgRFSHO0h/z7Y0O4f8DpnldNbrCn7S7Yj2hKPgMRrYxlbXJkf7Ex7H2o9DBxAAG2uRqbwKqAETXAVbYQzh9bu9ZvshwKviSmQPYM286zYlz5JsIxxPasHnAABO7tQAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TES>>(v1);
    }

    // decompiled from Move bytecode v6
}

