module 0x88e6754eec662cae7953bc988604e9d0531c0a32bcb47b8875419bc787a5bb8f::sgt {
    struct SGT has drop {
        dummy_field: bool,
    }

    struct SgtNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        desc: 0x1::string::String,
        url: 0x2::url::Url,
        level: u64,
        sex: u64,
        amount: u64,
        mint_time: u64,
    }

    struct CommissionInfo has drop, store {
        token_amount: u64,
        sui_amount: u64,
    }

    struct StakingAmount has store {
        owner: address,
        token_balance: 0x2::balance::Balance<SGT>,
        total_upgraded_amount: u64,
        last_upgrade_time: u64,
    }

    struct UpgradeConfig has store, key {
        id: 0x2::object::UID,
        token_amount: u64,
    }

    struct SgtPlatform has key {
        id: 0x2::object::UID,
        owner: address,
        is_amm_initialized: bool,
        token_balance: 0x2::balance::Balance<SGT>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        mini_token_balance: 0x2::balance::Balance<SGT>,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<SGT>>,
        nft_table: 0x2::table::Table<0x2::object::ID, SgtNFT>,
        operation_sign_owner: address,
        operation_sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        commission_table: 0x2::table::Table<address, CommissionInfo>,
        nft_info_table: 0x2::table::Table<0x2::object::ID, StakingAmount>,
        upgrade_configs: 0x2::table::Table<u64, UpgradeConfig>,
        upgrade_maximum_level: u64,
        is_maintenance: bool,
    }

    struct AMMPool has key {
        id: 0x2::object::UID,
        owner: address,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<SGT>,
    }

    struct WithdrawForPlatformSUI has copy, drop {
        sui_amount: u64,
    }

    struct WithdrawForPlatformToken has copy, drop {
        token_amount: u64,
    }

    struct DestroyForPool has copy, drop {
        sui_amount: u64,
        token_amount: u64,
    }

    struct AMMSwap has copy, drop {
        transAddress: address,
        sui_amount: u64,
        token_amount: u64,
        burn_amount: u64,
        operation_amount: u64,
        is_buy: bool,
    }

    struct TokenPayment has copy, drop {
        buyer: address,
        token_amount: u64,
    }

    struct SuiPayment has copy, drop {
        buyer: address,
        sui_amount: u64,
    }

    struct TransferAccounts has copy, drop {
        nowAddress: address,
        sendAddress: address,
        token_amount: u64,
    }

    struct BuyNft has copy, drop {
        sendAddress: address,
        nft_id: 0x2::object::ID,
        sex: u64,
        timestamp: u64,
    }

    struct NFTTransferred has copy, drop {
        sender: address,
        sendAddress: address,
        timestamp: u64,
    }

    struct NFTBatchMinted has copy, drop {
        quantity: u64,
    }

    struct SyncCommissionEvent has copy, drop {
        user: address,
        token_amount: u64,
        sui_amount: u64,
        sync_type: u8,
    }

    struct NFTUpgraded has copy, drop {
        owner: address,
        nft_id: 0x2::object::ID,
        old_level: u64,
        new_level: u64,
        cost_token: u64,
        timestamp: u64,
    }

    struct UpdateSuccess has copy, drop {
        success: bool,
    }

    struct NFTRedeemed has copy, drop {
        owner: address,
        nft_id: 0x2::object::ID,
        token_amount: u64,
        timestamp: u64,
    }

    public entry fun mint(arg0: u64, arg1: &mut SgtPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        0x2::balance::join<SGT>(&mut arg1.mini_token_balance, 0x2::coin::into_balance<SGT>(0x2::coin::mint<SGT>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<SGT>>(&mut arg1.treasury_cap), arg0, arg2)));
        0x2::balance::join<SGT>(&mut arg1.token_balance, 0x2::balance::split<SGT>(&mut arg1.mini_token_balance, 5000000000000000));
        let v0 = UpdateSuccess{success: true};
        0x2::event::emit<UpdateSuccess>(v0);
    }

    public entry fun add_upgrade_config(arg0: u64, arg1: u64, arg2: &mut SgtPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.owner, 0);
        if (0x2::table::contains<u64, UpgradeConfig>(&arg2.upgrade_configs, arg0)) {
            0x2::table::borrow_mut<u64, UpgradeConfig>(&mut arg2.upgrade_configs, arg0).token_amount = arg1;
        } else {
            let v0 = UpgradeConfig{
                id           : 0x2::object::new(arg3),
                token_amount : arg1,
            };
            0x2::table::add<u64, UpgradeConfig>(&mut arg2.upgrade_configs, arg0, v0);
        };
        let v1 = UpdateSuccess{success: true};
        0x2::event::emit<UpdateSuccess>(v1);
    }

    public entry fun batch_mint_nfts(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut SgtPlatform, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg5.owner, 0);
        assert!(arg1 > 0, 13);
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = SgtNFT{
                id        : 0x2::object::new(arg6),
                name      : 0x1::string::utf8(arg2),
                desc      : 0x1::string::utf8(arg3),
                url       : 0x2::url::new_unsafe_from_bytes(arg4),
                level     : 0,
                sex       : 0,
                amount    : arg0,
                mint_time : 0x2::tx_context::epoch(arg6),
            };
            0x2::table::add<0x2::object::ID, SgtNFT>(&mut arg5.nft_table, 0x2::object::id<SgtNFT>(&v1), v1);
            v0 = v0 + 1;
        };
        let v2 = NFTBatchMinted{quantity: arg1};
        0x2::event::emit<NFTBatchMinted>(v2);
    }

    public entry fun buy_nft(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: &mut SgtPlatform, arg3: &mut AMMPool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg2.is_maintenance, 20);
        assert!(arg3.owner == arg2.owner, 14);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(0x2::table::contains<0x2::object::ID, SgtNFT>(&arg2.nft_table, arg1), 10);
        assert!(v1 > 0, 3);
        assert!(0x2::table::length<0x2::object::ID, SgtNFT>(&arg2.nft_table) > 0, 10);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        let v3 = calculate_tax(v1, 4000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.operation_sui_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, calculate_tax(v1, 500)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.sui_balance, v2);
        let v4 = 0x2::table::remove<0x2::object::ID, SgtNFT>(&mut arg2.nft_table, arg1);
        assert!(v1 == v4.amount, 11);
        v4.sex = arg4;
        0x2::transfer::public_transfer<SgtNFT>(v4, v0);
        let v5 = calculate_tax(calculate_token_out(v3, 0x2::balance::value<0x2::sui::SUI>(&arg3.sui_reserve), 0x2::balance::value<SGT>(&arg3.token_reserve)), 9000);
        if (0x2::balance::value<SGT>(&arg2.token_balance) >= v5 && v5 > 0) {
            0x2::balance::join<SGT>(&mut arg3.token_reserve, 0x2::balance::split<SGT>(&mut arg2.token_balance, v5));
        };
        let v6 = BuyNft{
            sendAddress : v0,
            nft_id      : arg1,
            sex         : arg4,
            timestamp   : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<BuyNft>(v6);
    }

    public entry fun buy_tokens_from_amm(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut SgtPlatform, arg3: &mut AMMPool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!arg2.is_maintenance, 20);
        assert!(arg3.owner == arg2.owner, 14);
        assert!(arg2.is_amm_initialized, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 >= 100, 3);
        let v2 = calculate_token_out(v1, 0x2::balance::value<0x2::sui::SUI>(&arg3.sui_reserve), 0x2::balance::value<SGT>(&arg3.token_reserve));
        assert!(0x2::balance::value<SGT>(&arg3.token_reserve) >= v2, 5);
        let v3 = calculate_tax(v2, 200);
        let v4 = calculate_tax(v2, 300);
        assert!(v3 + v4 < v2, 9);
        let v5 = v2 - v3 - v4;
        assert!(v5 >= arg1, 7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v6 = 0x2::balance::split<SGT>(&mut arg3.token_reserve, v2);
        if (v4 > 0) {
            0x2::balance::join<SGT>(&mut arg2.token_balance, 0x2::balance::split<SGT>(&mut v6, v4));
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SGT>>(0x2::coin::from_balance<SGT>(0x2::balance::split<SGT>(&mut v6, v3), arg4), @0x0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SGT>>(0x2::coin::from_balance<SGT>(v6, arg4), v0);
        let v7 = calculate_tax(v5, 9000);
        if (0x2::balance::value<SGT>(&arg2.token_balance) >= v7 && v7 > 0) {
            0x2::balance::join<SGT>(&mut arg3.token_reserve, 0x2::balance::split<SGT>(&mut arg2.token_balance, v7));
        };
        let v8 = AMMSwap{
            transAddress     : v0,
            sui_amount       : v1,
            token_amount     : v5,
            burn_amount      : v3,
            operation_amount : v4,
            is_buy           : true,
        };
        0x2::event::emit<AMMSwap>(v8);
    }

    public entry fun buyback_and_burn(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut SgtPlatform, arg3: &mut AMMPool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.owner == arg2.owner, 14);
        assert!(arg1 > 0, 4);
        assert!(arg2.is_amm_initialized, 1);
        assert!(0x2::balance::value<SGT>(&arg3.token_reserve) >= arg1, 5);
        let v0 = calculate_sui_out(arg1, 0x2::balance::value<SGT>(&arg3.token_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg3.sui_reserve));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<SGT>>(0x2::coin::from_balance<SGT>(0x2::balance::split<SGT>(&mut arg3.token_reserve, arg1), arg4), @0x0);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1) - v0;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v2), arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.sui_reserve, v1);
        let v3 = DestroyForPool{
            sui_amount   : v0,
            token_amount : arg1,
        };
        0x2::event::emit<DestroyForPool>(v3);
    }

    public fun calculate_sui_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 9);
        let v0 = (arg2 as u128) * (arg0 as u128) / ((arg1 as u128) + (arg0 as u128));
        assert!(v0 <= (arg2 as u128), 15);
        (v0 as u64)
    }

    public fun calculate_swap_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 9);
        let v0 = (arg0 as u128);
        (((arg2 as u128) * v0 / ((arg1 as u128) + v0)) as u64)
    }

    public fun calculate_tax(arg0: u64, arg1: u64) : u64 {
        let v0 = (10000 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 / 2) / v0) as u64)
    }

    public fun calculate_token_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 9);
        let v0 = (arg2 as u128) * (arg0 as u128) / ((arg1 as u128) + (arg0 as u128));
        assert!(v0 <= (arg2 as u128), 15);
        (v0 as u64)
    }

    public entry fun deposit_SUI_tokens(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut SgtPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v0 = UpdateSuccess{success: true};
        0x2::event::emit<UpdateSuccess>(v0);
    }

    public entry fun deposit_tokens(arg0: 0x2::coin::Coin<SGT>, arg1: &mut SgtPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        0x2::balance::join<SGT>(&mut arg1.token_balance, 0x2::coin::into_balance<SGT>(arg0));
        let v0 = UpdateSuccess{success: true};
        0x2::event::emit<UpdateSuccess>(v0);
    }

    public entry fun destroy_treasury_cap(arg0: &mut SgtPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGT>>(0x1::option::extract<0x2::coin::TreasuryCap<SGT>>(&mut arg0.treasury_cap), @0x0);
    }

    public entry fun extract_operation_platform(arg0: u64, arg1: address, arg2: &mut SgtPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.owner, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.operation_sui_balance) >= arg0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.operation_sui_balance, arg0), arg3), arg1);
        let v0 = WithdrawForPlatformSUI{sui_amount: arg0};
        0x2::event::emit<WithdrawForPlatformSUI>(v0);
    }

    fun init(arg0: SGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGT>(arg0, 9, b"SGT", b"Sui Grow NFT", b"Sui Grow NFT is an innovative dynamic growth-oriented NFT series launched on the high-performance public blockchain Sui Network. Centered around the core concept of 'Growth and Evolution,' the series integrates digital collectibles with sustainable ecological value, endowing each NFT with a unique attribute of 'vitality' that evolves over time, through interactions, and with community participation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.suigrow.top/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGT>>(v1);
        let v2 = SgtPlatform{
            id                    : 0x2::object::new(arg1),
            owner                 : 0x2::tx_context::sender(arg1),
            is_amm_initialized    : false,
            token_balance         : 0x2::balance::zero<SGT>(),
            sui_balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            mini_token_balance    : 0x2::balance::zero<SGT>(),
            treasury_cap          : 0x1::option::some<0x2::coin::TreasuryCap<SGT>>(v0),
            nft_table             : 0x2::table::new<0x2::object::ID, SgtNFT>(arg1),
            operation_sign_owner  : 0x2::tx_context::sender(arg1),
            operation_sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            commission_table      : 0x2::table::new<address, CommissionInfo>(arg1),
            nft_info_table        : 0x2::table::new<0x2::object::ID, StakingAmount>(arg1),
            upgrade_configs       : 0x2::table::new<u64, UpgradeConfig>(arg1),
            upgrade_maximum_level : 0,
            is_maintenance        : false,
        };
        0x2::transfer::share_object<SgtPlatform>(v2);
    }

    public entry fun init_upgrade_config(arg0: vector<u64>, arg1: vector<u64>, arg2: &mut SgtPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.owner, 0);
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 16);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = UpgradeConfig{
                id           : 0x2::object::new(arg3),
                token_amount : *0x1::vector::borrow<u64>(&arg1, v1),
            };
            0x2::table::add<u64, UpgradeConfig>(&mut arg2.upgrade_configs, *0x1::vector::borrow<u64>(&arg0, v1), v2);
            v1 = v1 + 1;
        };
        let v3 = UpdateSuccess{success: true};
        0x2::event::emit<UpdateSuccess>(v3);
    }

    public entry fun initialize_amm_pool(arg0: &mut SgtPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 0);
        assert!(!arg0.is_amm_initialized, 1);
        assert!(0x2::balance::value<SGT>(&arg0.token_balance) >= 520000000000, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= 38000000000, 3);
        let v1 = AMMPool{
            id            : 0x2::object::new(arg1),
            owner         : v0,
            sui_reserve   : 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 38000000000),
            token_reserve : 0x2::balance::split<SGT>(&mut arg0.token_balance, 520000000000),
        };
        arg0.is_amm_initialized = true;
        0x2::transfer::share_object<AMMPool>(v1);
    }

    public entry fun nft_transfer(arg0: SgtNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SgtNFT>(arg0, arg1);
        let v0 = NFTTransferred{
            sender      : 0x2::tx_context::sender(arg2),
            sendAddress : arg1,
            timestamp   : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<NFTTransferred>(v0);
    }

    public entry fun redemption_nft(arg0: SgtNFT, arg1: &mut SgtPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!arg1.is_maintenance, 20);
        let v1 = 0x2::object::id<SgtNFT>(&arg0);
        assert!(0x2::table::contains<0x2::object::ID, StakingAmount>(&arg1.nft_info_table, v1), 10);
        let StakingAmount {
            owner                 : v2,
            token_balance         : v3,
            total_upgraded_amount : _,
            last_upgrade_time     : _,
        } = 0x2::table::remove<0x2::object::ID, StakingAmount>(&mut arg1.nft_info_table, v1);
        let v6 = v3;
        assert!(v2 == v0, 22);
        let v7 = 0x2::balance::value<SGT>(&v6);
        assert!(v7 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<SGT>>(0x2::coin::from_balance<SGT>(v6, arg2), v0);
        let SgtNFT {
            id        : v8,
            name      : _,
            desc      : _,
            url       : _,
            level     : _,
            sex       : _,
            amount    : _,
            mint_time : _,
        } = arg0;
        0x2::object::delete(v8);
        let v16 = NFTRedeemed{
            owner        : v0,
            nft_id       : v1,
            token_amount : v7,
            timestamp    : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<NFTRedeemed>(v16);
    }

    public entry fun sell_tokens_to_amm(arg0: 0x2::coin::Coin<SGT>, arg1: u64, arg2: &mut SgtPlatform, arg3: &mut AMMPool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_maintenance, 20);
        assert!(arg3.owner == arg2.owner, 14);
        assert!(arg2.is_amm_initialized, 1);
        let v0 = 0x2::coin::value<SGT>(&arg0);
        assert!(v0 > 0, 4);
        let v1 = calculate_tax(v0, 200);
        let v2 = calculate_tax(v0, 300);
        assert!(v1 + v2 < v0, 9);
        let v3 = calculate_sui_out(v0 - v1 - v2, 0x2::balance::value<SGT>(&arg3.token_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg3.sui_reserve));
        assert!(v3 >= arg1, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3.sui_reserve) >= v3, 6);
        let v4 = 0x2::coin::into_balance<SGT>(arg0);
        if (v2 > 0) {
            0x2::balance::join<SGT>(&mut arg2.token_balance, 0x2::balance::split<SGT>(&mut v4, v2));
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SGT>>(0x2::coin::from_balance<SGT>(0x2::balance::split<SGT>(&mut v4, v1), arg4), @0x0);
        };
        0x2::balance::join<SGT>(&mut arg3.token_reserve, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3.sui_reserve, v3), arg4), 0x2::tx_context::sender(arg4));
        let v5 = calculate_tax(v3, 9000);
        if (0x2::balance::value<0x2::sui::SUI>(&arg2.sui_balance) >= v5 && v5 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg3.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut arg2.sui_balance, v5));
        };
        let v6 = AMMSwap{
            transAddress     : 0x2::tx_context::sender(arg4),
            sui_amount       : v3,
            token_amount     : v0,
            burn_amount      : v1,
            operation_amount : v2,
            is_buy           : false,
        };
        0x2::event::emit<AMMSwap>(v6);
    }

    public entry fun sui_mutual_conversion(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        let v1 = TransferAccounts{
            nowAddress   : 0x2::tx_context::sender(arg2),
            sendAddress  : arg1,
            token_amount : v0,
        };
        0x2::event::emit<TransferAccounts>(v1);
    }

    public entry fun sui_payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut SgtPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_maintenance, 20);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.operation_sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v1 = SuiPayment{
            buyer      : 0x2::tx_context::sender(arg2),
            sui_amount : v0,
        };
        0x2::event::emit<SuiPayment>(v1);
    }

    public entry fun sync_sui(arg0: u64, arg1: address, arg2: &mut SgtPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_maintenance, 20);
        assert!(0x2::tx_context::sender(arg3) == arg2.operation_sign_owner, 8);
        if (!0x2::table::contains<address, CommissionInfo>(&arg2.commission_table, arg1)) {
            let v0 = CommissionInfo{
                token_amount : 0,
                sui_amount   : arg0,
            };
            0x2::table::add<address, CommissionInfo>(&mut arg2.commission_table, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, CommissionInfo>(&mut arg2.commission_table, arg1);
            v1.sui_amount = v1.sui_amount + arg0;
        };
        let v2 = SyncCommissionEvent{
            user         : arg1,
            token_amount : 0,
            sui_amount   : arg0,
            sync_type    : 1,
        };
        0x2::event::emit<SyncCommissionEvent>(v2);
    }

    public entry fun sync_token(arg0: u64, arg1: address, arg2: &mut SgtPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_maintenance, 20);
        assert!(0x2::tx_context::sender(arg3) == arg2.operation_sign_owner, 8);
        if (!0x2::table::contains<address, CommissionInfo>(&arg2.commission_table, arg1)) {
            let v0 = CommissionInfo{
                token_amount : arg0,
                sui_amount   : 0,
            };
            0x2::table::add<address, CommissionInfo>(&mut arg2.commission_table, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, CommissionInfo>(&mut arg2.commission_table, arg1);
            v1.token_amount = v1.token_amount + arg0;
        };
        let v2 = SyncCommissionEvent{
            user         : arg1,
            token_amount : arg0,
            sui_amount   : 0,
            sync_type    : 0,
        };
        0x2::event::emit<SyncCommissionEvent>(v2);
    }

    public entry fun token_mutual_conversion(arg0: 0x2::coin::Coin<SGT>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<SGT>(&arg0);
        assert!(v0 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<SGT>>(arg0, arg1);
        let v1 = TransferAccounts{
            nowAddress   : 0x2::tx_context::sender(arg2),
            sendAddress  : arg1,
            token_amount : v0,
        };
        0x2::event::emit<TransferAccounts>(v1);
    }

    public entry fun token_payment(arg0: 0x2::coin::Coin<SGT>, arg1: &mut SgtPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_maintenance, 20);
        let v0 = 0x2::coin::value<SGT>(&arg0);
        assert!(v0 > 0, 4);
        0x2::balance::join<SGT>(&mut arg1.token_balance, 0x2::coin::into_balance<SGT>(arg0));
        let v1 = TokenPayment{
            buyer        : 0x2::tx_context::sender(arg2),
            token_amount : v0,
        };
        0x2::event::emit<TokenPayment>(v1);
    }

    public entry fun update_maintenance_status(arg0: bool, arg1: &mut SgtPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        arg1.is_maintenance = arg0;
        let v0 = UpdateSuccess{success: true};
        0x2::event::emit<UpdateSuccess>(v0);
    }

    public entry fun update_operation_sign_owner(arg0: address, arg1: &mut SgtPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        assert!(arg0 != @0x0, 21);
        arg1.operation_sign_owner = arg0;
        let v0 = UpdateSuccess{success: true};
        0x2::event::emit<UpdateSuccess>(v0);
    }

    public entry fun update_staking_owner(arg0: &SgtNFT, arg1: address, arg2: &mut SgtPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<SgtNFT>(arg0);
        assert!(0x2::table::contains<0x2::object::ID, StakingAmount>(&arg2.nft_info_table, v0), 10);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, StakingAmount>(&mut arg2.nft_info_table, v0);
        assert!(v1.owner == 0x2::tx_context::sender(arg3), 22);
        v1.owner = arg1;
        let v2 = UpdateSuccess{success: true};
        0x2::event::emit<UpdateSuccess>(v2);
    }

    public entry fun update_upgrade_maximum(arg0: u64, arg1: &mut SgtPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        arg1.upgrade_maximum_level = arg0;
        let v0 = UpdateSuccess{success: true};
        0x2::event::emit<UpdateSuccess>(v0);
    }

    public entry fun upgrade_nft(arg0: SgtNFT, arg1: u64, arg2: 0x2::coin::Coin<SGT>, arg3: &mut SgtPlatform, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<SGT>(&arg2);
        assert!(!arg3.is_maintenance, 20);
        assert!(arg1 <= arg3.upgrade_maximum_level, 19);
        assert!(v1 > 0, 4);
        let v2 = arg0.level;
        assert!(arg1 > v2, 17);
        assert!(0x2::table::contains<u64, UpgradeConfig>(&arg3.upgrade_configs, arg1), 18);
        let v3 = 0;
        let v4 = v2 + 1;
        while (v4 <= arg1) {
            assert!(0x2::table::contains<u64, UpgradeConfig>(&arg3.upgrade_configs, v4), 18);
            v3 = v3 + 0x2::table::borrow<u64, UpgradeConfig>(&arg3.upgrade_configs, v4).token_amount;
            v4 = v4 + 1;
        };
        assert!(v1 >= v3, 4);
        let v5 = 0x2::object::id<SgtNFT>(&arg0);
        if (!0x2::table::contains<0x2::object::ID, StakingAmount>(&arg3.nft_info_table, v5)) {
            let v6 = StakingAmount{
                owner                 : v0,
                token_balance         : 0x2::coin::into_balance<SGT>(arg2),
                total_upgraded_amount : v3,
                last_upgrade_time     : 0x2::tx_context::epoch(arg4),
            };
            0x2::table::add<0x2::object::ID, StakingAmount>(&mut arg3.nft_info_table, v5, v6);
        } else {
            let v7 = 0x2::table::borrow_mut<0x2::object::ID, StakingAmount>(&mut arg3.nft_info_table, v5);
            assert!(v7.owner == v0, 22);
            0x2::balance::join<SGT>(&mut v7.token_balance, 0x2::coin::into_balance<SGT>(arg2));
            v7.total_upgraded_amount = v7.total_upgraded_amount + v3;
            v7.last_upgrade_time = 0x2::tx_context::epoch(arg4);
        };
        arg0.level = arg1;
        0x2::transfer::public_transfer<SgtNFT>(arg0, v0);
        let v8 = NFTUpgraded{
            owner      : v0,
            nft_id     : v5,
            old_level  : v2,
            new_level  : arg1,
            cost_token : v3,
            timestamp  : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<NFTUpgraded>(v8);
    }

    public entry fun withdraw_sui_Airdrop(arg0: &mut SgtPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!arg0.is_maintenance, 20);
        assert!(0x2::table::contains<address, CommissionInfo>(&arg0.commission_table, v0), 12);
        let v1 = 0x2::table::remove<address, CommissionInfo>(&mut arg0.commission_table, v0);
        let v2 = v1.sui_amount;
        assert!(v2 > 0, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= v2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v2), arg1), v0);
        let v3 = WithdrawForPlatformSUI{sui_amount: v2};
        0x2::event::emit<WithdrawForPlatformSUI>(v3);
    }

    public entry fun withdrawal_token(arg0: &mut SgtPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!arg0.is_maintenance, 20);
        assert!(0x2::table::contains<address, CommissionInfo>(&arg0.commission_table, v0), 12);
        let v1 = 0x2::table::remove<address, CommissionInfo>(&mut arg0.commission_table, v0);
        let v2 = v1.token_amount;
        assert!(v2 > 0, 4);
        assert!(0x2::balance::value<SGT>(&arg0.mini_token_balance) >= v2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<SGT>>(0x2::coin::from_balance<SGT>(0x2::balance::split<SGT>(&mut arg0.mini_token_balance, v2), arg1), v0);
        let v3 = WithdrawForPlatformToken{token_amount: v2};
        0x2::event::emit<WithdrawForPlatformToken>(v3);
    }

    // decompiled from Move bytecode v6
}

