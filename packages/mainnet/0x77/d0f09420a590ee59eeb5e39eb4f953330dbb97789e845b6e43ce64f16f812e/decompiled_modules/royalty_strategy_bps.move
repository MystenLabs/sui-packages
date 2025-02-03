module 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps {
    struct BpsRoyaltyStrategy<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        royalty_fee_bps: u16,
        access_cap: 0x1::option::Option<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::BalanceAccessCap<T0>>,
        aggregator: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::balances::Balances,
        is_enabled: bool,
    }

    struct BpsRoyaltyStrategyRule has drop {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : BpsRoyaltyStrategy<T0> {
        let v0 = 0x2::object::new(arg3);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::add_strategy(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::borrow_domain_mut(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid_mut<T0>(arg0, arg1)), 0x2::object::uid_to_inner(&v0));
        BpsRoyaltyStrategy<T0>{
            id              : v0,
            version         : 3,
            royalty_fee_bps : arg2,
            access_cap      : 0x1::option::none<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::BalanceAccessCap<T0>>(),
            aggregator      : 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::balances::new(arg3),
            is_enabled      : true,
        }
    }

    public fun add_balance_access_cap<T0>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::BalanceAccessCap<T0>) {
        assert_version_and_upgrade<T0>(arg0);
        arg0.access_cap = 0x1::option::some<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::BalanceAccessCap<T0>>(arg1);
    }

    fun assert_version<T0>(arg0: &BpsRoyaltyStrategy<T0>) {
        assert!(arg0.version == 3, 1000);
    }

    fun assert_version_and_upgrade<T0>(arg0: &mut BpsRoyaltyStrategy<T0>) {
        if (arg0.version < 3) {
            arg0.version = 3;
        };
        assert_version<T0>(arg0);
    }

    public fun calculate<T0>(arg0: &BpsRoyaltyStrategy<T0>, arg1: u64) : u64 {
        compute_(royalty_fee_bps<T0>(arg0), arg1)
    }

    public fun collect_royalties<T0, T1>(arg0: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg1: &mut BpsRoyaltyStrategy<T0>) {
        assert_version_and_upgrade<T0>(arg1);
        let v0 = 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::balances::borrow_mut<T1>(&mut arg1.aggregator);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::collect_royalty<T0, T1>(arg0, v0, 0x2::balance::value<T1>(v0));
    }

    fun compute_(arg0: u16, arg1: u64) : u64 {
        let (_, v1) = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::math::div_round((arg0 as u64), (0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::bps() as u64));
        let (_, v3) = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::math::mul_round(arg1, v1);
        v3
    }

    public fun confirm_transfer<T0, T1>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>) {
        assert_version_and_upgrade<T0>(arg0);
        assert!(arg0.is_enabled, 1);
        let (v0, _) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::paid_in_ft_mut<T0, T1>(arg1, 0x1::option::borrow<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::BalanceAccessCap<T0>>(&arg0.access_cap));
        0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::balances::take_from<T1>(&mut arg0.aggregator, v0, calculate<T0>(arg0, 0x2::balance::value<T1>(v0)));
        let v2 = BpsRoyaltyStrategyRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::add_receipt<T0, BpsRoyaltyStrategyRule>(arg1, v2);
    }

    public fun confirm_transfer_with_balance<T0, T1>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>, arg2: &mut 0x2::balance::Balance<T1>) {
        assert_version_and_upgrade<T0>(arg0);
        assert!(arg0.is_enabled, 1);
        let (v0, _) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::paid_in_ft<T0, T1>(arg1);
        0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::balances::take_from<T1>(&mut arg0.aggregator, arg2, calculate<T0>(arg0, v0));
        let v2 = BpsRoyaltyStrategyRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::add_receipt<T0, BpsRoyaltyStrategyRule>(arg1, v2);
    }

    public fun confirm_transfer_with_balance_with_fees<T0, T1>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 998
    }

    public fun confirm_transfer_with_fees<T0, T1>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 998
    }

    public fun create_domain_and_add_strategy<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg2: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::RoyaltyDomain, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<T0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::RoyaltyDomain>(arg0, arg1, arg2);
        let v0 = new<T0>(arg0, arg1, arg3, arg4);
        let v1 = &mut v0;
        add_balance_access_cap<T0>(v1, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::grant_balance_access_cap<T0>(arg0));
        share<T0>(v0);
    }

    public fun disable<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut BpsRoyaltyStrategy<T0>) {
        assert_version_and_upgrade<T0>(arg1);
        arg1.is_enabled = false;
    }

    public fun drop<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::remove_originbyte_rule<T0, BpsRoyaltyStrategyRule, bool>(arg0, arg1);
    }

    public fun drop_<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::drop_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, BpsRoyaltyStrategyRule>(arg0, arg1);
    }

    public fun drop_balance_access_cap<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut BpsRoyaltyStrategy<T0>) {
        assert_version_and_upgrade<T0>(arg1);
        arg1.access_cap = 0x1::option::none<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::BalanceAccessCap<T0>>();
    }

    public fun enable<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut BpsRoyaltyStrategy<T0>) {
        assert_version_and_upgrade<T0>(arg1);
        arg1.is_enabled = true;
    }

    public entry fun enforce<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = BpsRoyaltyStrategyRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::add_originbyte_rule<T0, BpsRoyaltyStrategyRule, bool>(v0, arg0, arg1, false);
    }

    public entry fun enforce_<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, BpsRoyaltyStrategyRule>(arg0, arg1);
    }

    entry fun migrate_as_creator<T0>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg1), 0);
        arg0.version = 3;
    }

    entry fun migrate_as_pub<T0>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_protocol::NFT_PROTOCOL>(arg1), 0);
        arg0.version = 3;
    }

    public fun royalty_fee_bps<T0>(arg0: &BpsRoyaltyStrategy<T0>) : u16 {
        arg0.royalty_fee_bps
    }

    public fun share<T0>(arg0: BpsRoyaltyStrategy<T0>) {
        0x2::transfer::share_object<BpsRoyaltyStrategy<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

