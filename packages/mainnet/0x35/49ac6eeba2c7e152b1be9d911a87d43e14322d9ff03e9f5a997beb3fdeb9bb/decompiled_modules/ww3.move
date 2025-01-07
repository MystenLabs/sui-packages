module 0x3549ac6eeba2c7e152b1be9d911a87d43e14322d9ff03e9f5a997beb3fdeb9bb::ww3 {
    struct WW3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW3>(arg0, 6, b"WW3", b"Worldwar on Sui", b"Don't you dare hit that button! We mean it. Just don't!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coin_e7368be45f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WW3>>(v1);
    }

    // decompiled from Move bytecode v6
}

