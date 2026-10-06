module 0x8565a8b466c96f91ba53ddf211e46f94e463832d7bb0f7a0841b38875d683237::cfnh {
    struct CFNH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFNH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CFNH>(arg0, 9, untag(b"SCFNH"), untag(b"NCopper Finch"), untag(b"DA bird that hums in the morning"), untag(b"Ihttps://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/240px-PNG_transparency_demonstration_1.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CFNH>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CFNH>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CFNH>>(0x2::coin::mint<CFNH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

