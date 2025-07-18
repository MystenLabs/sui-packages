module 0xe5de9e770b3e109dee32fd323cd26bd9c3bb746b8998afb8806f735f938f55a0::a45 {
    struct A45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A45, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DtSj6nJMwMttFCcvmjPn16yTweqXP7pH6necQaM6mn5y.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<A45>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"A45         ")))), trim_right(b"Trump Star Aussie               "), trim_right(x"4d616b696e67204d656d657320262043727970746f20477265617420416761696e210a0a4d656574204175737369652020746865206465636b65642d6f75742c20676f6c64656e2d6c6f636b6564206d656d6520636f6d6d616e64657220696e206120737569742c206c656164696e6720746865206e6578742077617665206f6620536f6c616e61206d656d65636f696e206d616e69612e20244134352069736e74206a757374206120636f696e202069747320612066756c6c2d626c6f776e206d6f76656d656e7420706f776572656420627920707572706f73652c20706177732c20616e64207075726520687970652e0a0a204d6173636f742d706f7765726564206279204175737369652c207468652066616365206f6620506574436f696e2041490a204275696c7420666f72206d656d65732c206d61646520666f72"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A45>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A45>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

