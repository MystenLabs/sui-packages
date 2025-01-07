module 0xe2ff05ec74dce1d9d0f0d25bc28954c36fc792792ab8785ef02a14b48a056723::logos {
    struct LOGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOGOS>(arg0, 6, b"LOGOS", b"LOGOS ", b"logos on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955619248.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOGOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOGOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

