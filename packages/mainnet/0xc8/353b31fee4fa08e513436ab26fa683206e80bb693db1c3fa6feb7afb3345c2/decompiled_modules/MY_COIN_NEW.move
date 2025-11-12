module 0xc8353b31fee4fa08e513436ab26fa683206e80bb693db1c3fa6feb7afb3345c2::MY_COIN_NEW {
    struct MY_COIN_NEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_COIN_NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MY_COIN_NEW>(arg0, 9, 0x1::string::utf8(b"SLERF"), 0x1::string::utf8(b"slerf"), 0x1::string::utf8(b"slerftools"), 0x1::string::utf8(b"https://slerf.tools/img/menu/help.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN_NEW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MY_COIN_NEW>>(0x2::coin_registry::finalize<MY_COIN_NEW>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

