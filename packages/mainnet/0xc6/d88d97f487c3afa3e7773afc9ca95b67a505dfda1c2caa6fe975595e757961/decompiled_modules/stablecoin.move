module 0xc6d88d97f487c3afa3e7773afc9ca95b67a505dfda1c2caa6fe975595e757961::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STABLECOIN>(arg0, 6, 0x1::string::utf8(b"GALLEON"), 0x1::string::utf8(b"GALLEON"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://github.com/withbridge/token-metadata/blob/main/public/images/galleon.png"), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<STABLECOIN>>(0x2::coin_registry::finalize<STABLECOIN>(v2, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<STABLECOIN>>(0x2::coin_registry::make_regulated<STABLECOIN>(&mut v2, true, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STABLECOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

