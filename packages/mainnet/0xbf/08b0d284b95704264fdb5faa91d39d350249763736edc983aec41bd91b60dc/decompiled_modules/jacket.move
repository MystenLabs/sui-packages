module 0xbf08b0d284b95704264fdb5faa91d39d350249763736edc983aec41bd91b60dc::jacket {
    struct JACKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<JACKET>(arg0, 6, 0x1::string::utf8(b"JACKET"), 0x1::string::utf8(b"Evan Jacket"), 0x1::string::utf8(b"The famous Evan Jacket"), 0x1::string::utf8(b"https://popularsui.xyz/media/0d486014d45d45d3b5766c7b18f176ed2299770a36fecd015ce0e24275168bdf.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKET>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<JACKET>>(0x2::coin_registry::finalize<JACKET>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

