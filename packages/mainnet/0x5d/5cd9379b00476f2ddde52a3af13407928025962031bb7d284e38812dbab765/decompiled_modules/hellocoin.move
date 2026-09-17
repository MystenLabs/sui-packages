module 0x5d5cd9379b00476f2ddde52a3af13407928025962031bb7d284e38812dbab765::hellocoin {
    struct HELLOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLOCOIN>(arg0, 6, b"HelloCoin", b"hello", b"sfsaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1789656122411.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLOCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLOCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

