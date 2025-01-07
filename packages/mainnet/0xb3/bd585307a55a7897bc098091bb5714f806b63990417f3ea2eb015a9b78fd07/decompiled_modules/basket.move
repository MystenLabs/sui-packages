module 0xb3bd585307a55a7897bc098091bb5714f806b63990417f3ea2eb015a9b78fd07::basket {
    struct BASKET has drop {
        dummy_field: bool,
    }

    struct Reserve has key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<BASKET>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        henceut: 0x2::balance::Balance<0xb3bd585307a55a7897bc098091bb5714f806b63990417f3ea2eb015a9b78fd07::henceut::HENCEUT>,
    }

    public fun burn(arg0: &mut Reserve, arg1: 0x2::coin::Coin<BASKET>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0xb3bd585307a55a7897bc098091bb5714f806b63990417f3ea2eb015a9b78fd07::henceut::HENCEUT>) {
        let v0 = 0x2::balance::decrease_supply<BASKET>(&mut arg0.total_supply, 0x2::coin::into_balance<BASKET>(arg1));
        (0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, v0, arg2), 0x2::coin::take<0xb3bd585307a55a7897bc098091bb5714f806b63990417f3ea2eb015a9b78fd07::henceut::HENCEUT>(&mut arg0.henceut, v0, arg2))
    }

    public fun henceut_supply(arg0: &Reserve) : u64 {
        0x2::balance::value<0xb3bd585307a55a7897bc098091bb5714f806b63990417f3ea2eb015a9b78fd07::henceut::HENCEUT>(&arg0.henceut)
    }

    fun init(arg0: BASKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserve{
            id           : 0x2::object::new(arg1),
            total_supply : 0x2::balance::create_supply<BASKET>(arg0),
            sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            henceut      : 0x2::balance::zero<0xb3bd585307a55a7897bc098091bb5714f806b63990417f3ea2eb015a9b78fd07::henceut::HENCEUT>(),
        };
        0x2::transfer::share_object<Reserve>(v0);
    }

    public fun mint(arg0: &mut Reserve, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0xb3bd585307a55a7897bc098091bb5714f806b63990417f3ea2eb015a9b78fd07::henceut::HENCEUT>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BASKET> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == 0x2::coin::value<0xb3bd585307a55a7897bc098091bb5714f806b63990417f3ea2eb015a9b78fd07::henceut::HENCEUT>(&arg2), 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui, arg1);
        0x2::coin::put<0xb3bd585307a55a7897bc098091bb5714f806b63990417f3ea2eb015a9b78fd07::henceut::HENCEUT>(&mut arg0.henceut, arg2);
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

