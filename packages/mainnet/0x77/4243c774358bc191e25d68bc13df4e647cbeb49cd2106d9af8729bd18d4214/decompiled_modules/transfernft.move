module 0xd82dcaa427da6d7aa765278d66eefbe62714c8b0ae9cdac39bb8ad58227010e::transfernft {
    struct SampleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct TestData has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        kiosk: 0x2::object::ID,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MarketplaceRaffle has key {
        id: 0x2::object::UID,
        owner: address,
        fee: u16,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun deposit_nft(arg0: &mut MarketplaceRaffle, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TestData{
            id     : 0x2::object::new(arg3),
            nft_id : arg2,
            kiosk  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_transfer(arg1, arg2, 0x2::object::uid_to_address(&v0.id), arg3);
        0x2::dynamic_object_field::add<0x2::object::ID, TestData>(&mut arg0.id, 0x2::object::id<TestData>(&v0), v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceRaffle{
            id          : 0x2::object::new(arg0),
            owner       : 0x2::tx_context::sender(arg0),
            fee         : 0,
            fee_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MarketplaceRaffle>(v0);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = SampleNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg3);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<SampleNFT>(&mut v3, v0, arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::object::id<SampleNFT>(&v0)
    }

    public entry fun withdraw_nft<T0: store + key>(arg0: &mut MarketplaceRaffle, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg5);
        let v2 = v0;
        let v3 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg2, &mut v2, arg3, &0x2::dynamic_object_field::borrow_mut<0x2::object::ID, TestData>(&mut arg0.id, arg1).id, 0, arg5);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_nothing_paid<T0>(&mut v3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, 0x2::sui::SUI>(v3, arg4, arg5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun withdraw_nft_kiosk<T0: store + key>(arg0: &mut MarketplaceRaffle, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg2, arg3, arg4, &0x2::dynamic_object_field::borrow_mut<0x2::object::ID, TestData>(&mut arg0.id, arg1).id, 0, arg6);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_nothing_paid<T0>(&mut v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, 0x2::sui::SUI>(v0, arg5, arg6);
    }

    public entry fun withdraw_nft_kiosk_update<T0: store + key>(arg0: &mut MarketplaceRaffle, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg2, arg3, arg4, &0x2::dynamic_object_field::borrow_mut<0x2::object::ID, TestData>(&mut arg0.id, arg1).id, 0, arg8);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_nothing_paid<T0>(&mut v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg6, &mut v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, 0x2::sui::SUI>(arg7, &mut v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, 0x2::sui::SUI>(v0, arg5, arg8);
    }

    // decompiled from Move bytecode v6
}

