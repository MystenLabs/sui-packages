module 0x1695671197d1e122ee818c1700499fa425c31f922bd4868aa4bfcdb14fa8ccbb::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 9, b"TST", b"Token Tester", b"Generated for test purpose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.kraken.com/marketing/web/icons-uni-webp/s_inj.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TST>(&mut v2, 1234567890000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v2, @0xa4dee7e7d6686865508d157f233d3203232efb9744843743704564b718f0dcf4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TST>>(v1);
    }

    // decompiled from Move bytecode v6
}

