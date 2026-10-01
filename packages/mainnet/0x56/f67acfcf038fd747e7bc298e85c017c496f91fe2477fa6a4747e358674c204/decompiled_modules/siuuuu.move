module 0x56f67acfcf038fd747e7bc298e85c017c496f91fe2477fa6a4747e358674c204::siuuuu {
    struct SIUUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SIUUUU>(arg0, 6, 0x1::string::utf8(b"SIUUUU"), 0x1::string::utf8(b"SIUUUU!"), 0x1::string::utf8(x"534955555555206973206e6f74206a75737420612063656c6562726174696f6e2c20697427732061207374617465206f66206d696e642e0a426f726e206f6e205375692c20706f77657265642062792070757265206d656d6520656e657267792e204e6f20636f6d706c696361746564207574696c6974792c206e6f2070726f6d697365732c206a75737420636f6d6d756e6974792c2076696265732c20616e6420746865206c6f756465737420534955555555206f6e2d636861696e20f09f92a7"), 0x1::string::utf8(b"https://popularsui.xyz/media/35b069eb05d639311e074a7808610d9ef20eea2e129277c7c91340ea364729a9.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUUU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SIUUUU>>(0x2::coin_registry::finalize<SIUUUU>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

