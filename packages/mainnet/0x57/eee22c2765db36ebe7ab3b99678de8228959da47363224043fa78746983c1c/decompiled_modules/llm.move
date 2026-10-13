module 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::llm {
    struct LlmKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TicketKey has copy, drop, store {
        seq: u64,
    }

    struct LlmState has store {
        next_ticket_seq: u64,
        open_tickets: u64,
        escrowed_total: u64,
        max_open_micro: u64,
        model_allow_hash: 0x1::option::Option<vector<u8>>,
    }

    struct Ticket<phantom T0> has store {
        escrow: 0x2::balance::Balance<T0>,
        max_cost: u64,
        commitment: 0x1::option::Option<vector<u8>>,
        kind: u8,
        minted_ms: u64,
        expires_ms: u64,
        config_id: 0x2::object::ID,
    }

    fun close_state(arg0: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64) {
        let v0 = state_mut(arg0);
        v0.open_tickets = v0.open_tickets - 1;
        v0.escrowed_total = v0.escrowed_total - arg1;
    }

    public fun has_state(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : bool {
        let v0 = LlmKey{dummy_field: false};
        0x2::dynamic_field::exists<LlmKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)
    }

    public fun has_ticket(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64) : bool {
        let v0 = TicketKey{seq: arg1};
        0x2::dynamic_field::exists<TicketKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)
    }

    public fun kind_committed() : u8 {
        0
    }

    public fun kind_open() : u8 {
        1
    }

    public fun llm_state(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : (u64, u64, u64, u64, 0x1::option::Option<vector<u8>>) {
        if (!has_state(arg0)) {
            return (0, 0, 0, 0, 0x1::option::none<vector<u8>>())
        };
        let v0 = LlmKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<LlmKey, LlmState>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0);
        (v1.next_ticket_seq, v1.open_tickets, v1.escrowed_total, v1.max_open_micro, v1.model_allow_hash)
    }

    public fun mint_ticket<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config, arg1: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg2: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::OwnerCap, arg3: u64, arg4: 0x1::option::Option<vector<u8>>, arg5: u8, arg6: &0x2::clock::Clock) : u64 {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::check_owner(arg1, arg2);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_live(arg1);
        assert!(!0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::is_paused(arg0), 201);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_pinned_coin<T0>(arg0);
        assert!(arg5 == 0 || arg5 == 1, 202);
        if (arg5 == 0) {
            assert!(0x1::option::is_some<vector<u8>>(&arg4) && 0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg4)) == 32, 203);
        } else {
            assert!(0x1::option::is_none<vector<u8>>(&arg4), 203);
        };
        let v0 = 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg1);
        let v1 = state_mut(arg1);
        if (arg5 == 1) {
            assert!(arg3 <= v1.max_open_micro, 204);
        };
        let v2 = v1.next_ticket_seq;
        v1.next_ticket_seq = v2 + 1;
        v1.open_tickets = v1.open_tickets + 1;
        v1.escrowed_total = v1.escrowed_total + arg3;
        let v3 = 0x2::clock::timestamp_ms(arg6);
        let v4 = v3 + 86400000;
        let v5 = TicketKey{seq: v2};
        let v6 = Ticket<T0>{
            escrow     : 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::escrow_split<T0>(arg0, arg1, arg3, arg6),
            max_cost   : arg3,
            commitment : arg4,
            kind       : arg5,
            minted_ms  : v3,
            expires_ms : v4,
            config_id  : 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config>(arg0),
        };
        0x2::dynamic_field::add<TicketKey, Ticket<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg1), v5, v6);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_ticket_minted(v0, v2, arg3, arg5, arg4, v3, v4);
        v2
    }

    public fun reclaim_expired<T0>(arg0: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = TicketKey{seq: arg1};
        assert!(0x2::dynamic_field::exists<TicketKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 205);
        let v1 = 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg0);
        let v2 = TicketKey{seq: arg1};
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x2::dynamic_field::borrow<TicketKey, Ticket<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v2).expires_ms, 207);
        let v3 = TicketKey{seq: arg1};
        let Ticket {
            escrow     : v4,
            max_cost   : v5,
            commitment : _,
            kind       : _,
            minted_ms  : v8,
            expires_ms : _,
            config_id  : _,
        } = 0x2::dynamic_field::remove<TicketKey, Ticket<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v3);
        let v11 = v4;
        close_state(arg0, v5);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::escrow_return<T0>(arg0, v11, v8 / 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::ms_per_day());
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_ticket_reclaimed(v1, arg1, 0x2::balance::value<T0>(&v11), 0x2::tx_context::sender(arg3));
    }

    public fun set_llm_policy(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config, arg1: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg2: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::OwnerCap, arg3: u64, arg4: 0x1::option::Option<vector<u8>>) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::check_owner(arg1, arg2);
        assert!(arg3 <= 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::ceiling_charge_micro(arg0), 209);
        if (0x1::option::is_some<vector<u8>>(&arg4)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg4)) == 32, 210);
        };
        let v0 = 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg1);
        let v1 = state_mut(arg1);
        v1.max_open_micro = arg3;
        v1.model_allow_hash = arg4;
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_llm_policy_set(v0, arg3, arg4);
    }

    public fun settle<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config, arg1: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::IssuerCap, arg2: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_issuer(arg0, arg1);
        assert!(!0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::is_paused(arg0), 201);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_pinned_coin<T0>(arg0);
        let v0 = TicketKey{seq: arg3};
        assert!(0x2::dynamic_field::exists<TicketKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v0), 205);
        let v1 = 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg2);
        let v2 = TicketKey{seq: arg3};
        let Ticket {
            escrow     : v3,
            max_cost   : v4,
            commitment : v5,
            kind       : _,
            minted_ms  : v7,
            expires_ms : _,
            config_id  : v9,
        } = 0x2::dynamic_field::remove<TicketKey, Ticket<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg2), v2);
        let v10 = v3;
        assert!(v9 == 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config>(arg0), 208);
        assert!(arg4 <= v4, 206);
        let v11 = 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::treasury(arg0);
        let v12 = 0x2::balance::split<T0>(&mut v10, arg4);
        if (0x2::balance::value<T0>(&v12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg5), v11);
        } else {
            0x2::balance::destroy_zero<T0>(v12);
        };
        close_state(arg2, v4);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::escrow_return<T0>(arg2, v10, v7 / 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::ms_per_day());
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_ticket_settled(v1, arg3, v4, arg4, v5, v11);
    }

    fun state_mut(arg0: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : &mut LlmState {
        let v0 = LlmKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LlmKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)) {
            let v1 = LlmKey{dummy_field: false};
            let v2 = LlmState{
                next_ticket_seq  : 0,
                open_tickets     : 0,
                escrowed_total   : 0,
                max_open_micro   : 0,
                model_allow_hash : 0x1::option::none<vector<u8>>(),
            };
            0x2::dynamic_field::add<LlmKey, LlmState>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v1, v2);
        };
        let v3 = LlmKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<LlmKey, LlmState>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v3)
    }

    public fun ticket_info<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64) : (u64, u8, 0x1::option::Option<vector<u8>>, u64, u64) {
        let v0 = TicketKey{seq: arg1};
        assert!(0x2::dynamic_field::exists<TicketKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 205);
        let v1 = TicketKey{seq: arg1};
        let v2 = 0x2::dynamic_field::borrow<TicketKey, Ticket<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v1);
        (v2.max_cost, v2.kind, v2.commitment, v2.minted_ms, v2.expires_ms)
    }

    public fun ttl_ms() : u64 {
        86400000
    }

    // decompiled from Move bytecode v7
}

