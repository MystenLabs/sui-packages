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

    public fun borrow_total_staked(arg0: &StakingSeason) : &u64 {
        &arg0.total_staked
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

