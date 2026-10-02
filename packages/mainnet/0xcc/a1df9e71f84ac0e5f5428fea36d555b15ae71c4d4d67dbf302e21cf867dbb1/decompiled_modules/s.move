module 0xcca1df9e71f84ac0e5f5428fea36d555b15ae71c4d4d67dbf302e21cf867dbb1::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<S>(arg0, 9, untag(b"SS"), untag(b"NAgent S"), untag(b"D||{\"twitter\":\"https://x.com/0xAgent_S\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreig2iyxjcytwgsrcr2dgixaduuppu7rv73i7xdvpzpaqce3wbququa"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<S>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<S>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<S>>(0x2::coin::mint<S>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

