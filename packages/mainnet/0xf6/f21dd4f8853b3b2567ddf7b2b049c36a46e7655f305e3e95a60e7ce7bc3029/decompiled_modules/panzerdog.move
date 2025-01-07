module 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct PANZERDOG has drop {
        dummy_field: bool,
    }

    struct Panzerdog has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
        clan: 0x1::string::String,
        dog_type: 0x1::string::String,
        augment: 0x1::string::String,
        mutation: 0x1::string::String,
        image_hash: 0x1::string::String,
        gif_hash: 0x1::string::String,
    }

    struct DogSchema has copy, drop {
        dummy_field: bool,
    }

    struct EquipEvent has copy, drop {
        dog_id: 0x2::object::ID,
        equipment_id: 0x2::object::ID,
        sender: address,
    }

    struct UnequipEvent has copy, drop {
        dog_id: 0x2::object::ID,
        equipment_id: 0x2::object::ID,
        sender: address,
    }

    public entry fun airdrop_panzerdog(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Panzerdog>, arg11: &mut 0x2::kiosk::Kiosk, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v2 = v1;
        let v3 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Panzerdog>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Panzerdog, Witness>(v3), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Panzerdog>(arg10), &v2);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Panzerdog>(arg10, 1);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Panzerdog>(arg11, v2, arg12);
        v0
    }

    public fun borrow_dog_gif(arg0: &Panzerdog) : &0x1::string::String {
        &arg0.gif_hash
    }

    public fun borrow_dog_id(arg0: &Panzerdog) : 0x2::object::ID {
        0x2::object::uid_to_inner(borrow_dog_uid(arg0))
    }

    public fun borrow_dog_image(arg0: &Panzerdog) : &0x1::string::String {
        &arg0.image_hash
    }

    public fun borrow_dog_uid(arg0: &Panzerdog) : &0x2::object::UID {
        &arg0.id
    }

    public entry fun burn_panzerdog_from_kiosk(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Panzerdog, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg1: 0x2::object::ID, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Panzerdog>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<Panzerdog>(arg3, arg1, arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v2;
        confirm_withdrawal<Panzerdog>(v4);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<Panzerdog>(v2, arg0);
        let v5 = Witness{dummy_field: false};
        let Panzerdog {
            id         : v6,
            game_id    : _,
            name       : _,
            attributes : _,
            clan       : _,
            dog_type   : _,
            augment    : _,
            mutation   : _,
            image_hash : _,
            gif_hash   : _,
        } = v3;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Panzerdog>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Panzerdog>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Panzerdog, Witness>(v5), &v3), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Panzerdog>>(arg2), v6);
    }

    public fun confirm_withdrawal<T0>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::add_receipt<T0, Witness>(arg0, &v0);
    }

    fun enforce_contract<T0>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<T0>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<T0, Witness>(arg0, arg1);
    }

    public entry fun equip_item_different_kiosk<T0: copy + drop>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Panzerdog, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Panzerdog>, arg7: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg8: vector<u8>, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg7)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg7);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg8, &v1, &v0, arg9), 1);
        let v2 = Witness{dummy_field: false};
        let v3 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::borrow_nft_mut<Panzerdog>(arg2, arg4, 0x1::option::none<0x1::type_name::TypeName>(), arg10);
        let v4 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::Witness, Panzerdog>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Panzerdog, Witness>(v2), &mut v3);
        let (v5, v6) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(arg3, arg5, arg10);
        let v7 = v6;
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::confirm_withdrawal<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(&mut v7);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(v7, arg1);
        equip_item_int<T0>(v4, v5, arg6, arg10);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::return_nft<Witness, Panzerdog>(arg2, v3, arg0);
    }

    fun equip_item_int<T0: copy + drop>(arg0: &mut Panzerdog, arg1: 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Panzerdog>, arg3: &mut 0x2::tx_context::TxContext) {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<DogSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Panzerdog>(arg2)), &mut arg0.id, arg1);
        let v0 = EquipEvent{
            dog_id       : 0x2::object::id<Panzerdog>(arg0),
            equipment_id : 0x2::object::id<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(&arg1),
            sender       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EquipEvent>(v0);
    }

    public entry fun equip_item_kiosk<T0: copy + drop>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Panzerdog, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Panzerdog>, arg6: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg7: vector<u8>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg6)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg6);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg7, &v1, &v0, arg8), 1);
        let v2 = Witness{dummy_field: false};
        let v3 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::borrow_nft_mut<Panzerdog>(arg2, arg3, 0x1::option::none<0x1::type_name::TypeName>(), arg9);
        let v4 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::Witness, Panzerdog>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Panzerdog, Witness>(v2), &mut v3);
        let (v5, v6) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(arg2, arg4, arg9);
        let v7 = v6;
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::confirm_withdrawal<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(&mut v7);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(v7, arg1);
        equip_item_int<T0>(v4, v5, arg5, arg9);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::return_nft<Witness, Panzerdog>(arg2, v3, arg0);
    }

    fun init(arg0: PANZERDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, @0xdf956a58a59fe2a9426a0310230a7c0dca7434843eec870d03d8b510ee6fe8aa);
        0x1::vector::push_back<address>(v2, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        let v3 = Witness{dummy_field: false};
        let v4 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Panzerdog, Witness>(v3);
        let (v5, v6) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<PANZERDOG, Panzerdog>(&arg0, 0x1::option::none<u64>(), arg1);
        let v7 = v5;
        let v8 = 0x2::package::claim<PANZERDOG>(arg0, arg1);
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"game_id"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"clan"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"dog_type"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"creator"));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{game_id}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"ipfs://{gif_hash}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"A Panzerdog"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{clan}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{dog_type}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v13 = 0x2::display::new_with_fields<Panzerdog>(&v8, v9, v11, arg1);
        let v14 = 0x1::vector::empty<0x1::string::String>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::string::String>(v15, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v15, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        0x1::vector::push_back<0x1::string::String>(v15, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        0x2::display::add<Panzerdog>(&mut v13, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v14));
        0x2::display::update_version<Panzerdog>(&mut v13);
        let v16 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::new_composition<DogSchema>();
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Background>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Colour>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Body>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::BodyAccessory>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Mouth>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Hat>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Glasses>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Panzerdog, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Panzerdogs"), 0x1::string::utf8(b"5555 unique dog avatars used by a PVP tank brawler on Sui.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Panzerdog, 0x2::url::Url>(v4, &mut v7, 0x2::url::new_unsafe_from_bytes(b"https://www.panzerdogs.io/"));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Panzerdog, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"PANZERDOG")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Panzerdog, vector<0x1::string::String>>(v4, &mut v7, v14);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Panzerdog, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::Composition<DogSchema>>(v4, &mut v7, v16);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Panzerdog, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v1)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Panzerdog>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v1, vector[9600, 400]), arg1), 500, arg1);
        let (v17, v18) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Panzerdog>(&v8, arg1);
        let v19 = v18;
        let v20 = v17;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Panzerdog>(&mut v20, &v19);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Panzerdog>(&mut v20, &v19);
        let (v21, v22) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<Panzerdog>(&v8, arg1);
        let v23 = v22;
        let v24 = v21;
        let v25 = &mut v24;
        enforce_contract<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Panzerdog, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>(v25, &v23);
        let (v26, v27) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::init_policy<Panzerdog>(&v8, arg1);
        let (v28, v29) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Panzerdog>(&v8, arg1);
        let v30 = v29;
        let v31 = v28;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<Panzerdog>(&mut v31, &v30);
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::create_signer(&v8, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Panzerdog>>(v6, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Panzerdog>>(v13, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Panzerdog>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Panzerdog>>(v30, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Panzerdog>>(v31);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Panzerdog>>(v19, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Panzerdog>>(v20);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v23, v0);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Panzerdog, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v24);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v27, v0);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Panzerdog, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>>(v26);
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, Panzerdog) {
        0x1::vector::reverse<0x1::ascii::String>(&mut arg2);
        0x1::vector::reverse<0x1::ascii::String>(&mut arg3);
        if (0x1::option::is_some<0x1::string::String>(&arg7)) {
            let v2 = Panzerdog{
                id         : 0x2::object::new(arg10),
                game_id    : arg0,
                name       : arg1,
                attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg2, arg3),
                clan       : arg4,
                dog_type   : arg5,
                augment    : 0x1::option::extract<0x1::string::String>(&mut arg6),
                mutation   : 0x1::option::extract<0x1::string::String>(&mut arg7),
                image_hash : arg8,
                gif_hash   : arg9,
            };
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::add_domain(&mut v2.id, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::new(arg10));
            (0x2::object::id<Panzerdog>(&v2), v2)
        } else {
            let v3 = Panzerdog{
                id         : 0x2::object::new(arg10),
                game_id    : arg0,
                name       : arg1,
                attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg2, arg3),
                clan       : arg4,
                dog_type   : arg5,
                augment    : 0x1::string::utf8(b"None"),
                mutation   : 0x1::string::utf8(b"None"),
                image_hash : arg8,
                gif_hash   : arg9,
            };
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::add_domain(&mut v3.id, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::new(arg10));
            (0x2::object::id<Panzerdog>(&v3), v3)
        }
    }

    public fun mint_equipment_for_dog<T0: copy + drop>(arg0: &mut Panzerdog, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: 0x1::string::String, arg6: u8, arg7: 0x1::string::String, arg8: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>, arg9: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Panzerdog>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::mint_equipment_admin<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10);
        equip_item_int<T0>(arg0, v0, arg9, arg10);
        0x2::object::id<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(&v0)
    }

    public fun mint_panzerdog(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Panzerdog>, arg11: &mut 0x2::tx_context::TxContext) : Panzerdog {
        let (_, v1) = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
        let v2 = v1;
        let v3 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Panzerdog>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Panzerdog, Witness>(v3), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Panzerdog>(arg10), &v2);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Panzerdog>(arg10, 1);
        v2
    }

    public entry fun mutate_dog_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::display::Display<Panzerdog>) {
        assert!(0x2::display::is_authorized<Panzerdog>(arg0), 2);
        0x2::display::edit<Panzerdog>(arg2, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<Panzerdog>(arg2);
    }

    public entry fun mutate_dog_image(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Panzerdog, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg6: vector<u8>, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg5)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg5);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg6, &v1, &v0, arg7), 1);
        let v2 = Witness{dummy_field: false};
        let v3 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::borrow_nft_mut<Panzerdog>(arg1, arg2, 0x1::option::none<0x1::type_name::TypeName>(), arg8);
        let v4 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::Witness, Panzerdog>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Panzerdog, Witness>(v2), &mut v3);
        v4.image_hash = arg3;
        v4.gif_hash = arg4;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::return_nft<Witness, Panzerdog>(arg1, v3, arg0);
    }

    fun unequip_item<T0: copy + drop>(arg0: &mut Panzerdog, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Panzerdog>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = UnequipEvent{
            dog_id       : 0x2::object::id<Panzerdog>(arg0),
            equipment_id : arg1,
            sender       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UnequipEvent>(v0);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(arg2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::decompose_with_collection_schema<Panzerdog, DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(arg3, &mut arg0.id, arg1), arg4);
    }

    public entry fun unequip_item_kiosk<T0: copy + drop>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Panzerdog, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Panzerdog>, arg5: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg6: vector<u8>, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg5)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg5);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg6, &v1, &v0, arg7), 1);
        let v2 = Witness{dummy_field: false};
        let v3 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::borrow_nft_mut<Panzerdog>(arg1, arg2, 0x1::option::none<0x1::type_name::TypeName>(), arg8);
        let v4 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::Witness, Panzerdog>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Panzerdog, Witness>(v2), &mut v3);
        unequip_item<T0>(v4, arg3, arg1, arg4, arg8);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::return_nft<Witness, Panzerdog>(arg1, v3, arg0);
    }

    // decompiled from Move bytecode v6
}

