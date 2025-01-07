module 0x46f6e71282f14b9aea454d9dc8909ba635edbcffaefd093b1505c7c0caa78a58::itsfine {
    struct ITSFINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITSFINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITSFINE>(arg0, 6, b"ITSFINE", b"It's fine", b"It's fine on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_e001b683a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITSFINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITSFINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

