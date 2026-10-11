module 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::launch {
    struct Initialized has copy, drop {
        airdrop_id: 0x2::object::ID,
        devlock_id: 0x2::object::ID,
        currency_id: 0x2::object::ID,
        liquidity_recipient: address,
        liquidity_coin_id: 0x2::object::ID,
        dev_beneficiary: address,
        merkle_root: vector<u8>,
        snapshot_id: u64,
        total_sbt_count: u64,
        per_sbt: u64,
        rounding_remainder: u64,
        claim_start_ms: u64,
        claim_deadline_ms: u64,
        dev_unlock_ms: u64,
        initial_supply: u64,
        airdrop_amount: u64,
        liquidity_amount: u64,
        dev_amount: u64,
    }

    public fun initialize(arg0: 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::LaunchCap, arg1: &0x2::coin_registry::Currency<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: address, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::total_supply_constant();
        assert!(0x2::coin_registry::is_supply_burn_only<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(arg1), 202);
        let v1 = 0x2::coin_registry::total_supply<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(arg1);
        let v2 = &v1;
        assert!(0x1::option::is_some<u64>(v2) && *0x1::option::borrow<u64>(v2) == v0, 202);
        assert!(arg5 != @0x0 && arg6 != @0x0, 203);
        let v3 = 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::consume_launch_cap(arg0);
        assert!(0x2::balance::value<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&v3) == v0, 201);
        assert!(0x2::balance::value<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&v3) == 300000000000000000, 201);
        let v4 = 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::airdrop::new(0x2::balance::split<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&mut v3, 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::airdrop::airdrop_total()), arg2, arg3, arg4, arg7, arg8);
        let v5 = 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::devlock::new(0x2::balance::split<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&mut v3, 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::devlock::dev_total()), arg5, arg7, arg8);
        let v6 = 0x2::coin::from_balance<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(v3, arg8);
        let v7 = Initialized{
            airdrop_id          : 0x2::object::id<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::airdrop::Airdrop>(&v4),
            devlock_id          : 0x2::object::id<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::devlock::DevLock>(&v5),
            currency_id         : 0x2::object::id<0x2::coin_registry::Currency<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>>(arg1),
            liquidity_recipient : arg6,
            liquidity_coin_id   : 0x2::object::id<0x2::coin::Coin<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>>(&v6),
            dev_beneficiary     : arg5,
            merkle_root         : arg2,
            snapshot_id         : arg3,
            total_sbt_count     : arg4,
            per_sbt             : 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::airdrop::per_sbt(&v4),
            rounding_remainder  : 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::airdrop::rounding_remainder(&v4),
            claim_start_ms      : 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::airdrop::claim_start_ms(&v4),
            claim_deadline_ms   : 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::airdrop::claim_deadline_ms(&v4),
            dev_unlock_ms       : 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::devlock::unlock_ms(&v5),
            initial_supply      : v0,
            airdrop_amount      : 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::airdrop::airdrop_total(),
            liquidity_amount    : 300000000000000000,
            dev_amount          : 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::devlock::dev_total(),
        };
        0x2::event::emit<Initialized>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>>(v6, arg6);
        0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::airdrop::share(v4);
        0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::devlock::share(v5);
    }

    public fun liquidity_total() : u64 {
        300000000000000000
    }

    // decompiled from Move bytecode v7
}

