module 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::swoots {
    struct SWOOTS has drop {
        dummy_field: bool,
    }

    struct Swoot has store, key {
        id: 0x2::object::UID,
        background: 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::background::Background,
        clothes: 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::clothes::Clothes,
        eyewear: 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::eyewear::Eyewear,
        face: 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::face::Face,
        fur: 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::fur::Fur,
        head: 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::head::Head,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<SWOOTS, Swoot>(&arg0, 0x1::option::some<u64>(10000), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<SWOOTS>(arg0, arg1);
        let v5 = 0x2::display::new<Swoot>(&v4, arg1);
        0x2::display::add<Swoot>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::update_version<Swoot>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Swoot>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        let v7 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Swoot, Witness>(v6);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Swoot, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v7, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Swoot"), 0x1::string::utf8(b"A composable NFT collection on Sui")));
        let v8 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::new_composition<Swoot>();
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Swoot, 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::background::Background>(&mut v8, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Swoot, 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::clothes::Clothes>(&mut v8, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Swoot, 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::eyewear::Eyewear>(&mut v8, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Swoot, 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::face::Face>(&mut v8, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Swoot, 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::fur::Fur>(&mut v8, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Swoot, 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::head::Head>(&mut v8, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Swoot, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::Composition<Swoot>>(v7, &mut v3, v8);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Swoot>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Swoot>>(v3);
    }

    public entry fun mint_swoot(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Swoot>, arg7: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<Swoot>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Swoot{
            id         : 0x2::object::new(arg8),
            background : 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::background::mint_background_(arg0, arg8),
            clothes    : 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::clothes::mint_clothes_(arg1, arg8),
            eyewear    : 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::eyewear::mint_eyewear_(arg2, arg8),
            face       : 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::face::mint_face_(arg3, arg8),
            fur        : 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::fur::mint_fur_(arg4, arg8),
            head       : 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::head::mint_head_(arg5, arg8),
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Swoot>(arg6, 1);
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Swoot>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Swoot, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Swoot>(arg6), &v0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<Swoot>(arg7, v0);
    }

    // decompiled from Move bytecode v6
}

