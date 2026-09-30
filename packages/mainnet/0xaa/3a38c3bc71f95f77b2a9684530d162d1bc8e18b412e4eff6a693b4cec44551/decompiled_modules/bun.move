module 0xaa3a38c3bc71f95f77b2a9684530d162d1bc8e18b412e4eff6a693b4cec44551::bun {
    struct BUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BUN>(arg0, 9, untag(b"SBUN"), untag(b"NBundle Cat"), untag(b"D||{\"twitter\":\"https://x.com/BundleCatAI\",\"website\":\"https://mosh.trade/\",\"telegram\":\"https://t.me/moshtrade\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiehbt2u42j6naiyknsfln2w6545tegviavrw2njckmdgkcl5co7ra"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BUN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BUN>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUN>>(0x2::coin::mint<BUN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

