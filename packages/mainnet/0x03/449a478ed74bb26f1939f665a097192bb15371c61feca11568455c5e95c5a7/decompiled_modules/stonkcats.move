module 0x3449a478ed74bb26f1939f665a097192bb15371c61feca11568455c5e95c5a7::stonkcats {
    struct STONKCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STONKCATS>(arg0, 9, untag(b"SSTONKCATS"), untag(b"NStonk Cats"), untag(b"D||{\"twitter\":\"https://x.com/stonkcatsnft\",\"website\":\"https://stonkcats.xyz\",\"telegram\":\"https://t.me/stonkcatssol\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreid6l5a5gsbn44lht2wq6wsl7lp74pwjr7bautcazahclfmv5j57hy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<STONKCATS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<STONKCATS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STONKCATS>>(0x2::coin::mint<STONKCATS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

