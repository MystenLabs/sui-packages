module 0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::xmoney_manager {
    struct XMoneyVault has key {
        id: 0x2::object::UID,
        version: u64,
        is_active: bool,
        has_open_position_tier1: bool,
        has_open_position_tier0: bool,
        authorized_depositor: address,
        treasury_address: address,
        treasury_share_bps: u64,
        xmn_balance: 0x2::balance::Balance<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>,
        total_rewards_claimed: u64,
        total_treasury_sent: u64,
    }

    struct VaultInitializedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        authorized_depositor: address,
        treasury_address: address,
        treasury_share_bps: u64,
    }

    struct AuthorizedDepositorUpdatedEvent has copy, drop {
        old_depositor: address,
        new_depositor: address,
    }

    struct OpenPositionTier1DepositedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        open_position_id: 0x2::object::ID,
    }

    struct OpenPositionTier1WithdrawnEvent has copy, drop {
        vault_id: 0x2::object::ID,
        to: address,
    }

    struct RewardsTier1ClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        total_claimed: u64,
        treasury_amount: u64,
        staker_amount: u64,
    }

    struct OpenPositionTier0DepositedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        open_position_id: 0x2::object::ID,
    }

    struct OpenPositionTier0WithdrawnEvent has copy, drop {
        vault_id: 0x2::object::ID,
        to: address,
    }

    struct RewardsTier0ClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        total_claimed: u64,
        treasury_amount: u64,
        staker_amount: u64,
    }

    struct XmnWithdrawnEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    struct TreasuryAddressUpdatedEvent has copy, drop {
        old_address: address,
        new_address: address,
    }

    struct TreasuryShareUpdatedEvent has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct SetPackageVersion has copy, drop {
        sender: address,
        new_version: u64,
        old_version: u64,
    }

    public entry fun create_operator(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::create_operator(arg0, arg1, arg2);
    }

    public entry fun transfer_admin(arg0: 0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::transfer_admin(arg0, arg1, arg2);
    }

    public entry fun transfer_operator(arg0: 0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::OperatorCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::transfer_operator(arg0, arg1, arg2);
    }

    fun assert_active(arg0: &XMoneyVault) {
        assert!(arg0.is_active, 2);
    }

    fun assert_version(arg0: &XMoneyVault) {
        assert!(arg0.version == 1, 1);
    }

    public fun authorized_depositor(arg0: &XMoneyVault) : address {
        arg0.authorized_depositor
    }

    public fun compound_rewards_tier0(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::OperatorCap, arg1: &mut XMoneyVault, arg2: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_active(arg1);
        assert!(arg1.has_open_position_tier0, 8);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::sync<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(arg2, arg3);
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::claim<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(arg2, 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>>(&mut arg1.id, b"open_position_tier0"), arg4);
        let v1 = 0x2::coin::value<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>(&v0);
        assert!(v1 > 0, 6);
        let v2 = v1 * arg1.treasury_share_bps / 10000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>>(0x2::coin::split<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>(&mut v0, v2, arg4), arg1.treasury_address);
        };
        0x2::coin::put<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>(&mut arg1.xmn_balance, v0);
        arg1.total_rewards_claimed = arg1.total_rewards_claimed + v1;
        arg1.total_treasury_sent = arg1.total_treasury_sent + v2;
        let v3 = RewardsTier0ClaimedEvent{
            vault_id        : 0x2::object::id<XMoneyVault>(arg1),
            total_claimed   : v1,
            treasury_amount : v2,
            staker_amount   : v1 - v2,
        };
        0x2::event::emit<RewardsTier0ClaimedEvent>(v3);
    }

    public fun compound_rewards_tier1(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::OperatorCap, arg1: &mut XMoneyVault, arg2: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_active(arg1);
        assert!(arg1.has_open_position_tier1, 3);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::sync<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(arg2, arg3);
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::claim_locked<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(arg2, 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>>(&mut arg1.id, b"open_position"), arg4);
        let v1 = 0x2::coin::value<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>(&v0);
        assert!(v1 > 0, 6);
        let v2 = v1 * arg1.treasury_share_bps / 10000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>>(0x2::coin::split<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>(&mut v0, v2, arg4), arg1.treasury_address);
        };
        0x2::coin::put<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>(&mut arg1.xmn_balance, v0);
        arg1.total_rewards_claimed = arg1.total_rewards_claimed + v1;
        arg1.total_treasury_sent = arg1.total_treasury_sent + v2;
        let v3 = RewardsTier1ClaimedEvent{
            vault_id        : 0x2::object::id<XMoneyVault>(arg1),
            total_claimed   : v1,
            treasury_amount : v2,
            staker_amount   : v1 - v2,
        };
        0x2::event::emit<RewardsTier1ClaimedEvent>(v3);
    }

    public fun deposit_open_position_tier0(arg0: &mut XMoneyVault, arg1: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.authorized_depositor, 7);
        assert!(!arg0.has_open_position_tier0, 9);
        0x2::dynamic_object_field::add<vector<u8>, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>>(&mut arg0.id, b"open_position_tier0", arg1);
        arg0.has_open_position_tier0 = true;
        let v0 = OpenPositionTier0DepositedEvent{
            vault_id         : 0x2::object::id<XMoneyVault>(arg0),
            open_position_id : 0x2::object::id<0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>>(&arg1),
        };
        0x2::event::emit<OpenPositionTier0DepositedEvent>(v0);
    }

    public fun deposit_open_position_tier1(arg0: &mut XMoneyVault, arg1: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.authorized_depositor, 7);
        assert!(!arg0.has_open_position_tier1, 4);
        0x2::dynamic_object_field::add<vector<u8>, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>>(&mut arg0.id, b"open_position", arg1);
        arg0.has_open_position_tier1 = true;
        let v0 = OpenPositionTier1DepositedEvent{
            vault_id         : 0x2::object::id<XMoneyVault>(arg0),
            open_position_id : 0x2::object::id<0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>>(&arg1),
        };
        0x2::event::emit<OpenPositionTier1DepositedEvent>(v0);
    }

    public fun has_open_position_tier0(arg0: &XMoneyVault) : bool {
        arg0.has_open_position_tier0
    }

    public fun has_open_position_tier1(arg0: &XMoneyVault) : bool {
        arg0.has_open_position_tier1
    }

    public fun initialize(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = XMoneyVault{
            id                      : 0x2::object::new(arg3),
            version                 : 1,
            is_active               : true,
            has_open_position_tier1 : false,
            has_open_position_tier0 : false,
            authorized_depositor    : arg1,
            treasury_address        : arg2,
            treasury_share_bps      : 3000,
            xmn_balance             : 0x2::balance::zero<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>(),
            total_rewards_claimed   : 0,
            total_treasury_sent     : 0,
        };
        let v1 = VaultInitializedEvent{
            vault_id             : 0x2::object::id<XMoneyVault>(&v0),
            authorized_depositor : arg1,
            treasury_address     : arg2,
            treasury_share_bps   : 3000,
        };
        0x2::event::emit<VaultInitializedEvent>(v1);
        0x2::transfer::share_object<XMoneyVault>(v0);
    }

    public fun request_unstake_tier0(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::OperatorCap, arg1: &mut XMoneyVault, arg2: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_active(arg1);
        assert!(arg1.has_open_position_tier0, 8);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::request_unstake<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(arg2, 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>>(&mut arg1.id, b"open_position_tier0"), arg3, arg4, arg5);
    }

    public fun request_unstake_tier1(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::OperatorCap, arg1: &mut XMoneyVault, arg2: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_active(arg1);
        assert!(arg1.has_open_position_tier1, 3);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::request_unstake_locked<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(arg2, 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>>(&mut arg1.id, b"open_position"), arg3, arg4, arg5);
    }

    public entry fun set_active(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: &mut XMoneyVault, arg2: bool) {
        arg1.is_active = arg2;
    }

    public entry fun set_authorized_depositor(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: &mut XMoneyVault, arg2: address) {
        assert_version(arg1);
        let v0 = AuthorizedDepositorUpdatedEvent{
            old_depositor : arg1.authorized_depositor,
            new_depositor : arg2,
        };
        0x2::event::emit<AuthorizedDepositorUpdatedEvent>(v0);
        arg1.authorized_depositor = arg2;
    }

    public fun set_package_version(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: &mut XMoneyVault, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg1.version;
        assert!(arg2 > v0, 10);
        arg1.version = arg2;
        let v1 = SetPackageVersion{
            sender      : 0x2::tx_context::sender(arg3),
            new_version : arg2,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersion>(v1);
    }

    public entry fun set_treasury_address(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: &mut XMoneyVault, arg2: address) {
        assert_version(arg1);
        let v0 = TreasuryAddressUpdatedEvent{
            old_address : arg1.treasury_address,
            new_address : arg2,
        };
        0x2::event::emit<TreasuryAddressUpdatedEvent>(v0);
        arg1.treasury_address = arg2;
    }

    public entry fun set_treasury_share_bps(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: &mut XMoneyVault, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 <= 10000, 5);
        let v0 = TreasuryShareUpdatedEvent{
            old_bps : arg1.treasury_share_bps,
            new_bps : arg2,
        };
        0x2::event::emit<TreasuryShareUpdatedEvent>(v0);
        arg1.treasury_share_bps = arg2;
    }

    public fun stake_more_tier0(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::OperatorCap, arg1: &mut XMoneyVault, arg2: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg3: 0x2::coin::Coin<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_active(arg1);
        assert!(arg1.has_open_position_tier0, 8);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::stake_more<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(arg2, 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>>(&mut arg1.id, b"open_position_tier0"), arg3, arg4, arg5);
    }

    public fun stake_more_tier1(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::OperatorCap, arg1: &mut XMoneyVault, arg2: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg3: &0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::Treasury<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg4: 0x2::token::Token<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_active(arg1);
        assert!(arg1.has_open_position_tier1, 3);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::stake_more_locked<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(arg2, arg3, 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>>(&mut arg1.id, b"open_position"), arg4, arg5, arg6);
    }

    public fun total_rewards_claimed(arg0: &XMoneyVault) : u64 {
        arg0.total_rewards_claimed
    }

    public fun total_treasury_sent(arg0: &XMoneyVault) : u64 {
        arg0.total_treasury_sent
    }

    public fun treasury_address(arg0: &XMoneyVault) : address {
        arg0.treasury_address
    }

    public fun treasury_share_bps(arg0: &XMoneyVault) : u64 {
        arg0.treasury_share_bps
    }

    public fun withdraw_open_position_tier0(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: &mut XMoneyVault, arg2: address) {
        assert_version(arg1);
        assert!(arg1.has_open_position_tier0, 8);
        arg1.has_open_position_tier0 = false;
        0x2::transfer::public_transfer<0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>>(0x2::dynamic_object_field::remove<vector<u8>, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>>(&mut arg1.id, b"open_position_tier0"), arg2);
        let v0 = OpenPositionTier0WithdrawnEvent{
            vault_id : 0x2::object::id<XMoneyVault>(arg1),
            to       : arg2,
        };
        0x2::event::emit<OpenPositionTier0WithdrawnEvent>(v0);
    }

    public fun withdraw_open_position_tier1(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: &mut XMoneyVault, arg2: address) {
        assert_version(arg1);
        assert!(arg1.has_open_position_tier1, 3);
        arg1.has_open_position_tier1 = false;
        0x2::transfer::public_transfer<0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>>(0x2::dynamic_object_field::remove<vector<u8>, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>>(&mut arg1.id, b"open_position"), arg2);
        let v0 = OpenPositionTier1WithdrawnEvent{
            vault_id : 0x2::object::id<XMoneyVault>(arg1),
            to       : arg2,
        };
        0x2::event::emit<OpenPositionTier1WithdrawnEvent>(v0);
    }

    public fun withdraw_xmn(arg0: &0xc1e8790ad7691dbaaebede4d89c7ac399b72fa131a8dfec064bff53df770bd0d::permission::AdminCap, arg1: &mut XMoneyVault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>>(0x2::coin::take<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>(&mut arg1.xmn_balance, arg2, arg4), arg3);
        let v0 = XmnWithdrawnEvent{
            vault_id : 0x2::object::id<XMoneyVault>(arg1),
            amount   : arg2,
            to       : arg3,
        };
        0x2::event::emit<XmnWithdrawnEvent>(v0);
    }

    public fun xmn_balance(arg0: &XMoneyVault) : u64 {
        0x2::balance::value<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN>(&arg0.xmn_balance)
    }

    // decompiled from Move bytecode v7
}

