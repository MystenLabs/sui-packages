module 0xa588c02b001289c99658862f5b1c6da36ea3db6de29384a56e37499ca24c64fb::isg {
    struct ISG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ISG>(arg0, 9, untag(b"SISG"), untag(b"NInfinite Strom Glitch"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeicay5js62zij5cc6fwcyl4ru7y32xtemsg2g4sk27itdmwggs4pti"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ISG>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ISG>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ISG>>(0x2::coin::mint<ISG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

