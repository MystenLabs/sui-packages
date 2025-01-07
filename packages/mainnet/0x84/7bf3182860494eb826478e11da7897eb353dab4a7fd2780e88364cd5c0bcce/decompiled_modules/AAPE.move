module 0x847bf3182860494eb826478e11da7897eb353dab4a7fd2780e88364cd5c0bcce::AAPE {
    struct AAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAPE>(arg0, 2, b"AAPE", b"AAPE", b"Official by AAPE, APE gonna APE this shit!!!, https://aape.jp/, https://twitter.com/AAPE_OFFICIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/4x8Gd24g/aape.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAPE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAPE>(&mut v2, 10000000000, @0x4e425e8844bc8d0e9de6c6d1e096d1c2d1724a2f4873489a7e95e1a513bb30af, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAPE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

