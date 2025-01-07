module 0x6816c7143f0df453d37d4aebeb169678727447782a348a80f056565242c13642::suikon {
    struct SUIKON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKON>(arg0, 6, b"SUIKON", b"Kontol on Sui", b"Kontol searching for a nest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_12_at_21_55_59_a6fe271769.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKON>>(v1);
    }

    // decompiled from Move bytecode v6
}

