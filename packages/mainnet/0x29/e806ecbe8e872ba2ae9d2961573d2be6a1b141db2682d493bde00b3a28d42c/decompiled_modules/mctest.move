module 0x29e806ecbe8e872ba2ae9d2961573d2be6a1b141db2682d493bde00b3a28d42c::mctest {
    struct MCTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCTEST>(arg0, 6, b"MCtest", b"Matcha", b"abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1762834479635.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

