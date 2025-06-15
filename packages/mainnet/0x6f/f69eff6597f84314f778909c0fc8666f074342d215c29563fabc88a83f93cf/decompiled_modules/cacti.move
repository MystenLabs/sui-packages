module 0x6ff69eff6597f84314f778909c0fc8666f074342d215c29563fabc88a83f93cf::cacti {
    struct CACTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTI>(arg0, 6, b"CACTI", b"SUI-YOTE", b"Enlightenment is imminent within the walls of this community. A drop of water is all you need......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749968704334.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CACTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACTI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

