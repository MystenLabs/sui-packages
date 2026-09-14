module 0xcbb8e653007b2ed30676c554cc4642a151c501c323dbf08ac08e5d7748e08770::strompepe {
    struct STROMPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STROMPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STROMPEPE>(arg0, 9, untag(b"SSTROMPEPE"), untag(b"NStromPepe"), untag(b"Dthe first pepe on strom and sui"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeibdlldp3phzerhporl5yeikaalidu56glb4zga5gvbu47fzsa75qu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<STROMPEPE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<STROMPEPE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STROMPEPE>>(0x2::coin::mint<STROMPEPE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

