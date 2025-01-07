module 0x4555d9f1ac6939e37a891f88c041ac8f0df117b46ec78c67a0ad67c2294c6f4f::HOPI {
    struct HOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPI>(arg0, 2, b"HOPI", b"Hopi", b"The hilariously clueless hippo who always gets into ridiculous jungle mishaps!, https://twitter.com/hopionsui, https://hopionsui.xyz/, https://t.me/hopiumhopi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/xCN0Y7xx/Hopi.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPI>(&mut v2, 100000000000000, @0xdd08da1f147238ce1c5d4581cad137ae6ccbe3084f5d3f0f7f65b0ca1ad5385a, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

