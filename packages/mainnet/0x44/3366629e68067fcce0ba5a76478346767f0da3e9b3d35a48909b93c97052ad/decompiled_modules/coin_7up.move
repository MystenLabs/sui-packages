module 0x443366629e68067fcce0ba5a76478346767f0da3e9b3d35a48909b93c97052ad::coin_7up {
    struct COIN_7UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_7UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<COIN_7UP>(arg0, 6, 0x1::string::utf8(b"7UP"), 0x1::string::utf8(b"7up"), 0x1::string::utf8(x"3755502069736ee2809974206a7573742061206e616d6520e28094206974e28099732061206d696e647365742e0a37206c6576656c732c2037206368616e6365732c203720726561736f6e7320746f206b65657020636c696d62696e672e0a4e6f20646f776e2e204e6f20726576657273652e204e6f20657863757365732e0a4a7573742055502e2055502e2055502e2055502e2055502e2055502e2055502e20f09f9a80"), 0x1::string::utf8(b"https://popularsui.xyz/media/70f65202696f05d4ea56b85d66b9bcfc1e0dc604741df714bb152d8215bad36b.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_7UP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<COIN_7UP>>(0x2::coin_registry::finalize<COIN_7UP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

