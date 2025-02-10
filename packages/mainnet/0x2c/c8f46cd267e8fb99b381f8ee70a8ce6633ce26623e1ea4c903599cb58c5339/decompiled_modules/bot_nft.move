module 0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft {
    struct BOT_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct BotNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public fun add_attributes(arg0: &mut BotNFT, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>();
        0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v0, arg1, arg2);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::add_new(&mut arg0.id, v0);
    }

    fun init(arg0: BOT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<BOT_NFT, BotNFT>(&arg0, 0x1::option::none<u64>(), arg1);
        let v2 = v0;
        let v3 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<BotNFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<BotNFT, Witness>(v3), &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Anemone Bot"), 0x1::string::utf8(b"A NFT collection representing ownership of Anemone bots")));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<BotNFT>>(v2);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BotNFT>>(v1);
    }

    public(friend) fun mint_bot_nft(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BotNFT>, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) : BotNFT {
        let v0 = BotNFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            url         : 0x2::url::new_unsafe(arg3),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(0x1::vector::empty<0x1::ascii::String>(), 0x1::vector::empty<0x1::ascii::String>()),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<BotNFT>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<BotNFT, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<BotNFT>(arg0), &v0);
        v0
    }

    public entry fun transfer_nft(arg0: BotNFT, arg1: address) {
        0x2::transfer::public_transfer<BotNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

