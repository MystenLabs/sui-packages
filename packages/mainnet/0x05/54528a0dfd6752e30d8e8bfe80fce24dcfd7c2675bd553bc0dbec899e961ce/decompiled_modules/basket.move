module 0x554528a0dfd6752e30d8e8bfe80fce24dcfd7c2675bd553bc0dbec899e961ce::basket {
    struct BASKET has drop {
        dummy_field: bool,
    }

    struct Reserve has key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<BASKET>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        managed: 0x2::balance::Balance<0x554528a0dfd6752e30d8e8bfe80fce24dcfd7c2675bd553bc0dbec899e961ce::managed::MANAGED>,
    }

    public fun burn(arg0: &mut Reserve, arg1: 0x2::coin::Coin<BASKET>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x554528a0dfd6752e30d8e8bfe80fce24dcfd7c2675bd553bc0dbec899e961ce::managed::MANAGED>) {
        let v0 = 0x2::balance::decrease_supply<BASKET>(&mut arg0.total_supply, 0x2::coin::into_balance<BASKET>(arg1));
        (0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, v0, arg2), 0x2::coin::take<0x554528a0dfd6752e30d8e8bfe80fce24dcfd7c2675bd553bc0dbec899e961ce::managed::MANAGED>(&mut arg0.managed, v0, arg2))
    }

    fun init(arg0: BASKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserve{
            id           : 0x2::object::new(arg1),
            total_supply : 0x2::balance::create_supply<BASKET>(arg0),
            sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            managed      : 0x2::balance::zero<0x554528a0dfd6752e30d8e8bfe80fce24dcfd7c2675bd553bc0dbec899e961ce::managed::MANAGED>(),
        };
        0x2::transfer::share_object<Reserve>(v0);
    }

    public fun managed_supply(arg0: &Reserve) : u64 {
        0x2::balance::value<0x554528a0dfd6752e30d8e8bfe80fce24dcfd7c2675bd553bc0dbec899e961ce::managed::MANAGED>(&arg0.managed)
    }

    public fun mint(arg0: &mut Reserve, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x554528a0dfd6752e30d8e8bfe80fce24dcfd7c2675bd553bc0dbec899e961ce::managed::MANAGED>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BASKET> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == 0x2::coin::value<0x554528a0dfd6752e30d8e8bfe80fce24dcfd7c2675bd553bc0dbec899e961ce::managed::MANAGED>(&arg2), 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui, arg1);
        0x2::coin::put<0x554528a0dfd6752e30d8e8bfe80fce24dcfd7c2675bd553bc0dbec899e961ce::managed::MANAGED>(&mut arg0.managed, arg2);
        0x2::coin::from_balance<BASKET>(0x2::balance::increase_supply<BASKET>(&mut arg0.total_supply, v0), arg3)
    }

    public fun sui_supply(arg0: &Reserve) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun total_supply(arg0: &Reserve) : u64 {
        0x2::balance::supply_value<BASKET>(&arg0.total_supply)
    }

    // decompiled from Move bytecode v6
}

