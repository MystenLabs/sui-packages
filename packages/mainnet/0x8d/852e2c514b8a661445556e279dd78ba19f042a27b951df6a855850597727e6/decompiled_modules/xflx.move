module 0x8d852e2c514b8a661445556e279dd78ba19f042a27b951df6a855850597727e6::xflx {
    struct XFLX has drop {
        dummy_field: bool,
    }

    struct TreasuryManagement has store, key {
        id: 0x2::object::UID,
        total_flx_locked: 0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>,
        cap: 0x2::coin::TreasuryCap<XFLX>,
    }

    struct Lock has store, key {
        id: 0x2::object::UID,
        flx: 0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>,
        xflx: 0x2::coin::Coin<XFLX>,
        lock_time_ms: u64,
        unlocked_at_ms: u64,
    }

    struct Mint has copy, drop {
        to: address,
        amount: u64,
        sender: address,
    }

    struct Burn has copy, drop {
        amount: u64,
        lock_time_ms: u64,
        sender: address,
    }

    public entry fun burn(arg0: &mut TreasuryManagement, arg1: &0x2::clock::Clock, arg2: Lock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg2.unlocked_at_ms, 5);
        let (v0, v1) = unlock_direct(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>>(v0, arg3);
        0x2::coin::burn<XFLX>(&mut arg0.cap, v1);
        let v2 = Burn{
            amount       : 0x2::coin::value<XFLX>(&arg2.xflx),
            lock_time_ms : arg2.lock_time_ms,
            sender       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Burn>(v2);
    }

    public fun value(arg0: &Lock) : (u64, u64) {
        (0x2::coin::value<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&arg0.flx), 0x2::coin::value<XFLX>(&arg0.xflx))
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<XFLX>, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<XFLX>>(arg0, arg1);
    }

    fun calculate_amount_to_receive(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u256) * 1000000000000 / 10 + (arg0 as u256) * (arg1 as u256) * (arg1 as u256) * 1000000000000 / 67184640000000000000) / 1000000000000) as u64)
    }

    public entry fun cancel_lazy_burn(arg0: &mut TreasuryManagement, arg1: &0x2::clock::Clock, arg2: Lock, arg3: address) {
        assert!(arg3 != @0x0, 2);
        assert!(0x2::clock::timestamp_ms(arg1) < arg2.unlocked_at_ms, 4);
        let (v0, v1) = unlock_direct(arg2);
        0x2::coin::join<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&mut arg0.total_flx_locked, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<XFLX>>(v1, arg3);
    }

    fun create_lock(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>, arg2: 0x2::coin::Coin<XFLX>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Lock {
        assert!(arg3 < 18446744073709551615 - 0x2::clock::timestamp_ms(arg0), 3);
        Lock{
            id             : 0x2::object::new(arg4),
            flx            : arg1,
            xflx           : arg2,
            lock_time_ms   : arg3,
            unlocked_at_ms : 0x2::clock::timestamp_ms(arg0) + arg3,
        }
    }

    fun init(arg0: XFLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XFLX>(arg0, 8, b"XFLX", b"XFlowX", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XFLX>>(v1);
        let v2 = TreasuryManagement{
            id               : 0x2::object::new(arg1),
            total_flx_locked : 0x2::coin::zero<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(arg1),
            cap              : v0,
        };
        0x2::transfer::share_object<TreasuryManagement>(v2);
    }

    public entry fun lazy_burn(arg0: &mut TreasuryManagement, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<XFLX>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<XFLX>(&arg2);
        assert!(arg4 != @0x0, 2);
        assert!(v0 > 0, 0);
        assert!(arg3 <= 7776000000, 1);
        let v1 = 0x2::coin::split<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&mut arg0.total_flx_locked, calculate_amount_to_receive(v0, arg3), arg5);
        if (arg3 > 0) {
            let v2 = create_lock(arg1, v1, arg2, arg3, arg5);
            0x2::object::id<Lock>(&v2);
            0x2::transfer::transfer<Lock>(v2, arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>>(v1, arg4);
            0x2::coin::burn<XFLX>(&mut arg0.cap, arg2);
        };
    }

    public entry fun mint_and_transfer(arg0: &mut TreasuryManagement, arg1: 0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 2);
        let v0 = 0x2::coin::value<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&arg1);
        assert!(v0 > 0, 0);
        0x2::coin::join<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&mut arg0.total_flx_locked, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<XFLX>>(0x2::coin::mint<XFLX>(&mut arg0.cap, v0, arg3), arg2);
        let v1 = Mint{
            to     : arg2,
            amount : v0,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Mint>(v1);
    }

    fun unlock_direct(arg0: Lock) : (0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>, 0x2::coin::Coin<XFLX>) {
        let Lock {
            id             : v0,
            flx            : v1,
            xflx           : v2,
            lock_time_ms   : _,
            unlocked_at_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    public fun unlocked_at(arg0: &Lock) : u64 {
        arg0.unlocked_at_ms
    }

    // decompiled from Move bytecode v6
}

