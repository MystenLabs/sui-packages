module 0x97a1fe540f5904405474c171ce96062f8f0cac9c2538b05d8c76e9900adf3ff7::prize {
    struct Prize<phantom T0> has key {
        id: 0x2::object::UID,
        host: address,
        resolver_pubkey: vector<u8>,
        app_id: vector<u8>,
        reference: vector<u8>,
        join_deadline_ms: u64,
        resolve_deadline_ms: u64,
        dispute_ms: u64,
        max_players: u64,
        players: 0x2::table::Table<address, bool>,
        player_count: u64,
        state: u8,
        winners: vector<address>,
        amounts: vector<u64>,
        dispute_ends_ms: u64,
        corrected: bool,
        pot: 0x2::balance::Balance<T0>,
    }

    struct Created has copy, drop {
        prize: 0x2::object::ID,
        host: address,
        pot: u64,
        app_id: vector<u8>,
        reference: vector<u8>,
    }

    struct Joined has copy, drop {
        prize: 0x2::object::ID,
        player: address,
    }

    struct Resolved has copy, drop {
        prize: 0x2::object::ID,
        winners: vector<address>,
        amounts: vector<u64>,
        dispute_ends_ms: u64,
        correction: bool,
    }

    struct Paid has copy, drop {
        prize: 0x2::object::ID,
        winners: vector<address>,
        amounts: vector<u64>,
        returned_to_host: u64,
    }

    struct Refunded has copy, drop {
        prize: 0x2::object::ID,
        host: address,
        amount: u64,
        reason: u8,
    }

    fun check_payout<T0>(arg0: &Prize<T0>, arg1: &vector<address>, arg2: &vector<u64>) {
        let v0 = 0x1::vector::length<address>(arg1);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 10);
        assert!(v0 <= 50, 11);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(arg1, v2);
            assert!(0x2::table::contains<address, bool>(&arg0.players, v3), 12);
            let v4 = v2 + 1;
            while (v4 < v0) {
                assert!(*0x1::vector::borrow<address>(arg1, v4) != v3, 14);
                v4 = v4 + 1;
            };
            v1 = v1 + (*0x1::vector::borrow<u64>(arg2, v2) as u128);
            v2 = v2 + 1;
        };
        assert!(v1 <= (0x2::balance::value<T0>(&arg0.pot) as u128), 13);
    }

    public fun correct<T0>(arg0: &mut Prize<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.state == 1, 15);
        assert!(v0 < arg0.dispute_ends_ms, 17);
        assert!(!arg0.corrected, 19);
        check_payout<T0>(arg0, &arg1, &arg2);
        let v1 = result_message(0x2::object::id<Prize<T0>>(arg0), &arg1, &arg2, true);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.resolver_pubkey, &v1), 9);
        arg0.corrected = true;
        set_result<T0>(arg0, arg1, arg2, v0, true);
    }

    public fun create<T0>(arg0: 0x2::balance::Balance<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 0);
        assert!(0x2::balance::value<T0>(&arg0) > 0, 1);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg8) && arg3 > arg2, 2);
        assert!(arg4 >= 600000, 3);
        assert!(arg5 >= 1 && arg5 <= 500, 3);
        assert!(0x1::vector::length<u8>(&arg7) <= 64 && 0x1::vector::length<u8>(&arg6) <= 64, 4);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = Prize<T0>{
            id                  : 0x2::object::new(arg9),
            host                : v0,
            resolver_pubkey     : arg1,
            app_id              : arg6,
            reference           : arg7,
            join_deadline_ms    : arg2,
            resolve_deadline_ms : arg3,
            dispute_ms          : arg4,
            max_players         : arg5,
            players             : 0x2::table::new<address, bool>(arg9),
            player_count        : 0,
            state               : 0,
            winners             : vector[],
            amounts             : vector[],
            dispute_ends_ms     : 0,
            corrected           : false,
            pot                 : arg0,
        };
        let v2 = Created{
            prize     : 0x2::object::id<Prize<T0>>(&v1),
            host      : v0,
            pot       : 0x2::balance::value<T0>(&v1.pot),
            app_id    : v1.app_id,
            reference : v1.reference,
        };
        0x2::event::emit<Created>(v2);
        0x2::transfer::share_object<Prize<T0>>(v1);
    }

    public fun finalize<T0>(arg0: Prize<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.state == 1, 15);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.dispute_ends_ms, 16);
        let Prize {
            id                  : v0,
            host                : v1,
            resolver_pubkey     : _,
            app_id              : _,
            reference           : _,
            join_deadline_ms    : _,
            resolve_deadline_ms : _,
            dispute_ms          : _,
            max_players         : _,
            players             : v9,
            player_count        : _,
            state               : _,
            winners             : v12,
            amounts             : v13,
            dispute_ends_ms     : _,
            corrected           : _,
            pot                 : v16,
        } = arg0;
        let v17 = v16;
        let v18 = v13;
        let v19 = v12;
        let v20 = 0;
        while (v20 < 0x1::vector::length<address>(&v19)) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v17, *0x1::vector::borrow<u64>(&v18, v20)), *0x1::vector::borrow<address>(&v19, v20));
            v20 = v20 + 1;
        };
        let v21 = 0x2::balance::value<T0>(&v17);
        if (v21 > 0) {
            0x2::balance::send_funds<T0>(v17, v1);
        } else {
            0x2::balance::destroy_zero<T0>(v17);
        };
        0x2::table::drop<address, bool>(v9);
        0x2::object::delete(v0);
        let v22 = Paid{
            prize            : 0x2::object::id<Prize<T0>>(&arg0),
            winners          : v19,
            amounts          : v18,
            returned_to_host : v21,
        };
        0x2::event::emit<Paid>(v22);
    }

    public fun has_joined<T0>(arg0: &Prize<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.players, arg1)
    }

    public fun host<T0>(arg0: &Prize<T0>) : address {
        arg0.host
    }

    public fun is_resolved<T0>(arg0: &Prize<T0>) : bool {
        arg0.state == 1
    }

    public fun join<T0>(arg0: &mut Prize<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 8);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.join_deadline_ms, 5);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.players, v0), 6);
        assert!(arg0.player_count < arg0.max_players, 7);
        0x2::table::add<address, bool>(&mut arg0.players, v0, true);
        arg0.player_count = arg0.player_count + 1;
        let v1 = Joined{
            prize  : 0x2::object::id<Prize<T0>>(arg0),
            player : v0,
        };
        0x2::event::emit<Joined>(v1);
    }

    public fun player_count<T0>(arg0: &Prize<T0>) : u64 {
        arg0.player_count
    }

    public fun pot_value<T0>(arg0: &Prize<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    fun refund_all<T0>(arg0: Prize<T0>, arg1: u8) {
        let Prize {
            id                  : v0,
            host                : v1,
            resolver_pubkey     : _,
            app_id              : _,
            reference           : _,
            join_deadline_ms    : _,
            resolve_deadline_ms : _,
            dispute_ms          : _,
            max_players         : _,
            players             : v9,
            player_count        : _,
            state               : _,
            winners             : _,
            amounts             : _,
            dispute_ends_ms     : _,
            corrected           : _,
            pot                 : v16,
        } = arg0;
        let v17 = v16;
        0x2::balance::send_funds<T0>(v17, v1);
        0x2::table::drop<address, bool>(v9);
        0x2::object::delete(v0);
        let v18 = Refunded{
            prize  : 0x2::object::id<Prize<T0>>(&arg0),
            host   : v1,
            amount : 0x2::balance::value<T0>(&v17),
            reason : arg1,
        };
        0x2::event::emit<Refunded>(v18);
    }

    public fun refund_unresolved<T0>(arg0: Prize<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.state == 0, 8);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.resolve_deadline_ms, 20);
        refund_all<T0>(arg0, 1);
    }

    public fun resolve<T0>(arg0: &mut Prize<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.state == 0, 8);
        assert!(v0 >= arg0.join_deadline_ms, 20);
        assert!(v0 < arg0.resolve_deadline_ms, 21);
        check_payout<T0>(arg0, &arg1, &arg2);
        let v1 = result_message(0x2::object::id<Prize<T0>>(arg0), &arg1, &arg2, false);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.resolver_pubkey, &v1), 9);
        set_result<T0>(arg0, arg1, arg2, v0, false);
    }

    public fun result_message(arg0: 0x2::object::ID, arg1: &vector<address>, arg2: &vector<u64>, arg3: bool) : vector<u8> {
        let v0 = b"zend-prize-result-v1";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(arg2));
        let v1 = if (arg3) {
            1
        } else {
            0
        };
        0x1::vector::push_back<u8>(&mut v0, v1);
        v0
    }

    fun set_result<T0>(arg0: &mut Prize<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: u64, arg4: bool) {
        arg0.state = 1;
        arg0.dispute_ends_ms = arg3 + arg0.dispute_ms;
        arg0.winners = arg1;
        arg0.amounts = arg2;
        let v0 = Resolved{
            prize           : 0x2::object::id<Prize<T0>>(arg0),
            winners         : arg0.winners,
            amounts         : arg0.amounts,
            dispute_ends_ms : arg0.dispute_ends_ms,
            correction      : arg4,
        };
        0x2::event::emit<Resolved>(v0);
    }

    public fun veto<T0>(arg0: Prize<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.host, 18);
        assert!(arg0.state == 1, 15);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.dispute_ends_ms, 17);
        refund_all<T0>(arg0, 0);
    }

    // decompiled from Move bytecode v7
}

