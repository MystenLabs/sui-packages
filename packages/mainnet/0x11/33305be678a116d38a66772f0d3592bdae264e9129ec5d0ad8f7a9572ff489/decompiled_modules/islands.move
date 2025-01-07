module 0x4125c462e4dc35631e7b31dc0c443930bd96fbd24858d8e772ff5b225c55a792::islands {
    struct ISLANDS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Island has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        generation: 0x1::string::String,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct IslandMinted has copy, drop {
        id: 0x2::object::ID,
        mint_cap_id: 0x2::object::ID,
        name: 0x1::string::String,
        created_by: address,
    }

    fun attach_object<T0: store + key>(arg0: &mut Island, arg1: T0, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>) {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<Island, T0>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<Island>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Island>(arg2)), &mut arg0.id, arg1);
    }

    entry fun attach_object_from_other_kiosk<T0: store + key>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap) {
        let v0 = 0x2::kiosk::borrow_mut<Island>(arg3, arg4, arg0);
        attach_object<T0>(v0, 0x2::kiosk::take<T0>(arg5, arg6, arg1), arg2);
    }

    entry fun attach_object_from_same_kiosk<T0: store + key>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap) {
        let v0 = 0x2::kiosk::borrow_mut<Island>(arg3, arg4, arg0);
        attach_object<T0>(v0, 0x2::kiosk::take<T0>(arg3, arg4, arg1), arg2);
    }

    fun burn_island(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<Island>, arg1: Island, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>) {
        let Island {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            generation  : _,
            attributes  : _,
        } = arg1;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Island>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Island>(arg0, &arg1), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>>(arg2), v0);
    }

    entry fun burn_island_in_listing(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        burn_island(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Island>(arg0), 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft<Island>(arg2, arg3, arg4), arg1);
    }

    entry fun burn_island_in_listing_with_id(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        burn_island(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Island>(arg0), 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft_with_id<Island>(arg2, arg3, arg4, arg5), arg1);
    }

    entry fun burn_own_island(arg0: Island, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>) {
        let v0 = Witness{dummy_field: false};
        burn_island(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Island, Witness>(v0), arg0, arg1);
    }

    entry fun burn_own_island_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID) {
        burn_own_island(0x2::kiosk::take<Island>(arg1, arg2, arg3), arg0);
    }

    entry fun create_mint_cap(arg0: &0x2::package::Publisher, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Island>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::display::is_authorized<Island>(arg0), 1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Island>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::split<Island>(arg1, arg2, arg4), arg3);
    }

    fun detach_object<T0: store + key>(arg0: &mut Island, arg1: 0x2::object::ID, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>) : T0 {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::decompose_from_nft<Island, T0>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<Island>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Island>(arg2)), &mut arg0.id, arg1)
    }

    entry fun detach_object_to_kiosk<T0: store + key>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap) {
        let v0 = 0x2::kiosk::borrow_mut<Island>(arg3, arg4, arg0);
        0x2::kiosk::place<T0>(arg3, arg4, detach_object<T0>(v0, arg1, arg2));
    }

    fun init(arg0: ISLANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Island, Witness>(v0);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        let (v3, v4) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<ISLANDS, Island>(&arg0, 0x1::option::none<u64>(), arg1);
        let v5 = v3;
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Island>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::new_limited<ISLANDS, Island>(&arg0, 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>>(&v5), 500, arg1), @0x82524b1f08801ee623993543a56b95a845081472977fd1d2f39b30e095ef5d99);
        let v6 = 0x2::package::claim<ISLANDS>(arg0, arg1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Island, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v1, &mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Cosmocadia Islands"), 0x1::string::utf8(b"A play & earn farming game on the Sui network by Lucky Kat Studios. This collection contains island NFTs.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Island, 0x2::url::Url>(v1, &mut v5, 0x2::url::new_unsafe_from_bytes(b"https://cosmocadia.io/"));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Island, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v1, &mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v2)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Island, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v1, &mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"COSMO_ISLANDS")));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"generation"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://cosmocadia.io"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Lucky Kat Studios"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{generation}"));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v12, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::profile_picture());
        0x1::vector::push_back<0x1::string::String>(v12, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        0x1::vector::push_back<0x1::string::String>(v12, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        let v13 = 0x2::display::new_with_fields<Island>(&v6, v7, v9, arg1);
        0x2::display::add<Island>(&mut v13, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v11));
        0x2::display::update_version<Island>(&mut v13);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Island>(v1, &mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v2, vector[10000]), arg1), 1000, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, @0x82524b1f08801ee623993543a56b95a845081472977fd1d2f39b30e095ef5d99);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Island>>(v4, @0x82524b1f08801ee623993543a56b95a845081472977fd1d2f39b30e095ef5d99);
        0x2::transfer::public_transfer<0x2::display::Display<Island>>(v13, @0x82524b1f08801ee623993543a56b95a845081472977fd1d2f39b30e095ef5d99);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Island>>(v5);
    }

    fun mint_island(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Island>, arg7: &mut 0x2::tx_context::TxContext) : Island {
        let v0 = Island{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            generation  : 0x1::string::utf8(arg3),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg4, arg5),
        };
        let v1 = IslandMinted{
            id          : 0x2::object::id<Island>(&v0),
            mint_cap_id : 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Island>>(arg6),
            name        : 0x1::string::utf8(arg0),
            created_by  : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<IslandMinted>(v1);
        let v2 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Island>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Island, Witness>(v2), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Island>(arg6), &v0);
        v0
    }

    entry fun mint_island_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Island>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_island(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        let (v1, v2) = 0x2::kiosk::new(arg8);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::set_owner_custom(&mut v4, &v3, arg7);
        0x2::kiosk::place<Island>(&mut v4, &v3, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::object::id<Island>(&v0)
    }

    entry fun mint_island_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Island>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_island(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::place<Island>(arg7, arg8, v0);
        0x2::object::id<Island>(&v0)
    }

    entry fun mint_island_to_warehouse(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Island>, arg7: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<Island>, arg8: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<Island>(arg7, mint_island(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8));
    }

    // decompiled from Move bytecode v6
}

