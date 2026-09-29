module 0x2d241f1089ee9b44dedd19f008ae8447cd4fdf00164141d3e354166129c55041::ppp {
    struct PPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PPP>(arg0, 6, 0x1::string::utf8(b"PPP"), 0x1::string::utf8(b"PP Privacy"), 0x1::string::utf8(x"4c657427732067657420746970706564206f6e2073747265616d2e20416c6c20746f6b656e20686f6c646572732077696c6c20626520746970706564206f6e206c6976652073747265616d207573696e672073687566666c652e200a4f637420312061742037706d20455354206f6e204b69636b3a206b69636b2e636f6d2f70702d707269766174656a6574"), 0x1::string::utf8(b"https://popularsui.xyz/media/cf4e11abdccf2a519ba6d711bef59aab783ee79743ec4b7c1dd9875b19f03484.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PPP>>(0x2::coin_registry::finalize<PPP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

