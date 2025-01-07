module 0x5f59025ec9d3f953e262463aff3858225299b49c1d410d10f6f19f12de096999::staked_sui_swap {
    struct STAKED_SUI_SWAP has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        k: u256,
        balance_p: 0x2::balance::Balance<T0>,
        balance_staked_sui: u256,
    }

    struct WalletEntryKey has copy, drop, store {
        address: address,
    }

    public fun calculate_p_amount_in(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u64 {
        ((arg3 / (arg2 - arg0) - arg1) as u64)
    }

    public fun calculate_p_amount_out(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u64 {
        ((arg1 - arg3 / (arg2 + arg0)) as u64)
    }

    public fun create_pool<T0>(arg0: &0x2::package::Publisher, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<STAKED_SUI_SWAP>(arg0), 0);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = Pool<T0>{
            id                 : 0x2::object::new(arg3),
            k                  : (0x2::balance::value<T0>(&v0) as u256) * arg2,
            balance_p          : v0,
            balance_staked_sui : arg2,
        };
        0x2::transfer::public_share_object<Pool<T0>>(v1);
    }

    fun init(arg0: STAKED_SUI_SWAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<STAKED_SUI_SWAP>(arg0, arg1);
    }

    public fun swap_staked_sui<T0>(arg0: &mut Pool<T0>, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WalletEntryKey{address: 0x2::tx_context::sender(arg2)};
        assert!(!0x2::dynamic_field::exists_<WalletEntryKey>(&arg0.id, v0), 2);
        let v1 = 0x3::staking_pool::staked_sui_amount(&arg1);
        let v2 = 0x2::balance::value<T0>(&arg0.balance_p);
        let v3 = calculate_p_amount_out((v1 as u256), (v2 as u256), arg0.balance_staked_sui, arg0.k);
        assert!(v2 >= v3, 5);
        arg0.balance_staked_sui = arg0.balance_staked_sui + (v1 as u256);
        0x2::dynamic_field::add<WalletEntryKey, 0x3::staking_pool::StakedSui>(&mut arg0.id, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_p, v3), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun swap_token<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WalletEntryKey{address: 0x2::tx_context::sender(arg2)};
        assert!(0x2::dynamic_field::exists_<WalletEntryKey>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::remove<WalletEntryKey, 0x3::staking_pool::StakedSui>(&mut arg0.id, v0);
        let v2 = 0x3::staking_pool::staked_sui_amount(&v1);
        let v3 = calculate_p_amount_in((v2 as u256), (0x2::balance::value<T0>(&arg0.balance_p) as u256), arg0.balance_staked_sui, arg0.k);
        assert!(0x2::coin::value<T0>(arg1) >= v3, 4);
        arg0.balance_staked_sui = arg0.balance_staked_sui - (v2 as u256);
        0x2::balance::join<T0>(&mut arg0.balance_p, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v3, arg2)));
        0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(v1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

