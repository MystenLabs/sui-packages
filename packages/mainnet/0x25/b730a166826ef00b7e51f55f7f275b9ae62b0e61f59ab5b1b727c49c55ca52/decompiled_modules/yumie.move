module 0x25b730a166826ef00b7e51f55f7f275b9ae62b0e61f59ab5b1b727c49c55ca52::yumie {
    struct YUMIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YUMIE>(arg0, 6, 0x1::string::utf8(b"YUMIE"), 0x1::string::utf8(b"Yummie"), 0x1::string::utf8(x"59554d4d59206973207468652073656c662d7265666c656374696f6e206f6620616c6c207468652079756d6d79206d65616c73206d616d6120707265706172656420666f722075732e0a0a546865206d65616c7320776520636f6e73756d6564207468726f756768206f75722065736f7068616775732c20646f776e20696e746f206f7572206162646f6d656e2e0a0a4e6f77206974e28099732074696d6520746f204255592059554d4d49452c20636f6e73756d652069742c20616e6420796f752077696c6c206c6f76652069742e0a0a2459554d4d5920e280942054616b65206120626974652c20456e6a6f792e"), 0x1::string::utf8(b"https://popularsui.xyz/media/35d4e3816650de1c2a7175891ab8882907b66f19d6efe8c5098c6c454e681412.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMIE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YUMIE>>(0x2::coin_registry::finalize<YUMIE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

