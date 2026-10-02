module 0x3f7800f066e9db8a3de6fd68f4aa125b4d65d83415d4c0b3c01a4362cbd20370::made {
    struct MADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MADE>(arg0, 9, untag(b"SMADE"), untag(b"NSelfMade by SP3ND"), untag(b"D||{\"twitter\":\"https://x.com/SP3NDdotshop\",\"website\":\"https://x.com/i/communities/2005067297803960664\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreia2ulmjabkyqybmk25k4iw5z7dqoqnmneogd5if7t63mwkprwjyga"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MADE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MADE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MADE>>(0x2::coin::mint<MADE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

