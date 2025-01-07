module 0x4a2734415b838e29c36cbe21b0523b2c93cb6b00909e30a4e4ecbace72fa62b::sat {
    struct SAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAT>(arg0, 9, b"SAT", b"Satoshi", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAT>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

