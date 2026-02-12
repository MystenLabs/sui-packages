module 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::core {
    struct LuckyMoney<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        mode: u8,
        total_balance: 0x2::balance::Balance<T0>,
        total_count: u64,
        remaining_count: u64,
        start_time: u64,
        expire_time: u64,
        secret_commitment: vector<u8>,
        nullifiers: 0x2::table::Table<vector<u8>, bool>,
    }

    public fun claim<T0>(arg0: &0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::registry::Registry, arg1: &mut LuckyMoney<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::registry::check_paused(arg0);
        assert!(arg1.remaining_count > 0, 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::envelope_empty());
        assert!(0x2::clock::timestamp_ms(arg6) < arg1.expire_time, 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::envelope_expired());
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.nullifiers, arg4), 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::already_claimed());
        assert!(0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::zk_verifier::verify(&arg2, &arg3), 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::invalid_proof());
        let v0 = if (arg1.remaining_count == 1) {
            0x2::balance::value<T0>(&arg1.total_balance)
        } else if (arg1.mode == 2) {
            let v1 = 0x2::balance::value<T0>(&arg1.total_balance);
            let v2 = arg1.remaining_count;
            let v3 = v1 / v2 * 2;
            let v4 = v1 - (v2 - 1) * 1;
            let v5 = if (v3 < v4) {
                v3
            } else {
                v4
            };
            let v6 = 1;
            if (v5 <= v6) {
                v6
            } else {
                let v7 = 0x2::random::new_generator(arg5, arg7);
                0x2::random::generate_u64_in_range(&mut v7, v6, v5)
            }
        } else {
            0x2::balance::value<T0>(&arg1.total_balance) / arg1.remaining_count
        };
        arg1.remaining_count = arg1.remaining_count - 1;
        0x2::table::add<vector<u8>, bool>(&mut arg1.nullifiers, arg4, true);
        0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::events::emit_claimed(0x2::object::uid_to_inner(&arg1.id), 0x2::tx_context::sender(arg7), v0, arg4, 0x2::balance::value<T0>(&arg1.total_balance), arg1.remaining_count);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.total_balance, v0), arg7)
    }

    public fun create<T0>(arg0: &0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::registry::Registry, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::registry::check_paused(arg0);
        assert!(arg3 > 0, 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::invalid_count());
        assert!(0x2::clock::timestamp_ms(arg6) < arg4, 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::envelope_expired());
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::invalid_mode());
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg3 * 1, 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::insufficient_payment());
        let v2 = 0x2::object::new(arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::events::emit_created(0x2::object::uid_to_inner(&v2), v3, arg2, v1, arg3, arg4, arg5);
        let v4 = LuckyMoney<T0>{
            id                : v2,
            creator           : v3,
            mode              : arg2,
            total_balance     : 0x2::coin::into_balance<T0>(arg1),
            total_count       : arg3,
            remaining_count   : arg3,
            start_time        : 0x2::clock::timestamp_ms(arg6),
            expire_time       : arg4,
            secret_commitment : arg5,
            nullifiers        : 0x2::table::new<vector<u8>, bool>(arg7),
        };
        0x2::transfer::share_object<LuckyMoney<T0>>(v4);
    }

    public fun creator<T0>(arg0: &LuckyMoney<T0>) : address {
        arg0.creator
    }

    public fun expire_time<T0>(arg0: &LuckyMoney<T0>) : u64 {
        arg0.expire_time
    }

    public fun is_nullifier_used<T0>(arg0: &LuckyMoney<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.nullifiers, arg1)
    }

    public fun mode<T0>(arg0: &LuckyMoney<T0>) : u8 {
        arg0.mode
    }

    public fun refund<T0>(arg0: &mut LuckyMoney<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expire_time, 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::not_expired());
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::not_owner());
        0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::events::emit_refunded(0x2::object::uid_to_inner(&arg0.id), arg0.creator, 0x2::balance::value<T0>(&arg0.total_balance));
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.total_balance), arg2)
    }

    public fun remaining_count<T0>(arg0: &LuckyMoney<T0>) : u64 {
        arg0.remaining_count
    }

    public fun start_time<T0>(arg0: &LuckyMoney<T0>) : u64 {
        arg0.start_time
    }

    public fun total_balance<T0>(arg0: &LuckyMoney<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_balance)
    }

    public fun total_count<T0>(arg0: &LuckyMoney<T0>) : u64 {
        arg0.total_count
    }

    // decompiled from Move bytecode v6
}

