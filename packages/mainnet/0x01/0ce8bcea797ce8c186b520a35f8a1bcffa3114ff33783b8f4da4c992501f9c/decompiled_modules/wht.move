module 0x10ce8bcea797ce8c186b520a35f8a1bcffa3114ff33783b8f4da4c992501f9c::wht {
    struct WHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<WHT>(arg0, 6, b"WHT", b"white-test", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRpgAAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERFCTdsGTPiTLoV5RPQ/sV/3h/1WUDggWgAAAHAHAJ0BKoAAgAA+bTKVR6QjIiEoiACADYlpbuFx0AUKUv/6tJGJoM4fodmfEpgAK1+4dmfEpgAKvua5ZvQaxkArX60AAP7/RA1M3//+39gAfHUP//+3bAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

