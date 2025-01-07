module 0xb93e7fc6682a006863f82132b0ca32b80861887dd7a06c662dabc005ec15086b::Staking_Fit {
    struct DepositInfo has store, key {
        id: 0x2::object::UID,
        current_deposit_asset_id: u256,
        fund_address: address,
        version: u64,
    }

    struct AssetDepositInfo has copy, drop, store {
        deposit_id: u256,
        is_withdraw: bool,
        owner: address,
        coin_type: 0x1::string::String,
        amount: u64,
        start_time: u64,
    }

    struct DepositEvent has copy, drop {
        deposit_id: u256,
        owner: address,
        coin_type: 0x1::string::String,
        amount: u64,
        start_time: u64,
    }

    struct WithdrawEvent has copy, drop {
        deposit_id: u256,
        owner: address,
        coin_type: 0x1::string::String,
        start_time: u64,
    }

    public entry fun deposit_asset<T0>(arg0: &0x2::clock::Clock, arg1: &mut DepositInfo, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_token_name<T0>();
        assert!(1 == arg1.version, 0);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 == arg3, 1);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = arg1.current_deposit_asset_id + 1;
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = AssetDepositInfo{
            deposit_id  : v3,
            is_withdraw : false,
            owner       : v2,
            coin_type   : v0,
            amount      : v1,
            start_time  : v4,
        };
        0x2::dynamic_field::add<u256, AssetDepositInfo>(&mut arg1.id, v3, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1.fund_address);
        let v6 = DepositEvent{
            deposit_id : v3,
            owner      : v2,
            coin_type  : v0,
            amount     : v1,
            start_time : v4,
        };
        0x2::event::emit<DepositEvent>(v6);
    }

    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositInfo{
            id                       : 0x2::object::new(arg0),
            current_deposit_asset_id : 0,
            fund_address             : @0x47558e307257aaa27510eda258e582e22b596fc0d1db08ed5923b3e807616a32,
            version                  : 1,
        };
        0x2::transfer::public_share_object<DepositInfo>(v0);
    }

    public entry fun migrate_version(arg0: &mut DepositInfo, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.fund_address, 2);
        arg0.version = 1;
    }

    public entry fun set_fund_address(arg0: &mut DepositInfo, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 0);
        assert!(0x2::tx_context::sender(arg2) == arg0.fund_address, 2);
        arg0.fund_address = arg1;
    }

    public entry fun withdraw_asset<T0>(arg0: &0x2::clock::Clock, arg1: &mut DepositInfo, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg1.version, 0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::dynamic_field::borrow_mut<u256, AssetDepositInfo>(&mut arg1.id, arg2);
        assert!(v0 == v1.owner, 2);
        v1.is_withdraw = true;
        let v2 = WithdrawEvent{
            deposit_id : arg2,
            owner      : v0,
            coin_type  : get_token_name<T0>(),
            start_time : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

