module 0x6f05bd7973db98ea9482923d5d7aec04bdce1310ef53fffa740f77377ea43602::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PENGU>(arg0, 9, untag(b"SPENGU"), untag(b"NPudgy Penguins"), untag(b"D||{\"twitter\":\"https://x.com/pudgypenguins\",\"website\":\"https://pengu.pudgypenguins.com/\",\"telegram\":\"https://t.me/pengutg\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreifjvcrxshhh6zve4h572uqbjprgr7kobm2zwdp4wyqaddktqqa3ga"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PENGU>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PENGU>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PENGU>>(0x2::coin::mint<PENGU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

