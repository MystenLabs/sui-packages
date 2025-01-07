module 0x9e944eeee2a0806b8d0201ee810d517851b6d85d16e00d6e5971331688a507ea::greenCUBE {
    struct GREENCUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENCUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENCUBE>(arg0, 9, b"CUBE", b"CUBE", b"It's cube. It's green. It's low cap, but safe. LP tokens - burned, Smartcontract - immutable.80% of token will be send to burn adress at the launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeihwzvulm4lxsqk62o5rg7o2sqwovgx4puglpc4dpjtplqw3pq76cm.ipfs.nftstorage.link/6ol23slcrh7.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREENCUBE>>(v1);
        0x2::coin::mint_and_transfer<GREENCUBE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENCUBE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

