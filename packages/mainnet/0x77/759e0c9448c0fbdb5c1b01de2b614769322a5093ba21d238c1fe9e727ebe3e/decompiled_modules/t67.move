module 0x77759e0c9448c0fbdb5c1b01de2b614769322a5093ba21d238c1fe9e727ebe3e::t67 {
    struct T67 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T67, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T67>(arg0, 9, untag(b"S67"), untag(b"NThe Official 67 Coin"), untag(b"D||{\"twitter\":\"https://x.com/67officialpage\",\"website\":\"https://67coin.com\",\"telegram\":\"https://t.me/TheOfficial67Coin\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihiivfdhdju2a56kwxhnt3czvj4kft4n7z2u5labmltpbhrplq2ne"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<T67>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<T67>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T67>>(0x2::coin::mint<T67>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

