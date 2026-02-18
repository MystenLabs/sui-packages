module 0xe7b02cea4510bb39a11b30aca9756ddaa57bcbfbb3ff0019648ef6e309bfff49::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<OCEAN>(arg0, 9, 0x1::string::utf8(b"OCN"), 0x1::string::utf8(b"Ocean"), 0x1::string::utf8(b"Ocean Token"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<OCEAN>>(0x2::coin::mint<OCEAN>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OCEAN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<OCEAN>>(0x2::coin_registry::finalize<OCEAN>(v0, arg1));
    }

    // decompiled from Move bytecode v6
}

