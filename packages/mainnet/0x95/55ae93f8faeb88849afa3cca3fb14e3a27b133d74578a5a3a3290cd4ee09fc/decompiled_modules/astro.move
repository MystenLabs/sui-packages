module 0x9555ae93f8faeb88849afa3cca3fb14e3a27b133d74578a5a3a3290cd4ee09fc::astro {
    struct ASTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ASTRO>(arg0, 9, untag(b"SASTRO"), untag(b"Nastronaut"), untag(b"D||{\"twitter\":\"https://x.com/astronautonrh\",\"website\":\"https://www.astronautonrh.space/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiabpwdh7pexk2lemzmsdzhtrbh5ljg3smwz7zynwpkz6d72iw7qeq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ASTRO>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ASTRO>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ASTRO>>(0x2::coin::mint<ASTRO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

