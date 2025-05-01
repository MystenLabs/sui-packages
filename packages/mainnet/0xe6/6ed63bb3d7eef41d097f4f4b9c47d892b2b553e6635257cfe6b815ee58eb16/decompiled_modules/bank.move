module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank {
    struct Asset has copy, drop, store {
        symbol: 0x1::string::String,
        type: 0x1::string::String,
        decimals: u8,
        weight: u64,
        price: u64,
        collateral: bool,
        min_deposit: u64,
        max_deposit: u64,
    }

    struct Deposit has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        from: address,
        account: address,
        amount: u64,
    }

    struct SupportedAsset has store {
        asset_details: Asset,
        synced: bool,
    }

    struct AssetBank has store, key {
        id: 0x2::object::UID,
        nonce: u128,
        supported_assets: 0x2::table::Table<0x1::string::String, SupportedAsset>,
        deposits: 0x2::table::Table<u128, Deposit>,
    }

    public fun asset_exists_in_table(arg0: &0x2::table::Table<0x1::string::String, Asset>, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Asset>(arg0, arg1)
    }

    public fun asset_values(arg0: Asset) : (0x1::string::String, 0x1::string::String, u8, u64, u64, bool) {
        (arg0.type, arg0.symbol, arg0.decimals, arg0.weight, arg0.price, arg0.collateral)
    }

    fun create_asset(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64) : Asset {
        Asset{
            symbol      : arg1,
            type        : arg0,
            decimals    : arg2,
            weight      : arg3,
            price       : arg4,
            collateral  : arg5,
            min_deposit : arg6,
            max_deposit : arg7,
        }
    }

    public(friend) fun create_asset_bank(arg0: &mut 0x2::tx_context::TxContext) : AssetBank {
        AssetBank{
            id               : 0x2::object::new(arg0),
            nonce            : 0,
            supported_assets : 0x2::table::new<0x1::string::String, SupportedAsset>(arg0),
            deposits         : 0x2::table::new<u128, Deposit>(arg0),
        }
    }

    public(friend) fun deposit_to_asset_bank<T0>(arg0: &mut AssetBank, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : (u128, u64) {
        assert!(is_asset_supported(arg0, arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::asset_not_supported());
        let v0 = get_supported_asset(arg0, arg1);
        assert!(get_asset_type<T0>() == v0.type, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::asset_type_and_symbol_mismatch());
        let v1 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::convert_to_protocol_decimals(arg3, v0.decimals);
        assert!(v1 >= v0.min_deposit && v1 <= v0.max_deposit, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        assert!(arg3 <= 0x2::coin::value<T0>(arg4), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::coin_does_not_have_enough_amount());
        let v2 = Deposit{
            id      : 0x2::object::new(arg5),
            symbol  : arg1,
            from    : 0x2::tx_context::sender(arg5),
            account : arg2,
            amount  : v1,
        };
        0x2::dynamic_field::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut v2.id, b"coin", 0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg4), arg3, arg5));
        arg0.nonce = arg0.nonce + 1;
        0x2::table::add<u128, Deposit>(&mut arg0.deposits, arg0.nonce, v2);
        (arg0.nonce, v1)
    }

    fun get_asset_type<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun get_asset_with_provided_usd_value(arg0: &0x2::table::Table<0x1::string::String, Asset>, arg1: 0x1::string::String, arg2: u64) : u64 {
        if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::is_empty_string(arg1)) {
            return arg2
        };
        assert!(asset_exists_in_table(arg0, arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::asset_not_supported());
        let (_, _, _, v3, v4, _) = asset_values(*0x2::table::borrow<0x1::string::String, Asset>(arg0, arg1));
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_div(arg2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v4, v3))
    }

    public fun get_supported_asset(arg0: &AssetBank, arg1: 0x1::string::String) : Asset {
        0x2::table::borrow<0x1::string::String, SupportedAsset>(&arg0.supported_assets, arg1).asset_details
    }

    public fun is_asset_supported(arg0: &AssetBank, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, SupportedAsset>(&arg0.supported_assets, arg1)
    }

    public fun is_asset_synced(arg0: &AssetBank, arg1: 0x1::string::String) : bool {
        0x2::table::borrow<0x1::string::String, SupportedAsset>(&arg0.supported_assets, arg1).synced
    }

    public(friend) fun merge_coin_into_balance<T0>(arg0: &mut AssetBank, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String) {
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, arg2), 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun remove_deposit<T0>(arg0: &mut AssetBank, arg1: u128) : (address, address, u64, 0x1::string::String, 0x2::coin::Coin<T0>) {
        assert!(0x2::table::contains<u128, Deposit>(&arg0.deposits, arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_nonce());
        let v0 = 0x2::table::remove<u128, Deposit>(&mut arg0.deposits, arg1);
        let Deposit {
            id      : v1,
            symbol  : v2,
            from    : v3,
            account : v4,
            amount  : v5,
        } = v0;
        0x2::object::delete(v1);
        (v3, v4, v5, v2, 0x2::dynamic_field::remove<vector<u8>, 0x2::coin::Coin<T0>>(&mut v0.id, b"coin"))
    }

    public(friend) fun set_asset_status_as_synced(arg0: &mut AssetBank, arg1: 0x1::string::String) {
        0x2::table::borrow_mut<0x1::string::String, SupportedAsset>(&mut arg0.supported_assets, arg1).synced = true;
    }

    public(friend) fun support_asset<T0>(arg0: &mut AssetBank, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64) : Asset {
        assert!(!is_asset_supported(arg0, arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::asset_already_supported());
        assert!(arg6 > 0 && arg6 < arg7, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        let v0 = create_asset(get_asset_type<T0>(), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = SupportedAsset{
            asset_details : v0,
            synced        : false,
        };
        0x2::table::add<0x1::string::String, SupportedAsset>(&mut arg0.supported_assets, arg1, v1);
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1, 0x2::balance::zero<T0>());
        v0
    }

    public(friend) fun withdraw_from_asset_bank<T0>(arg0: &mut AssetBank, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_asset_supported(arg0, arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::asset_not_supported());
        let v0 = get_supported_asset(arg0, arg1);
        assert!(get_asset_type<T0>() == v0.type, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::asset_type_and_symbol_mismatch());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1), (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::convert_to_provided_decimals((arg3 as u64), v0.decimals) as u64), arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

