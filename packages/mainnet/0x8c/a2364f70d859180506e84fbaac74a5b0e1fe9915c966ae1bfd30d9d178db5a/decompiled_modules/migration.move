module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration {
    struct MigrationVault<phantom T0> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens: 0x2::balance::Balance<T0>,
        decimals: u8,
        sui_at_graduation: u64,
        tokens_at_graduation: u64,
        redeemed: bool,
        confirmed: bool,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        lp_burn_proof: 0x1::option::Option<0x2::object::ID>,
    }

    public fun coin_type<T0>(arg0: &MigrationVault<T0>) : 0x1::ascii::String {
        arg0.coin_type
    }

    public fun confirm<T0>(arg0: &mut MigrationVault<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::MigrationCap, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &0x2::clock::Clock) {
        assert!(arg0.redeemed, 1);
        assert!(!arg0.confirmed, 2);
        arg0.confirmed = true;
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg0.lp_burn_proof = arg3;
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::migrated(arg0.curve_id, arg0.coin_type, 0x2::object::uid_to_inner(&arg0.id), arg2, arg3, arg0.sui_at_graduation, arg0.tokens_at_graduation, 0x2::clock::timestamp_ms(arg4));
    }

    public(friend) fun create_and_share<T0>(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x2::balance::Balance<T0>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = MigrationVault<T0>{
            id                   : 0x2::object::new(arg6),
            curve_id             : arg0,
            coin_type            : arg1,
            creator              : arg2,
            sui                  : arg3,
            tokens               : arg4,
            decimals             : arg5,
            sui_at_graduation    : 0x2::balance::value<0x2::sui::SUI>(&arg3),
            tokens_at_graduation : 0x2::balance::value<T0>(&arg4),
            redeemed             : false,
            confirmed            : false,
            pool_id              : 0x1::option::none<0x2::object::ID>(),
            lp_burn_proof        : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<MigrationVault<T0>>(v0);
        0x2::object::uid_to_inner(&v0.id)
    }

    public fun creator<T0>(arg0: &MigrationVault<T0>) : address {
        arg0.creator
    }

    public fun curve_id<T0>(arg0: &MigrationVault<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun decimals<T0>(arg0: &MigrationVault<T0>) : u8 {
        arg0.decimals
    }

    public fun is_confirmed<T0>(arg0: &MigrationVault<T0>) : bool {
        arg0.confirmed
    }

    public fun is_redeemed<T0>(arg0: &MigrationVault<T0>) : bool {
        arg0.redeemed
    }

    public fun pool_id<T0>(arg0: &MigrationVault<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    public fun redeem<T0>(arg0: &mut MigrationVault<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::MigrationCap) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        assert!(!arg0.redeemed, 0);
        arg0.redeemed = true;
        (0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui), 0x2::balance::withdraw_all<T0>(&mut arg0.tokens))
    }

    public fun redeem_coins<T0>(arg0: &mut MigrationVault<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::MigrationCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let (v0, v1) = redeem<T0>(arg0, arg1);
        (0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), 0x2::coin::from_balance<T0>(v1, arg2))
    }

    public fun return_dust<T0>(arg0: &mut MigrationVault<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, arg1);
        0x2::balance::join<T0>(&mut arg0.tokens, arg2);
    }

    public fun sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        (sqrt_u256(((arg1 as u256) << 128) / (arg0 as u256)) as u128)
    }

    fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun sui_amount<T0>(arg0: &MigrationVault<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun sui_at_graduation<T0>(arg0: &MigrationVault<T0>) : u64 {
        arg0.sui_at_graduation
    }

    public fun sweep_dust<T0>(arg0: &mut MigrationVault<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::MigrationCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.tokens);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), arg2);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        };
        if (0x2::balance::value<T0>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), arg2);
        } else {
            0x2::balance::destroy_zero<T0>(v1);
        };
    }

    public fun token_amount<T0>(arg0: &MigrationVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun tokens_at_graduation<T0>(arg0: &MigrationVault<T0>) : u64 {
        arg0.tokens_at_graduation
    }

    // decompiled from Move bytecode v7
}

