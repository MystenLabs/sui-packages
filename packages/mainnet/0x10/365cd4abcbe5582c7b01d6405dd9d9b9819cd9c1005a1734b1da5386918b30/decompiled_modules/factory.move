module 0x10365cd4abcbe5582c7b01d6405dd9d9b9819cd9c1005a1734b1da5386918b30::factory {
    struct FactoryRegistry has store, key {
        id: 0x2::object::UID,
        factory_blob_id: 0x2::object::ID,
        total_launched: u64,
    }

    struct Bin has copy, drop, store {
        price: u64,
        token_reserves: u64,
        sui_reserves: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        token_vault: 0x2::balance::Balance<T0>,
        sui_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        bins: vector<Bin>,
        active_bin_index: u64,
        total_supply: u64,
        volume: u128,
        trade_count: u64,
        active: bool,
        created_epoch: u64,
    }

    struct FactoryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        factory_blob_id: 0x2::object::ID,
    }

    struct TokenLaunched has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        total_supply: u64,
        num_bins: u64,
        start_price: u64,
        end_price: u64,
        treasury_cap_frozen: bool,
        metadata_frozen: bool,
    }

    struct Swap has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        price: u64,
    }

    public fun buy<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.active, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0x1::vector::length<Bin>(&arg0.bins);
        let v5 = arg0.active_bin_index;
        while (v2 > 0 && v5 < v4) {
            let v6 = 0x1::vector::borrow_mut<Bin>(&mut arg0.bins, v5);
            if (v6.token_reserves == 0) {
                v5 = v5 + 1;
                continue
            };
            let v7 = (((v2 as u128) * (1000000000 as u128) / (v6.price as u128)) as u64);
            if (v7 >= v6.token_reserves) {
                let v8 = (((v6.token_reserves as u128) * (v6.price as u128) / (1000000000 as u128)) as u64);
                let v9 = if (v8 > v2) {
                    v2
                } else {
                    v8
                };
                v3 = v3 + v6.token_reserves;
                v6.sui_reserves = v6.sui_reserves + v9;
                v6.token_reserves = 0;
                v2 = v2 - v9;
                v5 = v5 + 1;
                continue
            };
            let v10 = (((v7 as u128) * (v6.price as u128) / (1000000000 as u128)) as u64);
            v3 = v3 + v7;
            v6.token_reserves = v6.token_reserves - v7;
            v6.sui_reserves = v6.sui_reserves + v10;
            v2 = v2 - v10;
        };
        assert!(v3 > 0, 1);
        assert!(v3 >= arg2, 3);
        let v11 = if (v5 < v4) {
            v5
        } else {
            v4 - 1
        };
        arg0.active_bin_index = v11;
        let v12 = v0 - v2;
        arg0.volume = arg0.volume + (v12 as u128);
        arg0.trade_count = arg0.trade_count + 1;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v2), arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_vault, v1);
        let v13 = Swap{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            trader       : 0x2::tx_context::sender(arg3),
            is_buy       : true,
            sui_amount   : v12,
            token_amount : v3,
            price        : get_active_price<T0>(arg0),
        };
        0x2::event::emit<Swap>(v13);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_vault, v3), arg3)
    }

    public fun extend_blob(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::SharedBlob, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::extend(arg0, arg1, arg2, arg3);
    }

    public fun fund_blob(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::SharedBlob, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::fund(arg0, arg1);
    }

    public fun get_active_price<T0>(arg0: &Pool<T0>) : u64 {
        if (arg0.active_bin_index < 0x1::vector::length<Bin>(&arg0.bins)) {
            0x1::vector::borrow<Bin>(&arg0.bins, arg0.active_bin_index).price
        } else {
            0
        }
    }

    public fun get_bin<T0>(arg0: &Pool<T0>, arg1: u64) : (u64, u64, u64) {
        let v0 = 0x1::vector::borrow<Bin>(&arg0.bins, arg1);
        (v0.price, v0.token_reserves, v0.sui_reserves)
    }

    public fun get_creator<T0>(arg0: &Pool<T0>) : address {
        arg0.creator
    }

    public fun get_factory_blob_id(arg0: &FactoryRegistry) : 0x2::object::ID {
        arg0.factory_blob_id
    }

    public fun get_num_bins<T0>(arg0: &Pool<T0>) : u64 {
        0x1::vector::length<Bin>(&arg0.bins)
    }

    public fun get_total_launched(arg0: &FactoryRegistry) : u64 {
        arg0.total_launched
    }

    public fun get_total_supply<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_supply
    }

    public fun get_trade_count<T0>(arg0: &Pool<T0>) : u64 {
        arg0.trade_count
    }

    public fun get_volume<T0>(arg0: &Pool<T0>) : u128 {
        arg0.volume
    }

    public fun is_active<T0>(arg0: &Pool<T0>) : bool {
        arg0.active
    }

    public fun launch<T0>(arg0: &mut FactoryRegistry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg2);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::new(arg3, arg4);
        let v0 = 1000000000000000000 / 100;
        let v1 = 0x1::vector::empty<Bin>();
        let v2 = 1000;
        let v3 = 0;
        while (v3 < 100) {
            let v4 = if (v3 == 0) {
                v0 + 1000000000000000000 - v0 * 100
            } else {
                v0
            };
            let v5 = Bin{
                price          : v2,
                token_reserves : v4,
                sui_reserves   : 0,
            };
            0x1::vector::push_back<Bin>(&mut v1, v5);
            let v6 = (((v2 as u128) * (1145 as u128) / (1000 as u128)) as u64);
            let v7 = if (v6 <= v2) {
                v2 + 1
            } else {
                v6
            };
            v2 = v7;
            v3 = v3 + 1;
        };
        let v8 = Pool<T0>{
            id               : 0x2::object::new(arg4),
            creator          : 0x2::tx_context::sender(arg4),
            token_vault      : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg1, 1000000000000000000, arg4)),
            sui_vault        : 0x2::balance::zero<0x2::sui::SUI>(),
            bins             : v1,
            active_bin_index : 0,
            total_supply     : 1000000000000000000,
            volume           : 0,
            trade_count      : 0,
            active           : true,
            created_epoch    : 0x2::tx_context::epoch(arg4),
        };
        arg0.total_launched = arg0.total_launched + 1;
        let v9 = TokenLaunched{
            pool_id             : 0x2::object::id<Pool<T0>>(&v8),
            creator             : 0x2::tx_context::sender(arg4),
            total_supply        : 1000000000000000000,
            num_bins            : 100,
            start_price         : 1000,
            end_price           : 1000,
            treasury_cap_frozen : true,
            metadata_frozen     : true,
        };
        0x2::event::emit<TokenLaunched>(v9);
        0x2::transfer::public_share_object<Pool<T0>>(v8);
    }

    public fun sell<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.active, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = v0;
        let v2 = 0;
        let v3 = arg0.active_bin_index;
        let v4 = false;
        while (v1 > 0 && !v4) {
            let v5 = 0x1::vector::borrow_mut<Bin>(&mut arg0.bins, v3);
            if (v5.sui_reserves == 0) {
                if (v3 == 0) {
                    v4 = true;
                    continue
                };
                v3 = v3 - 1;
                continue
            };
            let v6 = (((v5.sui_reserves as u128) * (1000000000 as u128) / (v5.price as u128)) as u64);
            if (v1 >= v6) {
                v2 = v2 + v5.sui_reserves;
                v5.token_reserves = v5.token_reserves + v6;
                v5.sui_reserves = 0;
                v1 = v1 - v6;
                if (v3 == 0) {
                    v4 = true;
                    continue
                };
                v3 = v3 - 1;
                continue
            };
            let v7 = (((v1 as u128) * (v5.price as u128) / (1000000000 as u128)) as u64);
            if (v7 > v5.sui_reserves) {
                let v8 = v5.sui_reserves;
                let v9 = (((v8 as u128) * (1000000000 as u128) / (v5.price as u128)) as u64);
                v2 = v2 + v8;
                v5.token_reserves = v5.token_reserves + v9;
                v5.sui_reserves = 0;
                v1 = v1 - v9;
                continue
            };
            v2 = v2 + v7;
            v5.token_reserves = v5.token_reserves + v1;
            v5.sui_reserves = v5.sui_reserves - v7;
            v1 = 0;
        };
        assert!(v2 > 0, 1);
        assert!(v2 >= arg2, 3);
        arg0.active_bin_index = v3;
        let v10 = 0x2::coin::into_balance<T0>(arg1);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v10, v1), arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::balance::join<T0>(&mut arg0.token_vault, v10);
        arg0.volume = arg0.volume + (v2 as u128);
        arg0.trade_count = arg0.trade_count + 1;
        let v11 = Swap{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            trader       : 0x2::tx_context::sender(arg3),
            is_buy       : false,
            sui_amount   : v2,
            token_amount : v0 - v1,
            price        : get_active_price<T0>(arg0),
        };
        0x2::event::emit<Swap>(v11);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v2), arg3)
    }

    public fun setup_factory(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::new(arg0, arg1);
        let v1 = FactoryRegistry{
            id              : 0x2::object::new(arg1),
            factory_blob_id : v0,
            total_launched  : 0,
        };
        let v2 = FactoryCreated{
            registry_id     : 0x2::object::id<FactoryRegistry>(&v1),
            factory_blob_id : v0,
        };
        0x2::event::emit<FactoryCreated>(v2);
        0x2::transfer::public_share_object<FactoryRegistry>(v1);
    }

    // decompiled from Move bytecode v6
}

