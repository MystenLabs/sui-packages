module 0xc6d27d40e74bc0438314218d87031ffd6a70147b6310c2a5c14973c5ed30d8e3::cashcat {
    struct CASHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASHCAT>(arg0, 9, b"CASHCAT", b"CASHCAT", b"CashCAT On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1784581083952-6102f16dc75ff59f83213217f695dc49.jpeg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CASHCAT>>(0x2::coin::mint<CASHCAT>(&mut v2, 21000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CASHCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASHCAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

