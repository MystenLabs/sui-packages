module 0x240260c6a5fb21f01c0f3945902112ee7d894298ec4801629602c7a0ac00b00a::pengu_rich {
    struct PENGU_RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU_RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU_RICH>(arg0, 9, b"Pengu", b"Pengu Rich", b"Pengu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775540202779-1825ee330ccc14c7696211e118b359ec.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PENGU_RICH>>(0x2::coin::mint<PENGU_RICH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU_RICH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU_RICH>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

