module 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct PANZERTANKS has drop {
        dummy_field: bool,
    }

    struct Tank has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
        image_hash: 0x1::string::String,
        gif_hash: 0x1::string::String,
        constructor: address,
    }

    struct TankSchema has copy, drop {
        dummy_field: bool,
    }

    struct TankConstructEvent has copy, drop {
        tank_id: 0x2::object::ID,
        sender: address,
    }

    struct TankDeconstructEvent has copy, drop {
        tank_id: 0x2::object::ID,
        sender: address,
    }

    public fun borrow_tank_name(arg0: &Tank) : &0x1::string::String {
        &arg0.name
    }

    public fun borrow_tank_uid(arg0: &Tank) : &0x2::object::UID {
        &arg0.id
    }

    fun burn_tank(arg0: Tank, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Tank>, arg2: address) {
        let v0 = Witness{dummy_field: false};
        let Tank {
            id          : v1,
            game_id     : _,
            name        : _,
            attributes  : _,
            image_hash  : _,
            gif_hash    : _,
            constructor : _,
        } = arg0;
        let v8 = v1;
        let v9 = TankDeconstructEvent{
            tank_id : 0x2::object::uid_to_inner(&v8),
            sender  : arg2,
        };
        0x2::event::emit<TankDeconstructEvent>(v9);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Tank>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Tank>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Tank, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Tank>>(arg1), v8);
    }

    public fun compose_part_onto_tank<T0: copy + drop>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut Tank, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Tank>, arg5: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg6: vector<u8>, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg2.id);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg5)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg5);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg6, &v1, &v0, arg7), 1);
        let (v2, v3) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>>(arg0, arg1, arg8);
        let v4 = v3;
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::confirm_withdrawal<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>>(&mut v4);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>>(v4, arg3);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<TankSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Tank>(arg4)), &mut arg2.id, v2);
    }

    public entry fun compose_tank(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Tank>, arg11: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg12: vector<u8>, arg13: u8, arg14: &mut 0x2::kiosk::Kiosk, arg15: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Turret>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg16: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Chassis>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg17: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Tracks>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg18: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Skin>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg19: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg19);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&arg6));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&arg7));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&arg8));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&arg9));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg11)));
        let v2 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg11);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg12, &v2, &v1, arg13), 1);
        let v3 = mint_tank_int(arg0, arg1, arg2, arg3, arg4, arg5, arg19);
        let (v4, v5) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Turret>>(arg14, arg6, arg19);
        let v6 = v5;
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::confirm_withdrawal<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Turret>>(&mut v6);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Turret>>(v6, arg15);
        let (v7, v8) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Chassis>>(arg14, arg7, arg19);
        let v9 = v8;
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::confirm_withdrawal<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Chassis>>(&mut v9);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Chassis>>(v9, arg16);
        let (v10, v11) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Tracks>>(arg14, arg8, arg19);
        let v12 = v11;
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::confirm_withdrawal<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Tracks>>(&mut v12);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Tracks>>(v12, arg17);
        let (v13, v14) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Skin>>(arg14, arg9, arg19);
        let v15 = v14;
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::confirm_withdrawal<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Skin>>(&mut v15);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Skin>>(v15, arg18);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Turret>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<TankSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Tank>(arg10)), &mut v3.id, v4);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Chassis>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<TankSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Tank>(arg10)), &mut v3.id, v7);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Tracks>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<TankSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Tank>(arg10)), &mut v3.id, v10);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Skin>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<TankSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Tank>(arg10)), &mut v3.id, v13);
        let v16 = TankConstructEvent{
            tank_id : 0x2::object::id<Tank>(&v3),
            sender  : v0,
        };
        0x2::event::emit<TankConstructEvent>(v16);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Tank>(arg14, v3, arg19);
        0x2::object::id<Tank>(&v3)
    }

    public entry fun compose_tank_admin(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Turret>, arg7: 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Chassis>, arg8: 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Tracks>, arg9: 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Skin>, arg10: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Tank>, arg11: &mut 0x2::kiosk::Kiosk, arg12: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Tank>, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_tank_int(arg0, arg1, arg2, arg3, arg4, arg5, arg13);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Turret>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<TankSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Tank>(arg10)), &mut v0.id, arg6);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Chassis>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<TankSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Tank>(arg10)), &mut v0.id, arg7);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Tracks>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<TankSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Tank>(arg10)), &mut v0.id, arg8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Skin>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<TankSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Tank>(arg10)), &mut v0.id, arg9);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Tank>(arg12, 1);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Tank>(arg11, v0, arg13);
        0x2::object::id<Tank>(&v0)
    }

    public(friend) fun confirm_withdrawal<T0>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::add_receipt<T0, Witness>(arg0, &v0);
    }

    public entry fun decompose_tank(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Tank, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Tank>, arg7: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg8: vector<u8>, arg9: u8, arg10: &mut 0x2::kiosk::Kiosk, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg7)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg7);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg8, &v1, &v0, arg9), 1);
        let (v2, v3) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<Tank>(arg10, arg1, arg11);
        let v4 = v3;
        let v5 = v2;
        let v6 = &mut v4;
        confirm_withdrawal<Tank>(v6);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<Tank>(v4, arg0);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Turret>>(arg10, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::decompose_with_collection_schema<Tank, TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Turret>>(arg6, &mut v5.id, arg2), arg11);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Chassis>>(arg10, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::decompose_with_collection_schema<Tank, TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Chassis>>(arg6, &mut v5.id, arg3), arg11);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Tracks>>(arg10, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::decompose_with_collection_schema<Tank, TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Tracks>>(arg6, &mut v5.id, arg4), arg11);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Skin>>(arg10, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::decompose_with_collection_schema<Tank, TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Skin>>(arg6, &mut v5.id, arg5), arg11);
        burn_tank(v5, arg6, 0x2::tx_context::sender(arg11));
    }

    fun enforce_contract<T0>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<T0>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<T0, Witness>(arg0, arg1);
    }

    fun init(arg0: PANZERTANKS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, @0xdf956a58a59fe2a9426a0310230a7c0dca7434843eec870d03d8b510ee6fe8aa);
        0x1::vector::push_back<address>(v2, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        let v3 = Witness{dummy_field: false};
        let v4 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Tank, Witness>(v3);
        let (v5, v6) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<PANZERTANKS, Tank>(&arg0, 0x1::option::none<u64>(), arg1);
        let v7 = v5;
        let v8 = 0x2::package::claim<PANZERTANKS>(arg0, arg1);
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"game_id"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"creator"));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{game_id}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"ipfs://{gif_hash}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"A Constructd PanzerTank"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Constructed by: {constructor}"));
        let v13 = 0x2::display::new_with_fields<Tank>(&v8, v9, v11, arg1);
        let v14 = 0x1::vector::empty<0x1::string::String>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::string::String>(v15, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        0x1::vector::push_back<0x1::string::String>(v15, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        0x2::display::add<Tank>(&mut v13, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v14));
        0x2::display::update_version<Tank>(&mut v13);
        let v16 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::new_composition<TankSchema>();
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Turret>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Chassis>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Tracks>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<TankSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Skin>>(&mut v16, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Tank, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Panzertanks"), 0x1::string::utf8(b"Panzerdogs is a PVP tank brawler built on Sui. Craft and build your custom tanks to battle against each other in a variety of exciting game modes.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Tank, 0x2::url::Url>(v4, &mut v7, 0x2::url::new_unsafe_from_bytes(b"https://www.panzerdogs.io/"));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Tank, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"PANZERTANK")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Tank, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::Composition<TankSchema>>(v4, &mut v7, v16);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Tank, vector<0x1::string::String>>(v4, &mut v7, v14);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Tank, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v1)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Tank>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v1, vector[9600, 400]), arg1), 500, arg1);
        let (v17, v18) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Tank>(&v8, arg1);
        let v19 = v18;
        let v20 = v17;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Tank>(&mut v20, &v19);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Tank>(&mut v20, &v19);
        let (v21, v22) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<Tank>(&v8, arg1);
        let v23 = v22;
        let v24 = v21;
        let v25 = &mut v24;
        enforce_contract<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Tank, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>(v25, &v23);
        let (v26, v27) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::init_policy<Tank>(&v8, arg1);
        let (v28, v29) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Tank>(&v8, arg1);
        let v30 = v29;
        let v31 = v28;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<Tank>(&mut v31, &v30);
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::create_signer(&v8, arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Tank>>(v6, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Tank>>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Tank>>(v13, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Tank>>(v30, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Tank>>(v31);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Tank>>(v19, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Tank>>(v20);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v23, v0);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Tank, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v24);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v27, v0);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Tank, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>>(v26);
    }

    public fun mint_tank(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg7: vector<u8>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) : Tank {
        let v0 = 0x2::bcs::to_bytes<0x1::string::String>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg6)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg6);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg7, &v1, &v0, arg8), 1);
        mint_tank_int(arg0, arg1, arg2, arg3, arg4, arg5, arg9)
    }

    fun mint_tank_int(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Tank {
        0x1::vector::reverse<0x1::ascii::String>(&mut arg2);
        0x1::vector::reverse<0x1::ascii::String>(&mut arg3);
        let v0 = Tank{
            id          : 0x2::object::new(arg6),
            game_id     : arg0,
            name        : arg1,
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg2, arg3),
            image_hash  : arg4,
            gif_hash    : arg5,
            constructor : 0x2::tx_context::sender(arg6),
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::add_domain(&mut v0.id, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::new(arg6));
        v0
    }

    public entry fun mutate_tank_url(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::display::Display<Tank>) {
        assert!(0x2::display::is_authorized<Tank>(arg0), 2);
        0x2::display::edit<Tank>(arg2, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<Tank>(arg2);
    }

    // decompiled from Move bytecode v6
}

