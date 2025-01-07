module 0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::sellable {
    struct CredenzaSellableAssetConfig has store, key {
        id: 0x2::object::UID,
        asset_id: u64,
        price_fiat: u64,
        price_sui: u64,
        price_coin: u64,
    }

    struct CredenzaSellableConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        ownership: 0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::CredenzaOwnership,
        beneficiary_address: address,
        price_fiat: u64,
        price_sui: u64,
        price_coin: u64,
        asset_prices: 0x2::table::Table<u64, CredenzaSellableAssetConfig>,
        coin: 0x2::bag::Bag,
    }

    struct CredenzaSellableConfigCreatedEvent<phantom T0> has copy, drop {
        id: 0x2::object::ID,
    }

    public fun set_owner<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::set_owner(&mut arg0.ownership, arg1, arg2);
    }

    public fun accept_asset_payment_coin<T0, T1>(arg0: &CredenzaSellableConfig<T0>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = get_sellable_asset_price_coin<T0>(arg0, arg1, arg3);
        assert!(v1 > 0, 10001);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0), 10001);
        assert!(v1 <= 0x2::coin::value<T1>(&arg2), 10002);
        0x2::bag::borrow<0x2::object::ID, 0x2::coin::Coin<T1>>(&arg0.coin, v0);
        if (v1 < 0x2::coin::value<T1>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, 0x2::coin::value<T1>(&arg2) - v1, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, arg0.beneficiary_address);
    }

    public fun accept_payment_coin<T0, T1>(arg0: &CredenzaSellableConfig<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(arg0.price_coin > 0, 10001);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0), 10001);
        assert!(arg0.price_coin <= 0x2::coin::value<T1>(&arg1), 10002);
        0x2::bag::borrow<0x2::object::ID, 0x2::coin::Coin<T1>>(&arg0.coin, v0);
        if (arg0.price_coin < 0x2::coin::value<T1>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, 0x2::coin::value<T1>(&arg1) - arg0.price_coin, arg2), 0x2::tx_context::sender(arg2));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, arg0.beneficiary_address);
    }

    public fun create_config<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (T0, CredenzaSellableConfig<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 10004);
        let v0 = 0x2::object::new(arg1);
        let v1 = CredenzaSellableConfig<T0>{
            id                  : v0,
            ownership           : 0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::create_ownership(0x2::object::uid_to_inner(&v0), arg1),
            beneficiary_address : 0x2::tx_context::sender(arg1),
            price_fiat          : 0,
            price_sui           : 0,
            price_coin          : 0,
            asset_prices        : 0x2::table::new<u64, CredenzaSellableAssetConfig>(arg1),
            coin                : 0x2::bag::new(arg1),
        };
        0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::add_owner(&mut v1.ownership, 0x2::tx_context::sender(arg1));
        let v2 = CredenzaSellableConfigCreatedEvent<T0>{id: 0x2::object::uid_to_inner(&v1.id)};
        0x2::event::emit<CredenzaSellableConfigCreatedEvent<T0>>(v2);
        (arg0, v1)
    }

    fun get_sellable_asset_config_mut<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : &mut CredenzaSellableAssetConfig {
        if (!0x2::table::contains<u64, CredenzaSellableAssetConfig>(&arg0.asset_prices, arg1)) {
            let v0 = CredenzaSellableAssetConfig{
                id         : 0x2::object::new(arg2),
                asset_id   : arg1,
                price_fiat : 0,
                price_sui  : 0,
                price_coin : 0,
            };
            0x2::table::add<u64, CredenzaSellableAssetConfig>(&mut arg0.asset_prices, arg1, v0);
        };
        0x2::table::borrow_mut<u64, CredenzaSellableAssetConfig>(&mut arg0.asset_prices, arg1)
    }

    fun get_sellable_asset_price_coin<T0>(arg0: &CredenzaSellableConfig<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::table::contains<u64, CredenzaSellableAssetConfig>(&arg0.asset_prices, arg1)) {
            return 0
        };
        0x2::table::borrow<u64, CredenzaSellableAssetConfig>(&arg0.asset_prices, arg1).price_coin
    }

    public fun price_coin<T0>(arg0: &CredenzaSellableConfig<T0>) : u64 {
        arg0.price_coin
    }

    public fun price_fiat<T0>(arg0: &CredenzaSellableConfig<T0>) : u64 {
        arg0.price_fiat
    }

    public fun price_sui<T0>(arg0: &CredenzaSellableConfig<T0>) : u64 {
        arg0.price_sui
    }

    public fun set_asset_price_coin<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        get_sellable_asset_config_mut<T0>(arg0, arg1, arg3).price_coin = arg2;
    }

    public fun set_asset_price_fiat<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        get_sellable_asset_config_mut<T0>(arg0, arg1, arg3).price_fiat = arg2;
    }

    public fun set_asset_price_sui<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        get_sellable_asset_config_mut<T0>(arg0, arg1, arg3).price_sui = arg2;
    }

    public fun set_beneficiary_adress<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg2));
        arg0.beneficiary_address = arg1;
    }

    public fun set_price_coin<T0, T1, T2>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg2));
        arg0.price_coin = arg1;
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        if (0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0)) {
            0x2::coin::destroy_zero<T1>(0x2::bag::remove<0x2::object::ID, 0x2::coin::Coin<T1>>(&mut arg0.coin, v0));
        };
        0x2::bag::add<0x2::object::ID, 0x2::coin::Coin<T2>>(&mut arg0.coin, v0, 0x2::coin::zero<T2>(arg2));
    }

    public fun set_price_fiat<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg2));
        arg0.price_fiat = arg1;
    }

    public fun set_price_sui<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a1cf27aecd9a13817b0981e2deb25d384a36a348341d51b4d9cf271739c210f::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg2));
        arg0.price_sui = arg1;
    }

    // decompiled from Move bytecode v6
}

