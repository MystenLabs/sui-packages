module 0x5676a3c4edd0de474d5afc56e06ece3386fd10b544d92dc72d059785e7c20f48::CHMMND {
    struct CHMMND has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHMMND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHMMND>(arg0, 9, 0x1::string::utf8(b"CHMMND"), 0x1::string::utf8(b"Chammmanda"), 0x1::string::utf8(b"Token Chammmanda deployed by user"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHMMND>>(0x2::coin_registry::finalize<CHMMND>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHMMND>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMMND>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMMND>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

