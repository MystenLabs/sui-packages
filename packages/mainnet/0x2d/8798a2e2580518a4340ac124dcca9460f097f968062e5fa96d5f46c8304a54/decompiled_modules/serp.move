module 0x2d8798a2e2580518a4340ac124dcca9460f097f968062e5fa96d5f46c8304a54::serp {
    struct SERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SERP>(arg0, 9, untag(b"SSERP"), untag(b"NSerpent SUI"), untag(b"DThe Serpent on SUI, exclusively on SUI."), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreiaioocdndqrwk2mwep24sr3pniv5qezzelr2mck73hybsybixbs5e"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SERP>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SERP>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SERP>>(0x2::coin::mint<SERP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

