module 0x76f666447c0480275b52cae4d2a16fa2e31893afad56375761ade431cc698ea4::nwif {
    struct NWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWIF>(arg0, 6, b"Nwif", b"Neuralinkwifdog", b"woof lets fly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_20_18_37_40_5fdfb54290.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

