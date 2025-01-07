module 0x34a6c8a3c37a54adf3635519faaea875e47ac8255ef695c82c863c31fb752760::suiwin {
    struct NFTnum has key {
        id: 0x2::object::UID,
        num: u16,
    }

    entry fun mint(arg0: &mut NFTnum, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            assert!(arg0.num < 10000, 1);
            arg0.num = arg0.num + 1;
            0x34a6c8a3c37a54adf3635519faaea875e47ac8255ef695c82c863c31fb752760::nfts::mint(*0x1::vector::borrow<address>(&arg1, v0), arg2);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTnum{
            id  : 0x2::object::new(arg0),
            num : 0,
        };
        0x2::transfer::transfer<NFTnum>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

