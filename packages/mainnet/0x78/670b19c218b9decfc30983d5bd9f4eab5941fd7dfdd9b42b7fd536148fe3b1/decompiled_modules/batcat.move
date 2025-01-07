module 0x78670b19c218b9decfc30983d5bd9f4eab5941fd7dfdd9b42b7fd536148fe3b1::batcat {
    struct BATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATCAT>(arg0, 6, b"BATCAT", b"BATCAT AI", b"BATCAT is an unique memecoin that blends fun with functionality.Inspired by the need for more security in the crypto space, BATCAT is on a mission to fight scams and rug pulls on Sui and others.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736263534407.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BATCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

