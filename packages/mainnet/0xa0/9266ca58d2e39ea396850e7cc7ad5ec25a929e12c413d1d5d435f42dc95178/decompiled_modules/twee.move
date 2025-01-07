module 0xa09266ca58d2e39ea396850e7cc7ad5ec25a929e12c413d1d5d435f42dc95178::twee {
    struct TWEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWEE>(arg0, 6, b"TWEE", b"Twee", b"Twee envisions a blockchain-powered world where environmental care and community engagement go hand in hand. We aim to build a project that not only spreads joy but also inspires meaningful change, starting with tree planting initiatives and growing into a global movement. BUY only what you can afford to DONATE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TWEE_01_af1fc13582.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

