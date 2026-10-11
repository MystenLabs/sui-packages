module 0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::ion {
    struct ION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ION>(arg0, 7, 0x1::string::utf8(b"ION"), 0x1::string::utf8(b"ION"), 0x1::string::utf8(b"ION is the crafting in-game currency for Cyberbrawl."), 0x1::string::utf8(b"https://static.cyberbrawl.io/ion_logo_512.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ION>>(0x2::coin_registry::finalize<ION>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ION>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

