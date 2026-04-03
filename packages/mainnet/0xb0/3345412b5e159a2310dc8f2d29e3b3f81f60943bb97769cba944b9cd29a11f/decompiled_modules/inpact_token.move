module 0xb03345412b5e159a2310dc8f2d29e3b3f81f60943bb97769cba944b9cd29a11f::inpact_token {
    struct INPACT_TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<INPACT_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<INPACT_TOKEN>>(0x2::coin::mint<INPACT_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: INPACT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<INPACT_TOKEN>(arg0, 6, 0x1::string::utf8(b"INPACT"), 0x1::string::utf8(b"SuiInpact Token"), 0x1::string::utf8(b"Payment token for SuiInpact escrow settlements"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INPACT_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<INPACT_TOKEN>>(0x2::coin_registry::finalize<INPACT_TOKEN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

