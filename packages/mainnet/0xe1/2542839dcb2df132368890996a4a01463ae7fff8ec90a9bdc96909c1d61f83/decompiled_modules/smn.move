module 0xe12542839dcb2df132368890996a4a01463ae7fff8ec90a9bdc96909c1d61f83::smn {
    struct SMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMN>(arg0, 6, b"SMN", b"Suizle My Nizzle", x"596f2c206974e2809973205375697a6c65204d79204e697a7a6c652c20776865726520776520666c697020636f696e7a7a6c65732c206d616b696ee2809920737461636b73206472697a7a6c652c20726964696ee280992074686174205375692066697a7a6c6521205769746820534d4e2c20796f75206b6e6f77206974e280997320746865207265616c2070757a7a6c652c2064726f7070696ee280992063727970746f2068656174206c696b652061206e6f7a7a6c652e20536f206772616220796f75722077616c6c65742c206d79206e697a7a6c652c20616e64206c6574e2809973206d616b65207468656d206761696e732073697a7a6c6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmekntpGV7MVAymRKLBNrvUoEtABSyKoWV3sncw3n8UieX")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SMN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SMN>(11449665655549329813, v0, v1, 0x1::string::utf8(b"https://x.com/SuizleMyNizzle"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/Suizle"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

