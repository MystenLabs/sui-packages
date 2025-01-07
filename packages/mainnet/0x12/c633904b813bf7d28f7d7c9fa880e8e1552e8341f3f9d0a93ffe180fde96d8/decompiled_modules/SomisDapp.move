module 0x12c633904b813bf7d28f7d7c9fa880e8e1552e8341f3f9d0a93ffe180fde96d8::SomisDapp {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct SOMISDAPP has drop {
        dummy_field: bool,
    }

    public entry fun buy_nft<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg7);
        let v2 = v0;
        let (v3, v4) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<T0>(&mut v2, arg3, arg7);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::buy_nft<T0, T1>(arg0, arg5, &mut v2, arg3, arg4, arg6, arg7), arg1, arg7);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<T0>(v4, arg2);
        0x2::transfer::public_transfer<T0>(v3, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun buy_nft_with_allowlist<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg3: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg8);
        let v2 = v0;
        let v3 = 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::buy_nft<T0, T1>(arg0, arg6, &mut v2, arg4, arg5, arg7, arg8);
        let (v4, v5) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<T0>(&mut v2, arg4, arg8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg3, &mut v3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v3, arg1, arg8);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<T0>(v5, arg2);
        0x2::transfer::public_transfer<T0>(v4, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun buy_nft_with_bps_royalty_strategy<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg3: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg8);
        let v2 = v0;
        let v3 = 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::buy_nft<T0, T1>(arg0, arg6, &mut v2, arg4, arg5, arg7, arg8);
        let (v4, v5) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<T0>(&mut v2, arg4, arg8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, T1>(arg3, &mut v3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v3, arg1, arg8);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<T0>(v5, arg2);
        0x2::transfer::public_transfer<T0>(v4, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun buy_nft_with_bps_royalty_strategy_and_allowlist<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg3: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg4: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg5: 0x2::object::ID, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x2::coin::Coin<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg9);
        let v2 = v0;
        let v3 = 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::buy_nft<T0, T1>(arg0, arg7, &mut v2, arg5, arg6, arg8, arg9);
        let (v4, v5) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<T0>(&mut v2, arg5, arg9);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, T1>(arg3, &mut v3);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg4, &mut v3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v3, arg1, arg9);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<T0>(v5, arg2);
        0x2::transfer::public_transfer<T0>(v4, 0x2::tx_context::sender(arg9));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun cancel_ask<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::cancel_ask<T0, T1>(arg0, arg2, arg3, arg4, arg5);
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<T0>(arg2, arg4, arg5);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<T0>(v1, arg1);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun cancel_bid<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::cancel_bid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_bid<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg3);
        let v2 = v0;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::enable_any_deposit(&mut v2, arg3);
        0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::create_bid<T0, T1>(arg0, &mut v2, arg1, arg2, arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun create_orderbook_unprotected<T0: store + key, T1>(arg0: &mut 0x2::package::Publisher, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::create_unprotected<T0, T1>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, arg2);
    }

    public entry fun create_withdraw_policy<T0: store + key>(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<T0>(arg0, arg1);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v0);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun finish_trade<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::finish_trade<T0, T1>(arg0, arg1, arg2, arg3, arg5), arg4, arg5);
    }

    public entry fun finish_trade_with_allowlist<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::finish_trade<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg5, &mut v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v0, arg4, arg6);
    }

    public entry fun finish_trade_with_bps_royalty_strategy<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::finish_trade<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, T1>(arg5, &mut v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v0, arg4, arg6);
    }

    public entry fun finish_trade_with_bps_royalty_strategy_and_allowlist<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg6: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::finish_trade<T0, T1>(arg0, arg1, arg2, arg3, arg7);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, T1>(arg5, &mut v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg6, &mut v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v0, arg4, arg7);
    }

    fun init(arg0: SOMISDAPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new(arg1);
        let v2 = v1;
        let v3 = v0;
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Witness>(&v2, &mut v3);
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::bidding::Witness>(&v2, &mut v3);
        0x2::transfer::public_transfer<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::AllowlistOwnerCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SOMISDAPP>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun list_nft<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg3);
        let v2 = v0;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(&mut v2, arg1, arg3);
        0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::create_ask_with_commission<T0, T1>(arg0, &mut v2, arg2, 0x2::object::id<T0>(&arg1), @0x5c370ee41d19373b7f2cc35b36c6dd569531f022f9c9c6a63e557e6c5b16b94d, 0x2::math::divide_and_round_up(arg2, 50), arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun list_nft_in_kiosk<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::create_ask_with_commission<T0, T1>(arg0, arg1, arg3, arg2, @0x5c370ee41d19373b7f2cc35b36c6dd569531f022f9c9c6a63e557e6c5b16b94d, 0x2::math::divide_and_round_up(arg3, 50), arg4);
    }

    public entry fun register_collection<T0: store + key>(arg0: &mut 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_collection<T0>(arg0, arg1);
    }

    public entry fun withdraw_nft_from_kisok<T0: store + key, T1>(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<T0>(arg1, arg0, arg3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<T0>(v1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

