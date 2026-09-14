module 0x3e34469a6193d940367a4b006b5c6c76499e1ee825aa3d8dc460be31faec8f82::karat {
    struct KARAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<KARAT>(arg0, 9, untag(b"SKARAT"), untag(b"NkaRAT"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreif575pr3trhaiqwbwcpi4eu6fotl2p2hzhufikc5gkylmp6ow7wai"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<KARAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<KARAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KARAT>>(0x2::coin::mint<KARAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

