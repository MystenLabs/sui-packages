module 0xf1675b799d856895741738abdc5a03259190fd3d439a7faf9db5883cd71fb5bc::merry {
    struct MERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERRY>(arg0, 9, b"MERRY", b"Sui Merry", b"I am from Songshan Baishui, and I am a top trader", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmQdbza7nugwRUkRWJc3L8AJLuyoArJ9EqkW3nTQJMgDeM?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MERRY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERRY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

