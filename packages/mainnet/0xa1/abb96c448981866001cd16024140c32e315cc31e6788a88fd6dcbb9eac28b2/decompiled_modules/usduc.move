module 0xa1abb96c448981866001cd16024140c32e315cc31e6788a88fd6dcbb9eac28b2::usduc {
    struct USDUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<USDUC>(arg0, 9, untag(b"SUSDUC"), untag(b"NUnstable Coin"), untag(b"D||{\"twitter\":\"https://x.com/usduc_official\",\"website\":\"https://www.usduc.io/\",\"telegram\":\"https://t.me/USDUC_safeguard\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihkfet4p5vaaunvtbqlfgluol737u6s3gysbqb64tryoxwkxfnac4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<USDUC>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<USDUC>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDUC>>(0x2::coin::mint<USDUC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

