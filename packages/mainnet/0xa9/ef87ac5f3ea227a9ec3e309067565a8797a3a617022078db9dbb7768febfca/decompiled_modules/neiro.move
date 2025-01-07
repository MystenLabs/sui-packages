module 0xa9ef87ac5f3ea227a9ec3e309067565a8797a3a617022078db9dbb7768febfca::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 9, b"NEIRO", b"Sui Neiro", b"First Neiro On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=150,fit=crop,q=95/d95KMvqO2DcVb6x1/group-3-copy-m5KwPKqjj9fQ0v0L.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEIRO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

