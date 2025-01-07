module 0x27f7b61115c7af12a19912fdf25119f79fc32636eea9f7dbd7c99e7c747dab14::collection {
    struct Foxiverse has store, key {
        id: 0x2::object::UID,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public entry fun create_collection_display_entry(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0x923583a7ff785bd4466d1ad1537b2ee430f50e1d01906094f890e4736e3991e2::bridge::SharedPublisher, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Foxiverse>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(1 == 0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get_by_T<COLLECTION>(arg0), 1000);
        0x2::transfer::public_transfer<0x2::display::Display<0x923583a7ff785bd4466d1ad1537b2ee430f50e1d01906094f890e4736e3991e2::bridge::NFT<Foxiverse>>>(0x923583a7ff785bd4466d1ad1537b2ee430f50e1d01906094f890e4736e3991e2::bridge::create_display<Foxiverse>(arg0, arg2, arg1, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<COLLECTION, Foxiverse>(&arg0, 0x1::option::none<u64>(), arg1);
        0x2::package::claim_and_keep<COLLECTION>(arg0, arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Foxiverse>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Foxiverse>>(v0);
    }

    // decompiled from Move bytecode v6
}

