module 0xa7bd9d8ab511e747d68c1931b4794c2a4cc151e2d738dead0e966b85427d364c::babystonk {
    struct BABYSTONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSTONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSTONK>(arg0, 6, b"BABYSTONK", b"Baby Stonk sui", x"48692120496d20426162792053746f6e6b732c207468652074696e696573742066696e616e6369616c2067656e697573210a0a49206d6179207374696c6c20626520696e206d7920637269622c2062757420496d20616c7265616479206d616b696e6720626967206d6f7665732e204d79206d6f74746f3f20427579206c6f772c2064726f6f6c206869676821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_203913_903_0fcaa6db20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSTONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSTONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

