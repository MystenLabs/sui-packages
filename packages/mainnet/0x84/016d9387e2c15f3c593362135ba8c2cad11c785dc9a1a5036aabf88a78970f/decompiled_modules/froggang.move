module 0x84016d9387e2c15f3c593362135ba8c2cad11c785dc9a1a5036aabf88a78970f::froggang {
    struct FROGGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGANG>(arg0, 6, b"FrogGang", b"SUI FROG GANG", x"53747261696768742066726f6d20746865206d7973746963616c20506f6e64206f6620457465726e6974792c206d65657420746865205375692047616e672047616e67204e6f74206a7573742066726f6773726562656c732c20647265616d6572732c20616e6420626c6f636b636861696e2077617272696f72732e0a546865797265206865726520746f20646973727570742c20696e6e6f766174652c20616e64207669626520696e207374796c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_3_removebg_preview_e96c85f93a_6928668d26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

