module 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::stakingmodule {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct STAKINGMODULE has drop {
        dummy_field: bool,
    }

    struct Key<phantom T0> has drop, store {
        dummy_field: bool,
    }

    struct StakingTicket has store, key {
        id: 0x2::object::UID,
        owner: address,
        owner_kiosk: 0x2::object::ID,
        nft: 0x2::object::ID,
        season: u64,
    }

    struct StakingSeason has store, key {
        id: 0x2::object::UID,
        season: u64,
        is_withdrawal_open: bool,
        total_staked: u64,
    }

    struct SeasonMintCap has store, key {
        id: 0x2::object::UID,
        seasons_created: u64,
    }

    public entry fun alter_dog_attributes_staked(arg0: &StakingTicket, arg1: &mut StakingSeason, arg2: 0x2::object::ID, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg6: vector<u8>, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg5)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg5);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg6, &v1, &v0, arg7), 5);
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::alter_dog_attributes_staked_friend(borrow_staked_dog_mut(arg0, arg1, arg8), arg3, arg4);
    }

    fun borrow_staked_dog_mut(arg0: &StakingTicket, arg1: &mut StakingSeason, arg2: &mut 0x2::tx_context::TxContext) : &mut 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.season == arg1.season, 2);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::borrow_nft_mut<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>(&mut arg1.id, arg0.nft)
    }

    public fun borrow_staking_season_uid(arg0: &StakingSeason) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_total_staked(arg0: &StakingSeason) : &u64 {
        &arg0.total_staked
    }

    public entry fun equip_item_staked<T0: copy + drop>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg1: &StakingTicket, arg2: &mut StakingSeason, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>, arg6: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg7: vector<u8>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg1.nft);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg6)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg6);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg7, &v1, &v0, arg8), 5);
        let (v2, v3) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(arg3, arg4, arg9);
        let v4 = v3;
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::confirm_withdrawal<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(&mut v4);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(v4, arg0);
        let v5 = borrow_staked_dog_mut(arg1, arg2, arg9);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::DogSchema>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>(arg5)), 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::borrow_dog_uid_mut(v5), v2);
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::emit_unequip_event(0x2::object::id<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>(v5), arg4, 0x2::tx_context::sender(arg9));
    }

    public entry fun mutate_dog_image_staked(arg0: &StakingTicket, arg1: &mut StakingSeason, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg7: vector<u8>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg6)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg6);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg7, &v1, &v0, arg8), 5);
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::mutate_dog_image_staked_friend(borrow_staked_dog_mut(arg0, arg1, arg9), arg4, arg5);
    }

    public entry fun new_season(arg0: &0x2::package::Publisher, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<StakingSeason>(arg0), 4);
        let v0 = StakingSeason{
            id                 : 0x2::object::new(arg2),
            season             : arg1,
            is_withdrawal_open : false,
            total_staked       : 0,
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::add_domain(&mut v0.id, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::new(arg2));
        0x2::transfer::public_share_object<StakingSeason>(v0);
    }

    public entry fun stake_panzerdog(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg1: &mut StakingSeason, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = StakingTicket{
            id          : 0x2::object::new(arg4),
            owner       : v0,
            owner_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            nft         : arg2,
            season      : arg1.season,
        };
        arg1.total_staked = arg1.total_staked + 1;
        let v2 = Key<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose_into_nft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog, Key<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>>(v2, &mut arg1.id, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::withdraw_panzerdog(arg0, arg2, arg3, arg4));
        0x2::transfer::public_transfer<StakingTicket>(v1, v0);
    }

    public entry fun toggle_withdrawal(arg0: &0x2::package::Publisher, arg1: &mut StakingSeason) {
        assert!(0x2::package::from_package<StakingSeason>(arg0), 4);
        arg1.is_withdrawal_open = !arg1.is_withdrawal_open;
    }

    public entry fun unequip_item_staked<T0: copy + drop>(arg0: &StakingTicket, arg1: &mut StakingSeason, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>, arg5: &0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::Signer, arg6: vector<u8>, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg0.nft);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_salt(arg5)));
        let v1 = 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::borrow_pub_key(arg5);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg6, &v1, &v0, arg7), 5);
        let v2 = borrow_staked_dog_mut(arg0, arg1, arg8);
        let v3 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::decompose_with_collection_schema<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::DogSchema, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(arg4, 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::borrow_dog_uid_mut(v2), arg3);
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::emit_unequip_event(0x2::object::id<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>(v2), 0x2::object::id<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(&v3), 0x2::tx_context::sender(arg8));
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(arg2, v3, arg8);
    }

    public entry fun unstake_panzerdog(arg0: StakingTicket, arg1: &mut StakingSeason, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        let StakingTicket {
            id          : v0,
            owner       : v1,
            owner_kiosk : v2,
            nft         : v3,
            season      : v4,
        } = arg0;
        assert!(arg1.is_withdrawal_open, 0);
        assert!(v1 == 0x2::tx_context::sender(arg3), 1);
        assert!(v4 == arg1.season, 2);
        assert!(v2 == 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 3);
        let v5 = Key<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>{dummy_field: false};
        arg1.total_staked = arg1.total_staked - 1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>(arg2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::decompose_from_nft<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog, Key<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog::Panzerdog>>(v5, &mut arg1.id, v3), arg3);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

