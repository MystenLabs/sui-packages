module 0xf0e31a65f298b722b660fa8445a4b5be6cfc1aaf561583dbc8e3af5801dd5be2::swb {
    struct SWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWB>(arg0, 6, b"SWB", b"Sui Water Bear", b"Water Bear on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_26_649b74aa82.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWB>>(v1);
    }

    // decompiled from Move bytecode v6
}

