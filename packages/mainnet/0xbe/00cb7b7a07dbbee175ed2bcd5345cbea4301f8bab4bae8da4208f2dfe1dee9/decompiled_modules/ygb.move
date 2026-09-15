module 0xbe00cb7b7a07dbbee175ed2bcd5345cbea4301f8bab4bae8da4208f2dfe1dee9::ygb {
    struct YGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: YGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YGB>(arg0, 9, untag(b"SYGB"), untag(b"NYagball"), untag(b"DJust like Egg"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreids6i7uikb53m4k7gbe7oksaygaxez4cdgix4ubsc5sfzyenqz3vq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<YGB>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<YGB>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<YGB>>(0x2::coin::mint<YGB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

