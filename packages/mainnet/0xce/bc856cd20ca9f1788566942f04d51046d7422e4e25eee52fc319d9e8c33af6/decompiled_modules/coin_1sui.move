module 0xcebc856cd20ca9f1788566942f04d51046d7422e4e25eee52fc319d9e8c33af6::coin_1sui {
    struct COIN_1SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_1SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<COIN_1SUI>(arg0, 9, untag(b"S1SUI"), untag(b"Njust buy 1 SUI"), untag(b"D1SUI is all you need"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeidxqegdx7otxowvdimmc2klvgs34qjdi4oo7fq2cs6iz5dbrnafmq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<COIN_1SUI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<COIN_1SUI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN_1SUI>>(0x2::coin::mint<COIN_1SUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

