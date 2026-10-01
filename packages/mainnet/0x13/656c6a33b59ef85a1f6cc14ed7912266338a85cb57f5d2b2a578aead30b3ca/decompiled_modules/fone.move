module 0x13656c6a33b59ef85a1f6cc14ed7912266338a85cb57f5d2b2a578aead30b3ca::fone {
    struct FONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FONE>(arg0, 9, untag(b"SFONE"), untag(b"Napeonfone"), untag(b"D||{\"twitter\":\"https://x.com/apeonfone\",\"website\":\"https://apeonfone.com\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreibfdg6ue4yq4eihkbz6lmsy2bhb6juxf3mt5y33fqzoomvovyjfbm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<FONE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<FONE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FONE>>(0x2::coin::mint<FONE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

