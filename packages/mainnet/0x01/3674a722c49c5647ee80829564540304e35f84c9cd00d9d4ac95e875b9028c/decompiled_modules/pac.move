module 0x13674a722c49c5647ee80829564540304e35f84c9cd00d9d4ac95e875b9028c::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"Paca", b"jaja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971014667.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

