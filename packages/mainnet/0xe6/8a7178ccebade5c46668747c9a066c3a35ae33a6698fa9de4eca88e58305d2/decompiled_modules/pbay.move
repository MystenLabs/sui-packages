module 0xe68a7178ccebade5c46668747c9a066c3a35ae33a6698fa9de4eca88e58305d2::pbay {
    struct PBAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PBAY>(arg0, 9, 0x1::string::utf8(b"PBAY"), 0x1::string::utf8(b"PredictBay Token"), 0x1::string::utf8(b"Token of PredictBay (predictbay.io), a prediction market on Sui. Capped supply of 1,000,000,000 PBAY: minting is permanently disabled and holders may burn."), 0x1::string::utf8(b"https://predictbay.io/brand/pbay-token-512.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PBAY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PBAY>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PBAY>>(0x2::coin::mint<PBAY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

