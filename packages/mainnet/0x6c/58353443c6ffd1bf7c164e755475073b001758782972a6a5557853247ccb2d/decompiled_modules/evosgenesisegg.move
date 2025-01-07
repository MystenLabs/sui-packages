module 0x6c58353443c6ffd1bf7c164e755475073b001758782972a6a5557853247ccb2d::evosgenesisegg {
    struct EVOSGENESISEGG has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct EvosGenesisEgg has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun burn(arg0: EvosGenesisEgg) {
        let EvosGenesisEgg {
            id   : v0,
            name : _,
            url  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun create_nft(arg0: &mut 0x2::tx_context::TxContext) : EvosGenesisEgg {
        EvosGenesisEgg{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Evos Genesis Egg"),
            url  : 0x2::url::new_unsafe_from_bytes(b"https://knw-gp.s3.eu-north-1.amazonaws.com/egg.webp"),
        }
    }

    public fun get_nft<T0: drop>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, EvosGenesisEgg>) : EvosGenesisEgg {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft<T0, EvosGenesisEgg>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v0), arg0)
    }

    public fun get_nft_field<T0: drop, T1: store>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, EvosGenesisEgg>) : (T1, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::ReturnPromise<EvosGenesisEgg, T1>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_field<EvosGenesisEgg, T1>(v1, &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<T0, EvosGenesisEgg>(v1, arg0).id)
    }

    fun init(arg0: EVOSGENESISEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<EVOSGENESISEGG, EvosGenesisEgg>(&arg0, 0x1::option::some<u64>(7000), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<EVOSGENESISEGG>(arg0, arg1);
        let v5 = Witness{dummy_field: false};
        let v6 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v5);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v8, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        let v9 = 0x2::display::new<EvosGenesisEgg>(&v4, arg1);
        0x2::display::add<EvosGenesisEgg>(&mut v9, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<EvosGenesisEgg>(&mut v9, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<EvosGenesisEgg>(&mut v9, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v7));
        0x2::display::update_version<EvosGenesisEgg>(&mut v9);
        0x2::transfer::public_transfer<0x2::display::Display<EvosGenesisEgg>>(v9, 0x2::tx_context::sender(arg1));
        let v10 = vector[@0x1dae98dcae53909f23184b273923184aa451986c4b71da1950d749def37f8ea0];
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<EvosGenesisEgg, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v10)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<EvosGenesisEgg>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v10, vector[10000]), arg1), 100, arg1);
        let (v11, v12) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<EvosGenesisEgg>(&v4, arg1);
        let v13 = v12;
        let v14 = v11;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<EvosGenesisEgg>(&mut v14, &v13);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<EvosGenesisEgg>(&mut v14, &v13);
        let (v15, v16) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<EvosGenesisEgg>(&v4, arg1);
        let v17 = v16;
        let v18 = v15;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<EvosGenesisEgg>(&mut v18, &v17);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<EvosGenesisEgg>>(v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EvosGenesisEgg>>(v13, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EvosGenesisEgg>>(v17, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<EvosGenesisEgg>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EvosGenesisEgg>>(v14);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EvosGenesisEgg>>(v18);
        let v19 = create_nft(arg1);
        0x2::transfer::public_transfer<EvosGenesisEgg>(v19, v0);
        let v20 = create_nft(arg1);
        0x2::transfer::public_transfer<EvosGenesisEgg>(v20, v0);
        let v21 = create_nft(arg1);
        0x2::transfer::public_transfer<EvosGenesisEgg>(v21, v0);
        let v22 = create_nft(arg1);
        0x2::transfer::public_transfer<EvosGenesisEgg>(v22, v0);
        0x2::transfer::public_transfer<EvosGenesisEgg>(create_nft(arg1), v0);
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) : EvosGenesisEgg {
        create_nft(arg0)
    }

    public entry fun mint_nft(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<EvosGenesisEgg>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg1);
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<EvosGenesisEgg>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<EvosGenesisEgg>(arg0), &v0);
        0x2::transfer::public_transfer<EvosGenesisEgg>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun return_nft<T0: drop>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, EvosGenesisEgg>, arg1: EvosGenesisEgg) {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::return_nft<T0, EvosGenesisEgg>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v0), arg0, arg1);
    }

    public fun return_nft_field<T0: drop, T1: store>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, EvosGenesisEgg>, arg1: T1, arg2: 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::ReturnPromise<EvosGenesisEgg, T1>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<EvosGenesisEgg, Witness>(v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::return_field<EvosGenesisEgg, T1>(v1, &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<T0, EvosGenesisEgg>(v1, arg0).id, arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

