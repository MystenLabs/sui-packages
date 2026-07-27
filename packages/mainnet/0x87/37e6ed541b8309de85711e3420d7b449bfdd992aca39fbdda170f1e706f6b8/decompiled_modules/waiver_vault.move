module 0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::waiver_vault {
    struct WaiverVault<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        arbitrator: address,
        balance: 0x2::balance::Balance<T0>,
        active_exposure: u64,
        reserved: u64,
        withdraw_delay_ms: u64,
        pending_withdraw_amount: u64,
        pending_withdraw_unlock_ms: u64,
        paused: bool,
        max_cap: u64,
        min_fee_bps: u64,
    }

    struct Coverage has key {
        id: 0x2::object::UID,
        booking_ref: 0x1::string::String,
        escrow_id: 0x2::object::ID,
        guest: address,
        host: address,
        cap: u64,
        fee_paid: u64,
        expires_ms: u64,
        status: u8,
        claim_amount: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        arbitrator: address,
        max_cap: u64,
    }

    struct VaultDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        balance: u64,
    }

    struct WithdrawRequested has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        unlock_ms: u64,
    }

    struct WithdrawExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        balance: u64,
    }

    struct WaiverPurchased has copy, drop {
        coverage_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        escrow_id: 0x2::object::ID,
        guest: address,
        host: address,
        cap: u64,
        fee_paid: u64,
        expires_ms: u64,
    }

    struct ExcessClaimed has copy, drop {
        coverage_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        host: address,
        claim_amount: u64,
    }

    struct ExcessResolved has copy, drop {
        coverage_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        host: address,
        award: u64,
        voided: bool,
    }

    struct CoverageExpired has copy, drop {
        coverage_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        cap_freed: u64,
    }

    struct CoverageCancelled has copy, drop {
        coverage_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        guest: address,
        fee_refunded: u64,
        cap_freed: u64,
    }

    struct StaleClaimVoided has copy, drop {
        coverage_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        claim_released: u64,
    }

    public fun buy_waiver<T0>(arg0: &mut WaiverVault<T0>, arg1: &0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::escrow::BookingEscrow<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 104);
        assert!(0x2::tx_context::sender(arg7) == 0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::escrow::guest<T0>(arg1), 118);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 > 0, 103);
        assert!(arg2 > 0, 103);
        assert!(arg2 <= arg0.max_cap, 106);
        assert!((v0 as u128) * (10000 as u128) >= (arg2 as u128) * (arg0.min_fee_bps as u128), 119);
        assert!(v0 <= arg2, 123);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg4 > v1, 107);
        assert!(arg4 <= v1 + 15552000000, 108);
        assert!(arg4 > arg3, 122);
        assert!(0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::escrow::status<T0>(arg1) == 0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::escrow::status_active(), 116);
        assert!(arg0.active_exposure + arg2 <= 0x2::balance::value<T0>(&arg0.balance) + v0, 105);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg5));
        arg0.active_exposure = arg0.active_exposure + arg2;
        let v2 = Coverage{
            id           : 0x2::object::new(arg7),
            booking_ref  : escrow_ref_of<T0>(arg1),
            escrow_id    : 0x2::object::id<0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::escrow::BookingEscrow<T0>>(arg1),
            guest        : 0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::escrow::guest<T0>(arg1),
            host         : 0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::escrow::host<T0>(arg1),
            cap          : arg2,
            fee_paid     : v0,
            expires_ms   : arg4,
            status       : 0,
            claim_amount : 0,
        };
        let v3 = WaiverPurchased{
            coverage_id : 0x2::object::id<Coverage>(&v2),
            vault_id    : 0x2::object::id<WaiverVault<T0>>(arg0),
            booking_ref : v2.booking_ref,
            escrow_id   : v2.escrow_id,
            guest       : v2.guest,
            host        : v2.host,
            cap         : arg2,
            fee_paid    : v0,
            expires_ms  : arg4,
        };
        0x2::event::emit<WaiverPurchased>(v3);
        0x2::transfer::share_object<Coverage>(v2);
    }

    public fun cancel_coverage<T0>(arg0: &mut WaiverVault<T0>, arg1: Coverage, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 109);
        assert!(0x2::tx_context::sender(arg2) == arg0.arbitrator, 102);
        let Coverage {
            id           : v0,
            booking_ref  : v1,
            escrow_id    : _,
            guest        : v3,
            host         : _,
            cap          : v5,
            fee_paid     : v6,
            expires_ms   : _,
            status       : _,
            claim_amount : _,
        } = arg1;
        let v10 = v0;
        0x2::object::delete(v10);
        arg0.active_exposure = arg0.active_exposure - v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v6), arg2), v3);
        let v11 = CoverageCancelled{
            coverage_id  : 0x2::object::uid_to_inner(&v10),
            booking_ref  : v1,
            guest        : v3,
            fee_refunded : v6,
            cap_freed    : v5,
        };
        0x2::event::emit<CoverageCancelled>(v11);
    }

    public fun claim_excess<T0>(arg0: &mut WaiverVault<T0>, arg1: &mut Coverage, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 109);
        assert!(0x2::tx_context::sender(arg4) == arg1.host, 101);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.expires_ms, 117);
        assert!(arg2 > 0, 103);
        assert!(arg2 <= arg1.cap, 110);
        arg1.status = 1;
        arg1.claim_amount = arg2;
        arg0.reserved = arg0.reserved + arg2;
        let v0 = ExcessClaimed{
            coverage_id  : 0x2::object::id<Coverage>(arg1),
            booking_ref  : arg1.booking_ref,
            host         : arg1.host,
            claim_amount : arg2,
        };
        0x2::event::emit<ExcessClaimed>(v0);
    }

    public fun coverage_cap(arg0: &Coverage) : u64 {
        arg0.cap
    }

    public fun coverage_claim_amount(arg0: &Coverage) : u64 {
        arg0.claim_amount
    }

    public fun coverage_escrow_id(arg0: &Coverage) : 0x2::object::ID {
        arg0.escrow_id
    }

    public fun coverage_expires_ms(arg0: &Coverage) : u64 {
        arg0.expires_ms
    }

    public fun coverage_fee_paid(arg0: &Coverage) : u64 {
        arg0.fee_paid
    }

    public fun coverage_guest(arg0: &Coverage) : address {
        arg0.guest
    }

    public fun coverage_host(arg0: &Coverage) : address {
        arg0.host
    }

    public fun coverage_ref(arg0: &Coverage) : 0x1::string::String {
        arg0.booking_ref
    }

    public fun coverage_status(arg0: &Coverage) : u8 {
        arg0.status
    }

    public fun create_vault<T0>(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 103);
        assert!(arg4 > 0 && arg4 < 10000, 120);
        assert!(arg0 != arg1, 121);
        let v0 = WaiverVault<T0>{
            id                         : 0x2::object::new(arg5),
            admin                      : arg0,
            arbitrator                 : arg1,
            balance                    : 0x2::balance::zero<T0>(),
            active_exposure            : 0,
            reserved                   : 0,
            withdraw_delay_ms          : arg2,
            pending_withdraw_amount    : 0,
            pending_withdraw_unlock_ms : 0,
            paused                     : false,
            max_cap                    : arg3,
            min_fee_bps                : arg4,
        };
        let v1 = VaultCreated{
            vault_id   : 0x2::object::id<WaiverVault<T0>>(&v0),
            admin      : arg0,
            arbitrator : arg1,
            max_cap    : arg3,
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<WaiverVault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut WaiverVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 103);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = VaultDeposited{
            vault_id : 0x2::object::id<WaiverVault<T0>>(arg0),
            amount   : v0,
            balance  : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<VaultDeposited>(v1);
    }

    fun escrow_ref_of<T0>(arg0: &0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::escrow::BookingEscrow<T0>) : 0x1::string::String {
        0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::escrow::booking_ref<T0>(arg0)
    }

    public fun execute_withdraw<T0>(arg0: &mut WaiverVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        let v0 = arg0.pending_withdraw_amount;
        assert!(v0 > 0, 114);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_withdraw_unlock_ms, 113);
        assert!(v0 <= 0x2::balance::value<T0>(&arg0.balance) - arg0.active_exposure, 105);
        arg0.pending_withdraw_amount = 0;
        arg0.pending_withdraw_unlock_ms = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2), arg0.admin);
        let v1 = WithdrawExecuted{
            vault_id : 0x2::object::id<WaiverVault<T0>>(arg0),
            amount   : v0,
            balance  : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<WithdrawExecuted>(v1);
    }

    public fun expire_coverage<T0>(arg0: &mut WaiverVault<T0>, arg1: Coverage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 109);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expires_ms, 112);
        let Coverage {
            id           : v0,
            booking_ref  : v1,
            escrow_id    : _,
            guest        : _,
            host         : _,
            cap          : v5,
            fee_paid     : _,
            expires_ms   : _,
            status       : _,
            claim_amount : _,
        } = arg1;
        let v10 = v0;
        0x2::object::delete(v10);
        arg0.active_exposure = arg0.active_exposure - v5;
        let v11 = CoverageExpired{
            coverage_id : 0x2::object::uid_to_inner(&v10),
            booking_ref : v1,
            cap_freed   : v5,
        };
        0x2::event::emit<CoverageExpired>(v11);
    }

    public fun request_withdraw<T0>(arg0: &mut WaiverVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        assert!(arg1 > 0, 103);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.balance) - arg0.active_exposure, 105);
        let v0 = 0x2::clock::timestamp_ms(arg2) + arg0.withdraw_delay_ms;
        arg0.pending_withdraw_amount = arg1;
        arg0.pending_withdraw_unlock_ms = v0;
        let v1 = WithdrawRequested{
            vault_id  : 0x2::object::id<WaiverVault<T0>>(arg0),
            amount    : arg1,
            unlock_ms : v0,
        };
        0x2::event::emit<WithdrawRequested>(v1);
    }

    public fun resolve_excess<T0>(arg0: &mut WaiverVault<T0>, arg1: Coverage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 109);
        assert!(0x2::tx_context::sender(arg3) == arg0.arbitrator, 102);
        assert!(arg2 <= arg1.claim_amount, 111);
        let Coverage {
            id           : v0,
            booking_ref  : v1,
            escrow_id    : _,
            guest        : _,
            host         : v4,
            cap          : v5,
            fee_paid     : _,
            expires_ms   : _,
            status       : _,
            claim_amount : v9,
        } = arg1;
        let v10 = v0;
        0x2::object::delete(v10);
        arg0.active_exposure = arg0.active_exposure - v5;
        arg0.reserved = arg0.reserved - v9;
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3), v4);
        };
        let v11 = ExcessResolved{
            coverage_id : 0x2::object::uid_to_inner(&v10),
            booking_ref : v1,
            host        : v4,
            award       : arg2,
            voided      : arg2 == 0,
        };
        0x2::event::emit<ExcessResolved>(v11);
    }

    public fun set_max_cap<T0>(arg0: &mut WaiverVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(arg1 > 0, 103);
        arg0.max_cap = arg1;
    }

    public fun set_paused<T0>(arg0: &mut WaiverVault<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        arg0.paused = arg1;
    }

    public fun vault_admin<T0>(arg0: &WaiverVault<T0>) : address {
        arg0.admin
    }

    public fun vault_arbitrator<T0>(arg0: &WaiverVault<T0>) : address {
        arg0.arbitrator
    }

    public fun vault_balance<T0>(arg0: &WaiverVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun vault_exposure<T0>(arg0: &WaiverVault<T0>) : u64 {
        arg0.active_exposure
    }

    public fun vault_max_cap<T0>(arg0: &WaiverVault<T0>) : u64 {
        arg0.max_cap
    }

    public fun vault_min_fee_bps<T0>(arg0: &WaiverVault<T0>) : u64 {
        arg0.min_fee_bps
    }

    public fun vault_paused<T0>(arg0: &WaiverVault<T0>) : bool {
        arg0.paused
    }

    public fun vault_pending_withdraw<T0>(arg0: &WaiverVault<T0>) : u64 {
        arg0.pending_withdraw_amount
    }

    public fun vault_reserved<T0>(arg0: &WaiverVault<T0>) : u64 {
        arg0.reserved
    }

    public fun void_stale_claim<T0>(arg0: &mut WaiverVault<T0>, arg1: Coverage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 109);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expires_ms + 2592000000, 115);
        let Coverage {
            id           : v0,
            booking_ref  : v1,
            escrow_id    : _,
            guest        : _,
            host         : _,
            cap          : v5,
            fee_paid     : _,
            expires_ms   : _,
            status       : _,
            claim_amount : v9,
        } = arg1;
        let v10 = v0;
        0x2::object::delete(v10);
        arg0.active_exposure = arg0.active_exposure - v5;
        arg0.reserved = arg0.reserved - v9;
        let v11 = StaleClaimVoided{
            coverage_id    : 0x2::object::uid_to_inner(&v10),
            booking_ref    : v1,
            claim_released : v9,
        };
        0x2::event::emit<StaleClaimVoided>(v11);
    }

    // decompiled from Move bytecode v7
}

