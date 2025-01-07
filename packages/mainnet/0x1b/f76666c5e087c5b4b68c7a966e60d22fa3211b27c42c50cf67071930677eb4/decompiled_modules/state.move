module 0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state {
    struct State has store, key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        swap_rate_precision: u64,
        relayer_fee_precision: u64,
        registered_tokens: 0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::RegisteredTokens,
    }

    public(friend) fun new(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : State {
        let v0 = State{
            id                    : 0x2::object::new(arg3),
            emitter_cap           : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg0, arg3),
            swap_rate_precision   : arg1,
            relayer_fee_precision : arg2,
            registered_tokens     : 0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::new(arg3),
        };
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::foreign_contracts::new(&mut v0.id, arg3);
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::relayer_fees::new(&mut v0.id, arg3);
        v0
    }

    public fun is_swap_enabled<T0>(arg0: &State) : bool {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::is_swap_enabled<T0>(&arg0.registered_tokens)
    }

    public fun max_native_swap_amount<T0>(arg0: &State) : u64 {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::max_native_swap_amount<T0>(&arg0.registered_tokens)
    }

    public fun swap_rate<T0>(arg0: &State) : u64 {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::swap_rate<T0>(&arg0.registered_tokens)
    }

    public(friend) fun toggle_swap_enabled<T0>(arg0: &mut State, arg1: bool) {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::toggle_swap_enabled<T0>(&mut arg0.registered_tokens, arg1);
    }

    public(friend) fun update_max_native_swap_amount<T0>(arg0: &mut State, arg1: u64) {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::update_max_native_swap_amount<T0>(&mut arg0.registered_tokens, arg1);
    }

    public(friend) fun update_swap_rate<T0>(arg0: &mut State, arg1: u64) {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::update_swap_rate<T0>(&mut arg0.registered_tokens, arg1);
    }

    public fun contract_registered(arg0: &State, arg1: u16) : bool {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::foreign_contracts::has(&arg0.id, arg1)
    }

    public(friend) fun deregister_token<T0>(arg0: &mut State) {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::remove_token<T0>(&mut arg0.registered_tokens);
    }

    public(friend) fun emitter_cap(arg0: &State) : &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap {
        &arg0.emitter_cap
    }

    public fun foreign_contract_address(arg0: &State, arg1: u16) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        *0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::foreign_contracts::contract_address(&arg0.id, arg1)
    }

    public fun is_registered_token<T0>(arg0: &State) : bool {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::has<T0>(&arg0.registered_tokens)
    }

    public fun native_swap_rate<T0>(arg0: &State) : u64 {
        let v0 = (swap_rate_precision(arg0) as u256) * (swap_rate<0x2::sui::SUI>(arg0) as u256) / (swap_rate<T0>(arg0) as u256);
        assert!(v0 > 0 && v0 <= 18446744073709551614, 3);
        (v0 as u64)
    }

    public(friend) fun register_foreign_contract(arg0: &mut State, arg1: u16, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) {
        if (contract_registered(arg0, arg1)) {
            0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::foreign_contracts::update(&mut arg0.id, arg1, arg2);
        } else {
            0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::foreign_contracts::add(&mut arg0.id, arg1, arg2);
        };
    }

    public(friend) fun register_token<T0>(arg0: &mut State, arg1: u64, arg2: u64, arg3: bool) {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::add_token<T0>(&mut arg0.registered_tokens, arg1, arg2, arg3);
    }

    public fun registered_token_count(arg0: &State) : u64 {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::registered_tokens::num_tokens(&arg0.registered_tokens)
    }

    public fun relayer_fee_is_set(arg0: &State, arg1: u16) : bool {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::relayer_fees::has(&arg0.id, arg1)
    }

    public fun relayer_fee_precision(arg0: &State) : u64 {
        arg0.relayer_fee_precision
    }

    public fun swap_rate_precision(arg0: &State) : u64 {
        arg0.swap_rate_precision
    }

    public fun token_relayer_fee<T0>(arg0: &State, arg1: u16, arg2: u8) : u64 {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::relayer_fees::token_fee(&arg0.id, arg1, arg2, swap_rate<T0>(arg0), swap_rate_precision(arg0), relayer_fee_precision(arg0))
    }

    public(friend) fun update_relayer_fee(arg0: &mut State, arg1: u16, arg2: u64) {
        if (relayer_fee_is_set(arg0, arg1)) {
            0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::relayer_fees::update(&mut arg0.id, arg1, arg2);
        } else {
            0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::relayer_fees::add(&mut arg0.id, arg1, arg2);
        };
    }

    public(friend) fun update_relayer_fee_precision(arg0: &mut State, arg1: u64) {
        assert!(arg1 > 0, 2);
        arg0.relayer_fee_precision = arg1;
    }

    public(friend) fun update_swap_rate_precision(arg0: &mut State, arg1: u64) {
        assert!(arg1 > 0, 2);
        arg0.swap_rate_precision = arg1;
    }

    public fun usd_relayer_fee(arg0: &State, arg1: u16) : u64 {
        0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::relayer_fees::usd_fee(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

