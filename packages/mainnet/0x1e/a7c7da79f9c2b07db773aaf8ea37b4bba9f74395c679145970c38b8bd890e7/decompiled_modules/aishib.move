module 0x1ea7c7da79f9c2b07db773aaf8ea37b4bba9f74395c679145970c38b8bd890e7::aishib {
    struct AISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISHIB>(arg0, 9, b"AISHIB", b"Sui AIShib", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AISHIB>(&mut v2, 10000000000000000, @0x7591d6ebaede87a72cfad83f8dab080a96cf6b9517176dbfa5c362c7c245da72, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISHIB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

