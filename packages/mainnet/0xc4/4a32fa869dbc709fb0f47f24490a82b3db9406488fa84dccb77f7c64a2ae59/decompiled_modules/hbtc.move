module 0xc44a32fa869dbc709fb0f47f24490a82b3db9406488fa84dccb77f7c64a2ae59::hbtc {
    struct HBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HBTC>(arg0, 9, untag(b"SHBTC"), untag(b"NHashi BTC"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreicudfknqjrdqosek5td7dqu4fk6nkgz4ormyfbbsjskbn57cgycdq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<HBTC>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<HBTC>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HBTC>>(0x2::coin::mint<HBTC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

