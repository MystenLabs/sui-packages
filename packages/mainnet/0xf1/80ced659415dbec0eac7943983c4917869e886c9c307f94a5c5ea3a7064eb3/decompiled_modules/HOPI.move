module 0xf180ced659415dbec0eac7943983c4917869e886c9c307f94a5c5ea3a7064eb3::HOPI {
    struct HOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPI>(arg0, 2, b"HOPI", b"Hopi", b"The hilariously clueless hippo who always gets into ridiculous jungle mishaps!, https://twitter.com/hopionsui, https://hopionsui.xyz/, https://t.me/hopiumhopi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/xCN0Y7xx/Hopi.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPI>(&mut v2, 100000000000000, @0xaecce549adcdaf785dd824e1936c87157f90f3b67a40f329479255c56de8fafb, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

