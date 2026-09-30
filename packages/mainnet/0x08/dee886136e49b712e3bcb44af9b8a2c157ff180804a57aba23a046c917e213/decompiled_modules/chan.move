module 0x8dee886136e49b712e3bcb44af9b8a2c157ff180804a57aba23a046c917e213::chan {
    struct CHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHAN>(arg0, 6, 0x1::string::utf8(b"CHAN"), 0x1::string::utf8(b"Crayon shin"), 0x1::string::utf8(x"4a757374206c696b65205368696e2d6368616e2c2074686520746f6b656e20697320756e7072656469637461626c652c2068696c6172696f75732c20616e6420696d706f737369626c6520746f2069676e6f72652e205768656e20746865206d61726b6574206765747320736572696f75732c20245348494e2073686f7773207570207769746820612064616e63652c2061206a6f6b652c20616e642061206d6f6f6e6261672066756c6c206f662074726f75626c652e0a546869732069736e2774206a757374206120746f6b656e2e0a49742773206368696c646c696b65206368616f7320776561706f6e697a6564"), 0x1::string::utf8(b"https://popularsui.xyz/media/f0880e038238bb8c2646fd24d16dbdcd4aaaac8c793eb093129416e451e5d5cb.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHAN>>(0x2::coin_registry::finalize<CHAN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

