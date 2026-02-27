module 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault {
    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        shares: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        shares: u64,
        amount: u64,
        fee: u64,
        timestamp: u64,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_shares: u64,
        total_assets: u64,
        n_token: 0x2::balance::Balance<T0>,
        wusdc_type: 0x1::type_name::TypeName,
    }

    struct UserPosition has store, key {
        id: 0x2::object::UID,
        user: address,
        shares: u64,
        deposit_timestamp: u64,
    }

    public fun add_shares(arg0: &mut UserPosition, arg1: u64) {
        arg0.shares = arg0.shares + arg1;
    }

    public fun burn_shares<T0>(arg0: &mut Vault<T0>, arg1: &mut UserPosition, arg2: u64) : u64 {
        assert!(arg1.shares >= arg2, 1);
        let v0 = 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::math::calculate_assets(arg2, arg0.total_assets, arg0.total_shares);
        arg0.total_assets = arg0.total_assets - v0;
        arg0.total_shares = arg0.total_shares - arg2;
        arg1.shares = arg1.shares - arg2;
        v0
    }

    public fun calculate_user_assets<T0>(arg0: &Vault<T0>, arg1: &UserPosition) : u64 {
        0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::math::calculate_assets(arg1.shares, arg0.total_assets, arg0.total_shares)
    }

    public fun create_vault<T0>(arg0: 0x1::type_name::TypeName, arg1: &mut 0x2::tx_context::TxContext) : (Vault<T0>, UserPosition) {
        let v0 = Vault<T0>{
            id           : 0x2::object::new(arg1),
            total_shares : 0,
            total_assets : 0,
            n_token      : 0x2::balance::zero<T0>(),
            wusdc_type   : arg0,
        };
        let v1 = UserPosition{
            id                : 0x2::object::new(arg1),
            user              : 0x2::tx_context::sender(arg1),
            shares            : 0,
            deposit_timestamp : 0,
        };
        (v0, v1)
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &mut UserPosition, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 3);
        assert!(0x1::type_name::get<T0>() == arg0.wusdc_type, 0);
        let v1 = 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::math::calculate_shares(v0, arg0.total_assets, arg0.total_shares);
        arg0.total_assets = arg0.total_assets + v0;
        arg0.total_shares = arg0.total_shares + v1;
        0x2::balance::join<T0>(&mut arg0.n_token, 0x2::coin::into_balance<T0>(arg2));
        arg1.shares = arg1.shares + v1;
        if (arg1.deposit_timestamp == 0) {
            arg1.deposit_timestamp = 0x2::tx_context::epoch_timestamp_ms(arg3);
        };
    }

    public fun get_shares(arg0: &UserPosition) : u64 {
        arg0.shares
    }

    public fun get_total_assets<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_assets
    }

    public fun get_total_shares<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_shares
    }

    public fun get_user_shares(arg0: &UserPosition) : u64 {
        arg0.shares
    }

    public fun get_wusdc_type<T0>(arg0: &Vault<T0>) : 0x1::type_name::TypeName {
        arg0.wusdc_type
    }

    public fun mint_shares<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::math::calculate_shares(arg1, arg0.total_assets, arg0.total_shares);
        arg0.total_assets = arg0.total_assets + arg1;
        arg0.total_shares = arg0.total_shares + v0;
        v0
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &mut UserPosition, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.shares >= arg2, 1);
        let v0 = 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::math::calculate_assets(arg2, arg0.total_assets, arg0.total_shares);
        let v1 = 0;
        let v2 = v0 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.n_token, v2), arg3), 0x2::tx_context::sender(arg3));
        arg0.total_assets = arg0.total_assets - v0;
        arg0.total_shares = arg0.total_shares - arg2;
        arg1.shares = arg1.shares - arg2;
        let v3 = WithdrawEvent{
            user      : 0x2::tx_context::sender(arg3),
            shares    : arg2,
            amount    : v2,
            fee       : v1,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

