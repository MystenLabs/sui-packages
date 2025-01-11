module 0xc63c434f9435c6033002d00ff7bcf06c0ae50d6338f5ae83564348e7a8b2572b::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::coin::TreasuryCap<SUID>,
    }

    public fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUID> {
        is_valid_amount(0x2::coin::value<0x2::sui::SUI>(&arg1));
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, v0);
        0x2::coin::from_balance<SUID>(0x2::balance::increase_supply<SUID>(0x2::coin::supply_mut<SUID>(&mut arg0.treasury), 0x2::balance::value<0x2::sui::SUI>(&v0)), arg2)
    }

    entry fun add_liquidity_(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = add_liquidity(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUID>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_assets(arg0: &Pool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun get_supply(arg0: &Pool) : u64 {
        0x2::coin::total_supply<SUID>(&arg0.treasury)
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 9, b"SUID", b"Dacade Staked SUI", b"SUID is a Decade Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUID>>(v1);
        let v2 = Pool{
            id       : 0x2::object::new(arg1),
            sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury : v0,
        };
        0x2::transfer::share_object<Pool>(v2);
    }

    fun is_valid_amount(arg0: u64) {
        assert!(arg0 >= 1000000000, 1);
    }

    public fun remove_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<SUID>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        is_valid_amount(0x2::coin::value<SUID>(&arg1));
        0x2::balance::decrease_supply<SUID>(0x2::coin::supply_mut<SUID>(&mut arg0.treasury), 0x2::coin::into_balance<SUID>(arg1));
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::value<SUID>(&arg1), arg2)
    }

    entry fun remove_liquidity_(arg0: &mut Pool, arg1: 0x2::coin::Coin<SUID>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = remove_liquidity(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun stake(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x3::sui_system::request_add_stake(arg1, arg0, arg2, arg3);
    }

    public fun unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) {
        0x3::sui_system::request_withdraw_stake(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

