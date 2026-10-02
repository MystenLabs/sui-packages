module 0xf3d3a6c71a149eaa3e2f3adb24deb14658459c9790ce202abc165399746b6349::shrub {
    struct SHRUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SHRUB>(arg0, 9, untag(b"SSHRUB"), untag(b"NLil' Shrub"), untag(b"D||{\"twitter\":\"https://x.com/lilshrub_RH\",\"website\":\"https://www.lilshrub.fun/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreibdpom3hcr5aaatumhy2rimfmk63sr73rssq5xgzmjwwe5y2rzy7i"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SHRUB>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SHRUB>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHRUB>>(0x2::coin::mint<SHRUB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

