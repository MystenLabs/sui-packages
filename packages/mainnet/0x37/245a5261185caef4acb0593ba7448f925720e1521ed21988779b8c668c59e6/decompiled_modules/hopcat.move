module 0x37245a5261185caef4acb0593ba7448f925720e1521ed21988779b8c668c59e6::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 9, b"HOPCAT", b"HopCat", b"First cat on Hop Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmWBx34wFTPcn8u2RbT74MgrKZFcbssptPYZWZhHQM3oVt"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
        0x2::coin::mint_and_transfer<HOPCAT>(&mut v2, 1000000000000000000, @0x7407ddd10e9255b45a6eea256c38177da1d344326e5de835a49e50f9f726234e, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOPCAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

