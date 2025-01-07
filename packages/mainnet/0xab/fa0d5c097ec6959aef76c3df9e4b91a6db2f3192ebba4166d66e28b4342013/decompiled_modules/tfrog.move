module 0xabfa0d5c097ec6959aef76c3df9e4b91a6db2f3192ebba4166d66e28b4342013::tfrog {
    struct TFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFROG>(arg0, 6, b"TFROG", b"TurbosFrog", b"First Frog on Turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954563970.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

