module 0x7721f41370267b3a2fb57938a5acf2bbb23b84cccaba918d433ac9b3d03cf6c0::yee {
    struct YEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YEE>(arg0, 9, untag(b"SYEE"), untag(b"NYee Token"), untag(b"D||{\"twitter\":\"https://x.com/YeeErc20\",\"website\":\"https://yeetoken.vip/\",\"telegram\":\"https://t.me/yeeogmeme\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiadkncuuo2zw5ayb5ips3lkox7nvm5favag23emond6e2jjo4qqle"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<YEE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<YEE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<YEE>>(0x2::coin::mint<YEE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

