module 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::TOKEN {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct StakedToken has store, key {
        id: 0x2::object::UID,
        balance: 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::SBalance<TOKEN>,
        profit: 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::SBalance<TOKEN>,
        start_epoch: u64,
        end_epoch: u64,
        boost: u128,
    }

    struct LinearUnlockStakedToken has key {
        id: 0x2::object::UID,
        origin_id: 0x2::object::ID,
        inner: StakedToken,
    }

    struct TestToken has drop {
        dummy_field: bool,
    }

    struct TestBNB has drop {
        dummy_field: bool,
    }

    struct TestBTC has drop {
        dummy_field: bool,
    }

    struct TestDAI has drop {
        dummy_field: bool,
    }

    struct TestETH has drop {
        dummy_field: bool,
    }

    struct TestSOL has drop {
        dummy_field: bool,
    }

    struct TestUSDC has drop {
        dummy_field: bool,
    }

    struct TestUSDT has drop {
        dummy_field: bool,
    }

    struct TokenBank has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        balance: 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::SBalance<TOKEN>,
        admin_balance: 0x2::balance::Balance<TOKEN>,
        early_unlock_fee: 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::ratio::Ratio,
        stats_liquidity_mine_amount: u64,
        token_farm_ids: vector<0x2::object::ID>,
        token_ido_ids: vector<0x2::object::ID>,
        token_airdrop_ids: vector<0x2::object::ID>,
    }

    struct TokenAirdrop has key {
        id: 0x2::object::UID,
        version: u64,
        verify_id: 0x2::object::ID,
        public_key: vector<u8>,
        bank_id: 0x2::object::ID,
        owner: address,
        free_amount: u64,
        name: vector<u8>,
        address_table: 0x2::table::Table<address, u8>,
        balance: 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::SBalance<TOKEN>,
        allow_duplicate: bool,
    }

    struct TokenFarmIndexValue has copy, drop, store {
        profit: u64,
        boost_multiplier: u64,
    }

    struct TokenFarm has key {
        id: 0x2::object::UID,
        version: u64,
        bank_id: 0x2::object::ID,
        base_epochs: u64,
        min_stake_index: u64,
        stake_index_table: 0x2::table::Table<u64, TokenFarmIndexValue>,
        total_stake_amount: u64,
        total_stake_boost: u128,
    }

    struct TokenIdo has key {
        id: 0x2::object::UID,
        version: u64,
        bank_id: 0x2::object::ID,
        name: vector<u8>,
        price_e9: u64,
        is_public: bool,
        whitelists: 0x2::table::Table<address, u8>,
        is_whitelists_editable: bool,
        collect: 0x2::balance::Balance<0x2::sui::SUI>,
        balance: 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::SBalance<TOKEN>,
    }

    struct TestTokenSupply has key {
        id: 0x2::object::UID,
        version: u64,
        supply: 0x2::balance::Supply<TestToken>,
        supply_bnb: 0x2::balance::Supply<TestBNB>,
        supply_btc: 0x2::balance::Supply<TestBTC>,
        supply_dai: 0x2::balance::Supply<TestDAI>,
        supply_eth: 0x2::balance::Supply<TestETH>,
        supply_sol: 0x2::balance::Supply<TestSOL>,
        supply_usdc: 0x2::balance::Supply<TestUSDC>,
        supply_usdt: 0x2::balance::Supply<TestUSDT>,
    }

    struct TokenCap has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<TOKEN>,
        token_bank_permission: 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenBank>,
        token_airdrop_permission: 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenAirdrop>,
        token_farm_permission: 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenFarm>,
        token_ido_permission: 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenIdo>,
        bank_id: 0x2::object::ID,
        coin_metadata_id: 0x2::object::ID,
        test_token_supply_id: 0x2::object::ID,
    }

    struct IncreaseTokenSupplyEvent has copy, drop {
        bank_id: 0x2::object::ID,
        amount: u64,
    }

    struct SendTokenEvent has copy, drop {
        token_id: 0x2::object::ID,
        bank_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        token_type: u8,
    }

    struct ClaimTokenAirdropEvent has copy, drop {
        airdrop_id: 0x2::object::ID,
        amount: u64,
    }

    struct AddTokenIdoWhitelistEvent has copy, drop {
        ido_id: 0x2::object::ID,
    }

    struct BuyTokenIdoTokenEvent has copy, drop {
        ido_id: 0x2::object::ID,
        in_amount: u64,
        out_amount: u64,
    }

    struct StakeTokenEvent has copy, drop {
        st_id: 0x2::object::ID,
    }

    struct UnlockStakeTokenEvent has copy, drop {
        st_id: 0x2::object::ID,
    }

    struct UnwrapLinearUnlockStakedTokenEvent has copy, drop {
        st_id: 0x2::object::ID,
    }

    public entry fun add_token_ido_whitelist(arg0: &mut TokenIdo, arg1: &mut 0x2::tx_context::TxContext) {
        do_add_token_ido_whitelist(arg0, arg1);
    }

    public entry fun admin_mint_test_token(arg0: &TokenCap, arg1: &mut TestTokenSupply, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestToken>(&mut arg1.supply, arg2, arg3, arg4);
    }

    public entry fun admin_mint_test_token_bnb(arg0: &TokenCap, arg1: &mut TestTokenSupply, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestBNB>(&mut arg1.supply_bnb, arg2, arg3, arg4);
    }

    public entry fun admin_mint_test_token_btc(arg0: &TokenCap, arg1: &mut TestTokenSupply, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestBTC>(&mut arg1.supply_btc, arg2, arg3, arg4);
    }

    public entry fun admin_mint_test_token_dai(arg0: &TokenCap, arg1: &mut TestTokenSupply, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestDAI>(&mut arg1.supply_dai, arg2, arg3, arg4);
    }

    public entry fun admin_mint_test_token_eth(arg0: &TokenCap, arg1: &mut TestTokenSupply, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestETH>(&mut arg1.supply_eth, arg2, arg3, arg4);
    }

    public entry fun admin_mint_test_token_sol(arg0: &TokenCap, arg1: &mut TestTokenSupply, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestSOL>(&mut arg1.supply_sol, arg2, arg3, arg4);
    }

    public entry fun admin_mint_test_token_usdc(arg0: &TokenCap, arg1: &mut TestTokenSupply, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestUSDC>(&mut arg1.supply_usdc, arg2, arg3, arg4);
    }

    public entry fun admin_mint_test_token_usdt(arg0: &TokenCap, arg1: &mut TestTokenSupply, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestUSDT>(&mut arg1.supply_usdt, arg2, arg3, arg4);
    }

    public entry fun buy_token_ido_token(arg0: &mut TokenIdo, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        do_buy_token_ido_token(arg0, arg1, arg2, arg3);
    }

    public entry fun change_token_ido_publicity(arg0: &TokenCap, arg1: &mut TokenIdo, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        do_change_token_ido_publicity(&arg0.token_ido_permission, arg1, arg2, arg3);
    }

    public entry fun change_token_ido_whitelists_editable(arg0: &TokenCap, arg1: &mut TokenIdo, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        do_change_token_ido_whitelists_editable(&arg0.token_ido_permission, arg1, arg2, arg3);
    }

    public entry fun claim_token_airdrop_token(arg0: &mut TokenAirdrop, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        do_claim_token_airdrop_token(arg0, arg1, arg2, arg3);
    }

    fun create_linear_unlock_stake_token(arg0: 0x2::balance::Balance<TOKEN>, arg1: 0x2::balance::Balance<TOKEN>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : LinearUnlockStakedToken {
        let v0 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::get_epoch(arg5) + arg2;
        let v1 = StakedToken{
            id          : 0x2::object::new(arg6),
            balance     : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::from_balance<TOKEN>(arg0),
            profit      : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::from_balance<TOKEN>(arg1),
            start_epoch : v0,
            end_epoch   : v0 + arg3,
            boost       : (0x2::balance::value<TOKEN>(&arg0) as u128) * (arg4 as u128),
        };
        let v2 = 0x2::object::new(arg6);
        LinearUnlockStakedToken{
            id        : v2,
            origin_id : 0x2::object::uid_to_inner(&v2),
            inner     : v1,
        }
    }

    fun create_stake_token(arg0: &mut TokenFarm, arg1: 0x2::balance::Balance<TOKEN>, arg2: 0x2::balance::Balance<TOKEN>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : StakedToken {
        assert!(arg5 > 0, 14400);
        let v0 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::get_epoch(arg6) + arg3;
        let v1 = 0x2::balance::value<TOKEN>(&arg1);
        let v2 = (v1 as u128) * (arg5 as u128);
        arg0.total_stake_amount = arg0.total_stake_amount + v1;
        arg0.total_stake_boost = arg0.total_stake_boost + v2;
        StakedToken{
            id          : 0x2::object::new(arg7),
            balance     : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::from_balance<TOKEN>(arg1),
            profit      : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::from_balance<TOKEN>(arg2),
            start_epoch : v0,
            end_epoch   : v0 + arg4,
            boost       : v2,
        }
    }

    public entry fun create_token_airdrop(arg0: &TokenCap, arg1: &mut TokenBank, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        do_create_token_airdrop(&arg0.token_bank_permission, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun create_token_farm(arg0: &TokenCap, arg1: &mut TokenBank, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        do_create_token_farm(&arg0.token_bank_permission, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun create_token_ido(arg0: &TokenCap, arg1: &mut TokenBank, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        do_create_token_ido(&arg0.token_bank_permission, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun decrease_linear_unlock_stake_token(arg0: &mut LinearUnlockStakedToken, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<TOKEN> {
        let v0 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::get_epoch(arg1);
        assert!(v0 >= arg0.inner.start_epoch, 144010);
        let v1 = &mut arg0.inner;
        let v2 = if (v1.end_epoch == v1.start_epoch || v0 >= v1.end_epoch) {
            0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::ratio::ratio(0, 1)
        } else {
            let v3 = v1.end_epoch - v1.start_epoch;
            0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::ratio::ratio(v3 - 0x2::math::min(v0, v1.end_epoch) - v1.start_epoch, v3)
        };
        let v4 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::ratio::partial(v2, 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::supply<TOKEN>(&v1.balance));
        let v5 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::ratio::partial(v2, 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::supply<TOKEN>(&v1.profit));
        let v6 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&v1.balance);
        let v7 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&v1.profit);
        let v8 = if (v4 <= v6) {
            v6 - v4
        } else {
            0
        };
        let v9 = if (v5 <= v7) {
            v7 - v5
        } else {
            0
        };
        let v10 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split<TOKEN>(&mut v1.balance, v8);
        0x2::balance::join<TOKEN>(&mut v10, 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split<TOKEN>(&mut v1.profit, v9));
        v10
    }

    fun destroy_stake_token(arg0: &mut TokenFarm, arg1: StakedToken, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<TOKEN> {
        assert!(0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::get_epoch(arg2) >= arg1.end_epoch, 144010);
        destroy_stake_token_force(arg0, arg1)
    }

    fun destroy_stake_token_force(arg0: &mut TokenFarm, arg1: StakedToken) : 0x2::balance::Balance<TOKEN> {
        arg0.total_stake_amount = arg0.total_stake_amount - 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg1.balance);
        arg0.total_stake_boost = arg0.total_stake_boost - arg1.boost;
        let StakedToken {
            id          : v0,
            balance     : v1,
            profit      : v2,
            start_epoch : _,
            end_epoch   : _,
            boost       : _,
        } = arg1;
        0x2::object::delete(v0);
        let v6 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::into_balance<TOKEN>(v1);
        0x2::balance::join<TOKEN>(&mut v6, 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::into_balance<TOKEN>(v2));
        v6
    }

    fun destroy_zero_stake_token(arg0: StakedToken) {
        assert!(is_zero_stake_token(&arg0) == true, 144011);
        let StakedToken {
            id          : v0,
            balance     : v1,
            profit      : v2,
            start_epoch : _,
            end_epoch   : _,
            boost       : _,
        } = arg0;
        0x2::object::delete(v0);
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::destroy_zero<TOKEN>(v1);
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::destroy_zero<TOKEN>(v2);
    }

    public fun do_add_token_ido_whitelist(arg0: &mut TokenIdo, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 200000);
        assert!(arg0.is_whitelists_editable == true, 144004);
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, u8>(&arg0.whitelists, v0) == false) {
            0x2::table::add<address, u8>(&mut arg0.whitelists, v0, 1);
        };
        let v1 = AddTokenIdoWhitelistEvent{ido_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<AddTokenIdoWhitelistEvent>(v1);
    }

    public fun do_buy_token_ido_token(arg0: &mut TokenIdo, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 200000);
        assert!(token_ido_is_public_or_has_whitelist_address(arg0, 0x2::tx_context::sender(arg3)) == true, 144005);
        let v0 = arg0.price_e9;
        let v1 = (((arg2 as u128) * (v0 as u128) / 1000000000) as u64);
        let v2 = v1;
        let v3 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.balance);
        if (v1 > v3) {
            v2 = v3;
            let v4 = (v0 as u128);
            arg2 = ((((v3 as u128) * (1000000000 as u128) + v4 - 1) / v4) as u64);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collect, 0x2::coin::into_balance<0x2::sui::SUI>(0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::merge_coins_to_amount_and_transfer_back_rest<0x2::sui::SUI>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::from_balance<TOKEN>(0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split<TOKEN>(&mut arg0.balance, v2), arg3), 0x2::tx_context::sender(arg3));
        let v5 = BuyTokenIdoTokenEvent{
            ido_id     : 0x2::object::uid_to_inner(&arg0.id),
            in_amount  : arg2,
            out_amount : v2,
        };
        0x2::event::emit<BuyTokenIdoTokenEvent>(v5);
    }

    public fun do_change_token_ido_publicity(arg0: &0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenIdo>, arg1: &mut TokenIdo, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        arg1.is_public = arg2;
    }

    public fun do_change_token_ido_whitelists_editable(arg0: &0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenIdo>, arg1: &mut TokenIdo, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        arg1.is_whitelists_editable = arg2;
    }

    public fun do_claim_token_airdrop_token(arg0: &mut TokenAirdrop, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        do_claim_token_airdrop_token_legacy(arg0, arg1, arg2, arg3);
        let v0 = ClaimTokenAirdropEvent{
            airdrop_id : 0x2::object::uid_to_inner(&arg0.id),
            amount     : arg1,
        };
        0x2::event::emit<ClaimTokenAirdropEvent>(v0);
    }

    public fun do_claim_token_airdrop_token_legacy(arg0: &mut TokenAirdrop, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 200000);
        assert!(arg1 <= 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.balance), 144001);
        if (arg0.allow_duplicate == false) {
            assert!(token_airdrop_has_used_address(arg0, 0x2::tx_context::sender(arg3)) == false, 144002);
        };
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (token_airdrop_is_free(arg0)) {
            arg1 == arg0.free_amount
        } else {
            let v2 = arg0.name;
            0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0.verify_id));
            0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v0));
            0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg1));
            0x2::ed25519::ed25519_verify(&arg2, &arg0.public_key, &v2)
        };
        assert!(v1, 144003);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::from_balance<TOKEN>(0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split<TOKEN>(&mut arg0.balance, arg1), arg3), v0);
        if (arg0.allow_duplicate == false) {
            0x2::table::add<address, u8>(&mut arg0.address_table, v0, 1);
        };
    }

    public fun do_create_token_airdrop(arg0: &0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenBank>, arg1: &mut TokenBank, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        assert!(arg4 > 0, 14400);
        assert!(arg5 <= arg4, 14400);
        assert!(arg4 <= 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg1.balance), 144001);
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::object::uid_to_inner(&v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.token_airdrop_ids, v1);
        let v2 = TokenAirdrop{
            id              : v0,
            version         : 0,
            verify_id       : v1,
            public_key      : arg2,
            bank_id         : 0x2::object::uid_to_inner(&arg1.id),
            owner           : arg1.owner,
            free_amount     : arg5,
            name            : arg3,
            address_table   : 0x2::table::new<address, u8>(arg7),
            balance         : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::from_balance<TOKEN>(0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split<TOKEN>(&mut arg1.balance, arg4)),
            allow_duplicate : arg6,
        };
        0x2::transfer::share_object<TokenAirdrop>(v2);
    }

    public fun do_create_token_farm(arg0: &0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenBank>, arg1: &mut TokenBank, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        assert!(arg2 > 0, 14400);
        let v0 = 0x2::object::new(arg5);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.token_farm_ids, 0x2::object::uid_to_inner(&v0));
        let v1 = 0x2::table::new<u64, TokenFarmIndexValue>(arg5);
        while (0x1::vector::length<u64>(&arg4) > 0) {
            let v2 = TokenFarmIndexValue{
                profit           : 0x1::vector::pop_back<u64>(&mut arg4),
                boost_multiplier : 0x1::vector::pop_back<u64>(&mut arg4),
            };
            0x2::table::add<u64, TokenFarmIndexValue>(&mut v1, 0x1::vector::pop_back<u64>(&mut arg4), v2);
        };
        let v3 = TokenFarm{
            id                 : v0,
            version            : 0,
            bank_id            : 0x2::object::uid_to_inner(&arg1.id),
            base_epochs        : arg2,
            min_stake_index    : arg3,
            stake_index_table  : v1,
            total_stake_amount : 0,
            total_stake_boost  : 0,
        };
        0x2::transfer::share_object<TokenFarm>(v3);
    }

    public fun do_create_token_ido(arg0: &0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenBank>, arg1: &mut TokenBank, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        assert!(arg3 > 0, 14400);
        assert!(arg5 > 0, 14400);
        assert!(arg5 <= 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg1.balance), 144001);
        let v0 = 0x2::object::new(arg6);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.token_ido_ids, 0x2::object::uid_to_inner(&v0));
        let v1 = TokenIdo{
            id                     : v0,
            version                : 0,
            bank_id                : 0x2::object::uid_to_inner(&arg1.id),
            name                   : arg2,
            price_e9               : arg3,
            is_public              : arg4,
            whitelists             : 0x2::table::new<address, u8>(arg6),
            is_whitelists_editable : true,
            collect                : 0x2::balance::zero<0x2::sui::SUI>(),
            balance                : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::from_balance<TOKEN>(0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split<TOKEN>(&mut arg1.balance, arg5)),
        };
        0x2::transfer::share_object<TokenIdo>(v1);
    }

    public fun do_increase_token_supply(arg0: &mut TokenCap, arg1: &mut TokenBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        if (arg2 == 0) {
            return
        };
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::increase<TOKEN>(&mut arg1.balance, 0x2::coin::into_balance<TOKEN>(0x2::coin::mint<TOKEN>(&mut arg0.treasury_cap, arg2, arg3)));
        let v0 = IncreaseTokenSupplyEvent{
            bank_id : 0x2::object::uid_to_inner(&arg1.id),
            amount  : arg2,
        };
        0x2::event::emit<IncreaseTokenSupplyEvent>(v0);
    }

    public(friend) fun do_send_liquidity_mine_token(arg0: &0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenBank>, arg1: &mut TokenBank, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        do_send_token(arg0, arg1, arg2, arg3, arg4);
        arg1.stats_liquidity_mine_amount = arg1.stats_liquidity_mine_amount + arg2;
    }

    public fun do_send_staked_token(arg0: &0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenBank>, arg1: &mut TokenBank, arg2: &mut TokenFarm, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0 && arg2.version == 0, 200000);
        assert!(arg3 <= 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg1.balance), 144001);
        if (arg6 == false) {
            let v0 = create_stake_token(arg2, 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split<TOKEN>(&mut arg1.balance, arg3), 0x2::balance::zero<TOKEN>(), arg4, arg5, 10, arg8, arg9);
            0x2::transfer::transfer<StakedToken>(v0, arg7);
            let v1 = SendTokenEvent{
                token_id   : 0x2::object::uid_to_inner(&v0.id),
                bank_id    : 0x2::object::uid_to_inner(&arg1.id),
                amount     : arg3,
                recipient  : arg7,
                token_type : 0,
            };
            0x2::event::emit<SendTokenEvent>(v1);
        } else {
            let v2 = create_linear_unlock_stake_token(0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split<TOKEN>(&mut arg1.balance, arg3), 0x2::balance::zero<TOKEN>(), arg4, arg5, 10, arg8, arg9);
            0x2::transfer::transfer<LinearUnlockStakedToken>(v2, arg7);
            let v3 = SendTokenEvent{
                token_id   : 0x2::object::uid_to_inner(&v2.id),
                bank_id    : 0x2::object::uid_to_inner(&arg1.id),
                amount     : arg3,
                recipient  : arg7,
                token_type : 1,
            };
            0x2::event::emit<SendTokenEvent>(v3);
        };
    }

    public fun do_send_token(arg0: &0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenBank>, arg1: &mut TokenBank, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        if (arg2 == 0) {
            return
        };
        assert!(arg2 <= 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg1.balance), 144001);
        let v0 = 0x2::coin::from_balance<TOKEN>(0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split<TOKEN>(&mut arg1.balance, arg2), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(v0, arg3);
        let v1 = SendTokenEvent{
            token_id   : *0x2::object::borrow_id<0x2::coin::Coin<TOKEN>>(&v0),
            bank_id    : 0x2::object::uid_to_inner(&arg1.id),
            amount     : arg2,
            recipient  : arg3,
            token_type : 0,
        };
        0x2::event::emit<SendTokenEvent>(v1);
    }

    public fun do_stake_token(arg0: &mut TokenBank, arg1: &mut TokenFarm, arg2: 0x2::coin::Coin<TOKEN>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0 && arg1.version == 0, 200000);
        assert!(arg3 >= arg1.min_stake_index, 144012);
        assert!(0x2::coin::value<TOKEN>(&arg2) > 0, 14400);
        assert!(0x2::table::contains<u64, TokenFarmIndexValue>(&arg1.stake_index_table, arg3), 144008);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::table::borrow<u64, TokenFarmIndexValue>(&arg1.stake_index_table, arg3);
        let v2 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::ratio::partial(0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::ratio::ratio(v1.profit, 10000), 0x2::coin::value<TOKEN>(&arg2));
        let v3 = if (v2 <= 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.balance)) {
            0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split<TOKEN>(&mut arg0.balance, v2)
        } else {
            0x2::balance::zero<TOKEN>()
        };
        let v4 = v1.boost_multiplier;
        let v5 = arg3 * arg1.base_epochs;
        let v6 = create_stake_token(arg1, 0x2::coin::into_balance<TOKEN>(arg2), v3, 0, v5, v4, arg4, arg5);
        let v7 = StakeTokenEvent{st_id: 0x2::object::uid_to_inner(&v6.id)};
        0x2::event::emit<StakeTokenEvent>(v7);
        0x2::transfer::transfer<StakedToken>(v6, v0);
    }

    public fun do_unlock_linear_unlock_staked_token(arg0: LinearUnlockStakedToken, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0;
        let v2 = decrease_linear_unlock_stake_token(v1, arg1, arg2);
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::transfer_or_destroy_zero<TOKEN>(0x2::coin::from_balance<TOKEN>(v2, arg2), v0);
        let LinearUnlockStakedToken {
            id        : v3,
            origin_id : v4,
            inner     : v5,
        } = arg0;
        let v6 = v5;
        0x2::object::delete(v3);
        if (is_zero_stake_token(&v6)) {
            destroy_zero_stake_token(v6);
        } else {
            let v7 = LinearUnlockStakedToken{
                id        : 0x2::object::new(arg2),
                origin_id : v4,
                inner     : v6,
            };
            0x2::transfer::transfer<LinearUnlockStakedToken>(v7, v0);
        };
    }

    public fun do_unlock_staked_token(arg0: &mut TokenFarm, arg1: StakedToken, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 200000);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = UnlockStakeTokenEvent{st_id: 0x2::object::uid_to_inner(&arg1.id)};
        0x2::event::emit<UnlockStakeTokenEvent>(v1);
        let v2 = destroy_stake_token(arg0, arg1, arg2, arg3);
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::transfer_or_destroy_zero<TOKEN>(0x2::coin::from_balance<TOKEN>(v2, arg3), v0);
    }

    public fun do_unwrap_linear_unlock_staked_token(arg0: &mut TokenFarm, arg1: LinearUnlockStakedToken, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 200000);
        let v0 = unwrap_linear_unlock_stake_token(arg0, arg1, arg2, arg3);
        let v1 = UnwrapLinearUnlockStakedTokenEvent{st_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<UnwrapLinearUnlockStakedTokenEvent>(v1);
        transfer_or_destroy_zero_stake_token(v0, 0x2::tx_context::sender(arg3));
    }

    public fun do_withdraw_token_bank_admin_balance(arg0: &0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenBank>, arg1: &mut TokenBank, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::transfer_or_destroy_zero<TOKEN>(0x2::coin::from_balance<TOKEN>(0x2::balance::split<TOKEN>(&mut arg1.admin_balance, 0x2::balance::value<TOKEN>(&arg1.admin_balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun increase_token_supply(arg0: &mut TokenCap, arg1: &mut TokenBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        do_increase_token_supply(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        init_impl(arg0, arg1);
    }

    fun init_impl(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"SSWP", b"Suiswap Token", b"Suiswap Platform Governance Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suiswap.app/images/token/suiswap.svg"))), arg1);
        let v3 = v2;
        let v4 = TokenBank{
            id                          : 0x2::object::new(arg1),
            version                     : 0,
            owner                       : v0,
            balance                     : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::from_balance<TOKEN>(0x2::balance::zero<TOKEN>()),
            admin_balance               : 0x2::balance::zero<TOKEN>(),
            early_unlock_fee            : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::ratio::ratio(1000, 10000),
            stats_liquidity_mine_amount : 0,
            token_farm_ids              : 0x1::vector::empty<0x2::object::ID>(),
            token_ido_ids               : 0x1::vector::empty<0x2::object::ID>(),
            token_airdrop_ids           : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v5 = TestToken{dummy_field: false};
        let v6 = TestBNB{dummy_field: false};
        let v7 = TestBTC{dummy_field: false};
        let v8 = TestDAI{dummy_field: false};
        let v9 = TestETH{dummy_field: false};
        let v10 = TestSOL{dummy_field: false};
        let v11 = TestUSDC{dummy_field: false};
        let v12 = TestUSDT{dummy_field: false};
        let v13 = TestTokenSupply{
            id          : 0x2::object::new(arg1),
            version     : 0,
            supply      : 0x2::balance::create_supply<TestToken>(v5),
            supply_bnb  : 0x2::balance::create_supply<TestBNB>(v6),
            supply_btc  : 0x2::balance::create_supply<TestBTC>(v7),
            supply_dai  : 0x2::balance::create_supply<TestDAI>(v8),
            supply_eth  : 0x2::balance::create_supply<TestETH>(v9),
            supply_sol  : 0x2::balance::create_supply<TestSOL>(v10),
            supply_usdc : 0x2::balance::create_supply<TestUSDC>(v11),
            supply_usdt : 0x2::balance::create_supply<TestUSDT>(v12),
        };
        0x2::transfer::share_object<TestTokenSupply>(v13);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v3);
        0x2::transfer::share_object<TokenBank>(v4);
        let v14 = TokenCap{
            id                       : 0x2::object::new(arg1),
            treasury_cap             : v1,
            token_bank_permission    : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::new<TokenBank>(),
            token_airdrop_permission : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::new<TokenAirdrop>(),
            token_farm_permission    : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::new<TokenFarm>(),
            token_ido_permission     : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::new<TokenIdo>(),
            bank_id                  : 0x2::object::id<TokenBank>(&v4),
            coin_metadata_id         : 0x2::object::id<0x2::coin::CoinMetadata<TOKEN>>(&v3),
            test_token_supply_id     : 0x2::object::id<TestTokenSupply>(&v13),
        };
        0x2::transfer::transfer<TokenCap>(v14, v0);
    }

    fun is_zero_stake_token(arg0: &StakedToken) : bool {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.balance) == 0 && 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.profit) == 0
    }

    public fun linear_staked_token_get_end_epoch(arg0: &LinearUnlockStakedToken) : u64 {
        arg0.inner.end_epoch
    }

    public fun linear_staked_token_get_id(arg0: &LinearUnlockStakedToken) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun linear_staked_token_get_left_balance_value(arg0: &LinearUnlockStakedToken) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.inner.balance)
    }

    public fun linear_staked_token_get_left_profit_value(arg0: &LinearUnlockStakedToken) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.inner.profit)
    }

    public fun linear_staked_token_get_origin_balance_value(arg0: &LinearUnlockStakedToken) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::supply<TOKEN>(&arg0.inner.balance)
    }

    public fun linear_staked_token_get_origin_profit_value(arg0: &LinearUnlockStakedToken) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::supply<TOKEN>(&arg0.inner.profit)
    }

    public fun linear_staked_token_get_start_epoch(arg0: &LinearUnlockStakedToken) : u64 {
        arg0.inner.start_epoch
    }

    public entry fun mint_test_token(arg0: &mut TestTokenSupply, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestToken>(&mut arg0.supply, 100000000, arg1, arg2);
    }

    public entry fun mint_test_token_bnb(arg0: &mut TestTokenSupply, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestBNB>(&mut arg0.supply_bnb, 100000000, arg1, arg2);
    }

    public entry fun mint_test_token_btc(arg0: &mut TestTokenSupply, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestBTC>(&mut arg0.supply_btc, 100000000, arg1, arg2);
    }

    public entry fun mint_test_token_dai(arg0: &mut TestTokenSupply, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestDAI>(&mut arg0.supply_dai, 100000000, arg1, arg2);
    }

    public entry fun mint_test_token_eth(arg0: &mut TestTokenSupply, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestETH>(&mut arg0.supply_eth, 100000000, arg1, arg2);
    }

    public entry fun mint_test_token_sol(arg0: &mut TestTokenSupply, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestSOL>(&mut arg0.supply_sol, 100000000, arg1, arg2);
    }

    public entry fun mint_test_token_usdc(arg0: &mut TestTokenSupply, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestUSDC>(&mut arg0.supply_usdc, 100000000, arg1, arg2);
    }

    public entry fun mint_test_token_usdt(arg0: &mut TestTokenSupply, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::mint_from_supply<TestUSDT>(&mut arg0.supply_usdt, 100000000, arg1, arg2);
    }

    public entry fun send_staked_token(arg0: &TokenCap, arg1: &mut TokenBank, arg2: &mut TokenFarm, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        do_send_staked_token(&arg0.token_bank_permission, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun send_token(arg0: &TokenCap, arg1: &mut TokenBank, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        do_send_token(&arg0.token_bank_permission, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_token(arg0: &mut TokenBank, arg1: &mut TokenFarm, arg2: 0x2::coin::Coin<TOKEN>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        do_stake_token(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun staked_token_add_data<T0: copy + drop + store, T1: store>(arg0: &mut StakedToken, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public fun staked_token_get_boost(arg0: &StakedToken) : u128 {
        arg0.boost
    }

    public fun staked_token_get_end_epoch(arg0: &StakedToken) : u64 {
        arg0.end_epoch
    }

    public fun staked_token_get_id(arg0: &StakedToken) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun staked_token_get_left_balance_value(arg0: &StakedToken) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.balance)
    }

    public fun staked_token_get_left_profit_value(arg0: &StakedToken) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.profit)
    }

    public fun staked_token_get_origin_balance_value(arg0: &StakedToken) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::supply<TOKEN>(&arg0.balance)
    }

    public fun staked_token_get_origin_profit_value(arg0: &StakedToken) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::supply<TOKEN>(&arg0.profit)
    }

    public fun staked_token_get_start_epoch(arg0: &StakedToken) : u64 {
        arg0.start_epoch
    }

    public(friend) fun staked_token_pop_data<T0: copy + drop + store, T1: store>(arg0: &mut StakedToken, arg1: T0) : 0x1::option::Option<T1> {
        0x2::dynamic_field::remove_if_exists<T0, T1>(&mut arg0.id, arg1)
    }

    public fun token_airdrop_get_balance_value(arg0: &TokenAirdrop) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.balance)
    }

    public fun token_airdrop_get_bank_id(arg0: &TokenAirdrop) : 0x2::object::ID {
        arg0.bank_id
    }

    public fun token_airdrop_get_free_amount(arg0: &TokenAirdrop) : u64 {
        arg0.free_amount
    }

    public fun token_airdrop_get_id(arg0: &TokenAirdrop) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun token_airdrop_get_name(arg0: &TokenAirdrop) : vector<u8> {
        arg0.name
    }

    public fun token_airdrop_get_owner(arg0: &TokenAirdrop) : address {
        arg0.owner
    }

    public fun token_airdrop_get_supply(arg0: &TokenAirdrop) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::supply<TOKEN>(&arg0.balance)
    }

    public fun token_airdrop_has_used_address(arg0: &TokenAirdrop, arg1: address) : bool {
        0x2::table::contains<address, u8>(&arg0.address_table, arg1)
    }

    public fun token_airdrop_is_free(arg0: &TokenAirdrop) : bool {
        arg0.free_amount > 0
    }

    public fun token_bank_get_balance_value(arg0: &TokenBank) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.balance)
    }

    public fun token_bank_get_id(arg0: &TokenBank) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun token_bank_get_owner(arg0: &TokenBank) : address {
        arg0.owner
    }

    public fun token_bank_get_supply(arg0: &TokenBank) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::supply<TOKEN>(&arg0.balance)
    }

    public fun token_cap_cp_token_airdrop_permission(arg0: &TokenCap) : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenAirdrop> {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::cp<TokenAirdrop>(&arg0.token_airdrop_permission)
    }

    public fun token_cap_cp_token_bank_permission(arg0: &TokenCap) : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenBank> {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::cp<TokenBank>(&arg0.token_bank_permission)
    }

    public fun token_cap_cp_token_farm_permission(arg0: &TokenCap) : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenFarm> {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::cp<TokenFarm>(&arg0.token_farm_permission)
    }

    public fun token_cap_cp_token_ido_permission(arg0: &TokenCap) : 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::Permission<TokenIdo> {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission::cp<TokenIdo>(&arg0.token_ido_permission)
    }

    public fun token_farm_get_bank_id(arg0: &TokenFarm) : 0x2::object::ID {
        arg0.bank_id
    }

    public fun token_farm_get_base_epochs(arg0: &TokenFarm) : u64 {
        arg0.base_epochs
    }

    public fun token_farm_get_id(arg0: &TokenFarm) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun token_farm_get_total_stake_amount(arg0: &TokenFarm) : u64 {
        arg0.total_stake_amount
    }

    public fun token_farm_get_total_stake_boost(arg0: &TokenFarm) : u128 {
        arg0.total_stake_boost
    }

    public fun token_farm_get_value_for_index(arg0: &TokenFarm, arg1: u64) : TokenFarmIndexValue {
        *0x2::table::borrow<u64, TokenFarmIndexValue>(&arg0.stake_index_table, arg1)
    }

    public fun token_farm_has_index_in_stake_index_table(arg0: &TokenFarm, arg1: u64) : bool {
        0x2::table::contains<u64, TokenFarmIndexValue>(&arg0.stake_index_table, arg1)
    }

    public fun token_farm_index_value_get_boost(arg0: &TokenFarmIndexValue) : u64 {
        arg0.boost_multiplier
    }

    public fun token_farm_index_value_get_profit(arg0: &TokenFarmIndexValue) : u64 {
        arg0.profit
    }

    public fun token_ido_get_balance_value(arg0: &TokenIdo) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::value<TOKEN>(&arg0.balance)
    }

    public fun token_ido_get_bank_id(arg0: &TokenIdo) : 0x2::object::ID {
        arg0.bank_id
    }

    public fun token_ido_get_collect_value(arg0: &TokenIdo) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.collect)
    }

    public fun token_ido_get_id(arg0: &TokenIdo) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun token_ido_get_is_public(arg0: &TokenIdo) : bool {
        arg0.is_public
    }

    public fun token_ido_get_is_whitelists_editable(arg0: &TokenIdo) : bool {
        arg0.is_whitelists_editable
    }

    public fun token_ido_get_name(arg0: &TokenIdo) : vector<u8> {
        arg0.name
    }

    public fun token_ido_get_price_e9(arg0: &TokenIdo) : u64 {
        arg0.price_e9
    }

    public fun token_ido_get_supply(arg0: &TokenIdo) : u64 {
        0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::supply<TOKEN>(&arg0.balance)
    }

    public fun token_ido_is_public_or_has_whitelist_address(arg0: &TokenIdo, arg1: address) : bool {
        arg0.is_public || 0x2::table::contains<address, u8>(&arg0.whitelists, arg1)
    }

    fun transfer_or_destroy_zero_stake_token(arg0: StakedToken, arg1: address) {
        if (is_zero_stake_token(&arg0)) {
            destroy_zero_stake_token(arg0);
        } else {
            0x2::transfer::transfer<StakedToken>(arg0, arg1);
        };
    }

    public entry fun unlock_linear_unlock_staked_token(arg0: LinearUnlockStakedToken, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        do_unlock_linear_unlock_staked_token(arg0, arg1, arg2);
    }

    public entry fun unlock_staked_token(arg0: &mut TokenFarm, arg1: StakedToken, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_unlock_staked_token(arg0, arg1, arg2, arg3);
    }

    fun unwrap_linear_unlock_stake_token(arg0: &mut TokenFarm, arg1: LinearUnlockStakedToken, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : StakedToken {
        let LinearUnlockStakedToken {
            id        : v0,
            origin_id : _,
            inner     : v2,
        } = arg1;
        let v3 = v2;
        0x2::object::delete(v0);
        let v4 = 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::utils::get_epoch(arg2);
        let v5 = v3.end_epoch;
        let v6 = if (v5 > v4) {
            v5 - v4
        } else {
            0
        };
        destroy_zero_stake_token(v3);
        create_stake_token(arg0, 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split_all<TOKEN>(&mut v3.balance), 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::sbalance::split_all<TOKEN>(&mut v3.profit), 0, v6, 10, arg2, arg3)
    }

    public entry fun unwrap_linear_unlock_staked_token(arg0: &mut TokenFarm, arg1: LinearUnlockStakedToken, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_unwrap_linear_unlock_staked_token(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_token_bank_admin_balance(arg0: &TokenCap, arg1: &mut TokenBank, arg2: &mut 0x2::tx_context::TxContext) {
        do_withdraw_token_bank_admin_balance(&arg0.token_bank_permission, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

