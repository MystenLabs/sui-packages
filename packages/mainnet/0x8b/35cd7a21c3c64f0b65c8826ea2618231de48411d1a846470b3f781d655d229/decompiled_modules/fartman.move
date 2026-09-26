module 0x8b35cd7a21c3c64f0b65c8826ea2618231de48411d1a846470b3f781d655d229::fartman {
    struct FARTMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FARTMAN>(arg0, 6, 0x1::string::utf8(b"Fartman"), 0x1::string::utf8(b"Fartman"), 0x1::string::utf8(x"24466172746d616e202d205468652053756920536861706573686966746572e28094616e7920636f696e2c20616e7920666f726d2c206f6e652065636f73797374656d2e"), 0x1::string::utf8(b"https://i.postimg.cc/wvxqmgLX/IMG-4375.jpg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTMAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FARTMAN>>(0x2::coin_registry::finalize<FARTMAN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

