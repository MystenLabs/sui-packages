module 0x71ff7edd84c5e4689f2885cce361b58a8ac9fabc6384ca79049019e57c8893b1::bandit {
    struct BANDIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDIT>(arg0, 6, b"BANDIT", b"Le Bandit Official", b"Not a rug. A Heist. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1766810568671.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANDIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

