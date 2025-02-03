module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::royalty_strategy_bps {
    struct BpsRoyaltyStrategy<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        royalty_fee_bps: u16,
        access_cap: 0x1::option::Option<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::BalanceAccessCap<T0>>,
        aggregator: 0x4a25c9153d59dd70d1ec7b27aca3bac94606233154c6dd27fb78261d71ad6080::balances::Balances,
        is_enabled: bool,
    }

    struct BpsRoyaltyStrategyRule has drop {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<T0>, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : BpsRoyaltyStrategy<T0> {
        let v0 = 0x2::object::new(arg3);
        0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::royalty::add_strategy(0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::royalty::borrow_domain_mut(0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::borrow_uid_mut<T0>(arg0, arg1)), 0x2::object::uid_to_inner(&v0));
        BpsRoyaltyStrategy<T0>{
            id              : v0,
            version         : 1,
            royalty_fee_bps : arg2,
            access_cap      : 0x1::option::none<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::BalanceAccessCap<T0>>(),
            aggregator      : 0x4a25c9153d59dd70d1ec7b27aca3bac94606233154c6dd27fb78261d71ad6080::balances::new(arg3),
            is_enabled      : true,
        }
    }

    public fun add_balance_access_cap<T0>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::BalanceAccessCap<T0>) {
        assert_version<T0>(arg0);
        arg0.access_cap = 0x1::option::some<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::BalanceAccessCap<T0>>(arg1);
    }

    fun assert_version<T0>(arg0: &BpsRoyaltyStrategy<T0>) {
        assert!(arg0.version == 1, 1000);
    }

    public fun calculate<T0>(arg0: &BpsRoyaltyStrategy<T0>, arg1: u64) : u64 {
        compute_(royalty_fee_bps<T0>(arg0), arg1)
    }

    public fun collect_royalties<T0, T1>(arg0: &mut 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<T0>, arg1: &mut BpsRoyaltyStrategy<T0>) {
        assert_version<T0>(arg1);
        let v0 = 0x4a25c9153d59dd70d1ec7b27aca3bac94606233154c6dd27fb78261d71ad6080::balances::borrow_mut<T1>(&mut arg1.aggregator);
        0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::royalty::collect_royalty<T0, T1>(arg0, v0, 0x2::balance::value<T1>(v0));
    }

    fun compute_(arg0: u16, arg1: u64) : u64 {
        let (_, v1) = 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::math::div_round((arg0 as u64), (0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::bps() as u64));
        let (_, v3) = 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::math::mul_round(arg1, v1);
        v3
    }

    public fun confirm_transfer<T0, T1>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::TransferRequest<T0>) {
        assert_version<T0>(arg0);
        assert!(arg0.is_enabled, 1);
        let (v0, _) = 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::paid_in_ft_mut<T0, T1>(arg1, 0x1::option::borrow<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::BalanceAccessCap<T0>>(&arg0.access_cap));
        0x4a25c9153d59dd70d1ec7b27aca3bac94606233154c6dd27fb78261d71ad6080::balances::take_from<T1>(&mut arg0.aggregator, v0, calculate<T0>(arg0, 0x2::balance::value<T1>(v0)));
        let v2 = BpsRoyaltyStrategyRule{dummy_field: false};
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::add_receipt<T0, BpsRoyaltyStrategyRule>(arg1, v2);
    }

    public fun confirm_transfer_with_balance<T0, T1>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::TransferRequest<T0>, arg2: &mut 0x2::balance::Balance<T1>) {
        assert_version<T0>(arg0);
        assert!(arg0.is_enabled, 1);
        let (v0, _) = 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::paid_in_ft<T0, T1>(arg1);
        0x4a25c9153d59dd70d1ec7b27aca3bac94606233154c6dd27fb78261d71ad6080::balances::take_from<T1>(&mut arg0.aggregator, arg2, calculate<T0>(arg0, v0));
        let v2 = BpsRoyaltyStrategyRule{dummy_field: false};
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::add_receipt<T0, BpsRoyaltyStrategyRule>(arg1, v2);
    }

    public fun create_domain_and_add_strategy<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<T0>, arg2: 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::royalty::RoyaltyDomain, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::add_domain<T0, 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::royalty::RoyaltyDomain>(arg0, arg1, arg2);
        let v0 = new<T0>(arg0, arg1, arg3, arg4);
        let v1 = &mut v0;
        add_balance_access_cap<T0>(v1, 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::grant_balance_access_cap<T0>(arg0));
        share<T0>(v0);
    }

    public fun disable<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut BpsRoyaltyStrategy<T0>) {
        assert_version<T0>(arg1);
        arg1.is_enabled = false;
    }

    public fun drop<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::remove_originbyte_rule<T0, BpsRoyaltyStrategyRule, bool>(arg0, arg1);
    }

    public fun drop_<T0, T1>(arg0: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::Policy<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>>, arg1: &0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::PolicyCap) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::drop_rule_no_state<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>, BpsRoyaltyStrategyRule>(arg0, arg1);
    }

    public fun drop_balance_access_cap<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut BpsRoyaltyStrategy<T0>) {
        assert_version<T0>(arg1);
        arg1.access_cap = 0x1::option::none<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::BalanceAccessCap<T0>>();
    }

    public fun enable<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut BpsRoyaltyStrategy<T0>) {
        assert_version<T0>(arg1);
        arg1.is_enabled = true;
    }

    public fun enforce<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = BpsRoyaltyStrategyRule{dummy_field: false};
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::add_originbyte_rule<T0, BpsRoyaltyStrategyRule, bool>(v0, arg0, arg1, false);
    }

    public fun enforce_<T0, T1>(arg0: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::Policy<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>>, arg1: &0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::PolicyCap) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::enforce_rule_no_state<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>, BpsRoyaltyStrategyRule>(arg0, arg1);
    }

    entry fun migrate_as_creator<T0>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg1), 0);
        arg0.version = 1;
    }

    entry fun migrate_as_pub<T0>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::nft_protocol::NFT_PROTOCOL>(arg1), 0);
        arg0.version = 1;
    }

    public fun royalty_fee_bps<T0>(arg0: &BpsRoyaltyStrategy<T0>) : u16 {
        arg0.royalty_fee_bps
    }

    public fun share<T0>(arg0: BpsRoyaltyStrategy<T0>) {
        0x2::transfer::share_object<BpsRoyaltyStrategy<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

