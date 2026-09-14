module 0xa6fedb90075d1482d0b6fc638c6e81bd5dca57b4d89bb7ee882c32cc2fca7169::nutsaq {
    struct NUTSAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTSAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NUTSAQ>(arg0, 9, untag(b"SNUTSAQ"), untag(b"NNUTSAQ100"), untag(x"445468652062696767657374207361636b206f6e205355492e0a4e555453415131303020697320746865206d656d6520636f696e206275696c7420666f7220746865205355492067656e65726174696f6e2e20206c61756e6368696e67206f6e204d61656c7374726f6d20696e20746865205355492065636f73797374656d2c207061697265642077697468205355492c2077697468203225206f6620616c6c2074726164696e672066656573206f6e20746865206e6574776f726b207061696420696e20535549206469726563746c7920746f20686f6c646572732e"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeibqa75tswfkvdi6yqxtkbkbnpmab5kxpuqsxf5zintzb4ev4p6j5i"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<NUTSAQ>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<NUTSAQ>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<NUTSAQ>>(0x2::coin::mint<NUTSAQ>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

