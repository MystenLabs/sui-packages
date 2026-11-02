module 0x4eb9258d7b76c8e371622dc44257ddb08be0161970dacb67308b08fedde8b898::wxcwx {
    struct WXCWX has drop {
        dummy_field: bool,
    }

    fun init(arg0: WXCWX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WXCWX>(arg0, 9, 0x1::string::utf8(b"WXCWX"), 0x1::string::utf8(b"wxcwx"), 0x1::string::utf8(b"ccxw"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WXCWX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<WXCWX>>(0x2::coin_registry::finalize<WXCWX>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

