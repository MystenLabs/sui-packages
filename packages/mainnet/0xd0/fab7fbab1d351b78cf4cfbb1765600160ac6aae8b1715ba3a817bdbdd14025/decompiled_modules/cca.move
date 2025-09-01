module 0xd0fab7fbab1d351b78cf4cfbb1765600160ac6aae8b1715ba3a817bdbdd14025::cca {
    struct CCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCA>(arg0, 6, b"CCA", b"CCA", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCA>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CCA>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

