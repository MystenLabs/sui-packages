module 0x8283363ee065a0d4139cf26ea50d5d3c7591593621da27855b890aae69265cba::suisaz {
    struct SUISAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUISAZ>(arg0, 6, 0x1::string::utf8(b"SAZ"), 0x1::string::utf8(b"SUISAZ"), 0x1::string::utf8(b"SUISAZ (SAZ) is a fixed-supply digital asset deployed on the Sui blockchain. The total supply is permanently capped at 1,000,000,000 SAZ with no minting or burning functionality. Designed as a transparent and utility-driven ecosystem token within the Sui network."), 0x1::string::utf8(b"https://suisaz.com/logo.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<SUISAZ>(&mut v3, v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISAZ>>(0x2::coin::mint<SUISAZ>(&mut v2, 1000000000000000, arg1), v4);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUISAZ>>(0x2::coin_registry::finalize<SUISAZ>(v3, arg1), v4);
    }

    // decompiled from Move bytecode v6
}

