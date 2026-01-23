module 0xeb543dec030cf4b34ddb8170648ad8c5d9dc5178b3b0dc2d68ce33fc6c296062::delegation_v2 {
    struct PoolRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::ascii::String, PoolInfo>,
    }

    struct PoolInfo has store {
        owner: address,
        delegate: address,
        initialized: bool,
        wallet: address,
        dev_wallet: address,
        profit_split: u8,
        assets: 0x2::table::Table<0x2::object::ID, AssetConfig>,
    }

    struct AssetConfig has copy, drop, store {
        asset_type: 0x1::ascii::String,
        amount: u64,
        processed: bool,
    }

    struct PoolCreated has copy, drop {
        pool_name: 0x1::ascii::String,
        owner: address,
    }

    struct AssetRegistered has copy, drop {
        pool_name: 0x1::ascii::String,
        asset_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        amount: u64,
    }

    struct AssetClaimed has copy, drop {
        pool_name: 0x1::ascii::String,
        asset_id: 0x2::object::ID,
        amount_transferred: u64,
    }

    public entry fun create_pool(arg0: &mut PoolRegistry, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 6);
        let v0 = PoolInfo{
            owner        : 0x2::tx_context::sender(arg6),
            delegate     : arg2,
            initialized  : false,
            wallet       : arg3,
            dev_wallet   : arg4,
            profit_split : arg5,
            assets       : 0x2::table::new<0x2::object::ID, AssetConfig>(arg6),
        };
        0x2::table::add<0x1::ascii::String, PoolInfo>(&mut arg0.pools, arg1, v0);
        let v1 = PoolCreated{
            pool_name : arg1,
            owner     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<PoolCreated>(v1);
    }

    public fun get_asset_amount(arg0: &PoolRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1), 1);
        let v0 = 0x2::table::borrow<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1);
        if (!v0.initialized) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, AssetConfig>(&v0.assets, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, AssetConfig>(&v0.assets, arg2);
        if (v1.processed) {
            return 0
        };
        v1.amount
    }

    public fun get_asset_config(arg0: &PoolRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1), 1);
        let v0 = 0x2::table::borrow<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1);
        assert!(0x2::table::contains<0x2::object::ID, AssetConfig>(&v0.assets, arg2), 2);
        let v1 = 0x2::table::borrow<0x2::object::ID, AssetConfig>(&v0.assets, arg2);
        (v1.asset_type, v1.amount, v1.processed)
    }

    public fun get_pool_info(arg0: &PoolRegistry, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1), 1);
        let v0 = 0x2::table::borrow<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1);
        (v0.owner, v0.delegate, v0.initialized, v0.wallet, v0.dev_wallet, v0.profit_split)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<0x1::ascii::String, PoolInfo>(arg0),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    public fun process_coin_claim<T0>(arg0: &mut PoolRegistry, arg1: 0x1::ascii::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, PoolInfo>(&mut arg0.pools, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v1 == v0.delegate, 0);
        let v2 = 0x2::coin::value<T0>(&arg2);
        if (v2 == 0 || !v0.initialized) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg2);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
            };
            return
        };
        let v3 = v2 * (v0.profit_split as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0.dev_wallet);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0.wallet);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v3, arg3), v0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0.dev_wallet);
        };
        let v4 = AssetClaimed{
            pool_name          : arg1,
            asset_id           : 0x2::object::id_from_address(@0x0),
            amount_transferred : v2,
        };
        0x2::event::emit<AssetClaimed>(v4);
    }

    public fun process_coin_claim_tracked<T0>(arg0: &mut PoolRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, PoolInfo>(&mut arg0.pools, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.delegate, 0);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !v0.initialized) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, AssetConfig>(&v0.assets, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, AssetConfig>(&mut v0.assets, arg2).processed = true;
        };
        let v3 = v2 * (v0.profit_split as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.dev_wallet);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.wallet);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.dev_wallet);
        };
        let v4 = AssetClaimed{
            pool_name          : arg1,
            asset_id           : arg2,
            amount_transferred : v2,
        };
        0x2::event::emit<AssetClaimed>(v4);
    }

    public fun process_nft_claim<T0: store + key>(arg0: &mut PoolRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, PoolInfo>(&mut arg0.pools, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.delegate, 0);
        if (!v0.initialized) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, AssetConfig>(&v0.assets, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, AssetConfig>(&v0.assets, arg2);
            !v3.processed && v3.amount > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, AssetConfig>(&v0.assets, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, AssetConfig>(&mut v0.assets, arg2).processed = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.dev_wallet);
        let v4 = AssetClaimed{
            pool_name          : arg1,
            asset_id           : arg2,
            amount_transferred : 1,
        };
        0x2::event::emit<AssetClaimed>(v4);
    }

    public fun process_staked_sui_claim(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut PoolRegistry, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, PoolInfo>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, PoolInfo>(&mut arg1.pools, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.delegate, 0);
        if (!v0.initialized) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, AssetConfig>(&v0.assets, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, AssetConfig>(&v0.assets, arg3);
            !v3.processed && v3.amount > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, AssetConfig>(&v0.assets, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, AssetConfig>(&mut v0.assets, arg3).processed = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.profit_split as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.dev_wallet);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.wallet);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.dev_wallet);
        };
        let v7 = AssetClaimed{
            pool_name          : arg2,
            asset_id           : arg3,
            amount_transferred : v5,
        };
        0x2::event::emit<AssetClaimed>(v7);
    }

    public entry fun register_asset(arg0: &mut PoolRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, PoolInfo>(&mut arg0.pools, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.delegate, 0);
        let v2 = AssetConfig{
            asset_type : arg3,
            amount     : arg4,
            processed  : false,
        };
        if (0x2::table::contains<0x2::object::ID, AssetConfig>(&v0.assets, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, AssetConfig>(&mut v0.assets, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, AssetConfig>(&mut v0.assets, arg2, v2);
        };
        let v3 = AssetRegistered{
            pool_name  : arg1,
            asset_id   : arg2,
            asset_type : arg3,
            amount     : arg4,
        };
        0x2::event::emit<AssetRegistered>(v3);
    }

    public entry fun set_pool_initialized(arg0: &mut PoolRegistry, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, PoolInfo>(&mut arg0.pools, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 0);
        v0.initialized = arg2;
    }

    public fun should_transfer_nft(arg0: &PoolRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_asset_amount(arg0, arg1, arg2) > 0
    }

    public entry fun update_asset_amount(arg0: &mut PoolRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, PoolInfo>(&arg0.pools, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, PoolInfo>(&mut arg0.pools, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.delegate, 0);
        assert!(0x2::table::contains<0x2::object::ID, AssetConfig>(&v0.assets, arg2), 2);
        0x2::table::borrow_mut<0x2::object::ID, AssetConfig>(&mut v0.assets, arg2).amount = arg3;
    }

    // decompiled from Move bytecode v6
}

