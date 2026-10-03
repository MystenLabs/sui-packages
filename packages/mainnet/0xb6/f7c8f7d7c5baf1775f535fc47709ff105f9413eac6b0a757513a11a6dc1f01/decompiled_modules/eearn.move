module 0xb6f7c8f7d7c5baf1775f535fc47709ff105f9413eac6b0a757513a11a6dc1f01::eearn {
    struct EEARN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEARN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<EEARN>(arg0, 9, untag(b"SeEARN"), untag(b"NEmber Earn"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreigwhdvasx5keno3yv3j4tszuamiia6wiuigie6kanakws7aq3zgwi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<EEARN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<EEARN>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<EEARN>>(0x2::coin::mint<EEARN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

