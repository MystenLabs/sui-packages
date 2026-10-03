module 0x8da1bafe9fd018eeb12546c3fac5815c217ddb37fb61c30b943c47ef9e357488::harold {
    struct HAROLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAROLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HAROLD>(arg0, 9, untag(b"SHAROLD"), untag(b"NHarold"), untag(b"D||{\"twitter\":\"https://x.com/haroldsolmeme\",\"website\":\"https://harold.vip\",\"telegram\":\"https://t.me/RealHaroldCoin\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreifdfuebx5qpdzkqkcj3lwkdzaalfhgvbnijzhjjg6x3c6orsawyia"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<HAROLD>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<HAROLD>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HAROLD>>(0x2::coin::mint<HAROLD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

