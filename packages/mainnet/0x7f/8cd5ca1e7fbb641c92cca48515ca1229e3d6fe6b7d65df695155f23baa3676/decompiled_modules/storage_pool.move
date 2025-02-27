module 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool {
    struct MoomeStoragePoolRecord<phantom T0> has store {
        coin_type: 0x1::ascii::String,
        first_time_seen_ms: u64,
        first_time_seen_meta: vector<u8>,
        most_recent_seen_ms: u64,
        most_recent_seen_meta: vector<u8>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct MoomeStoragePool has store, key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        bag: 0x2::bag::Bag,
        stored_amounts: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        meta: vector<u8>,
    }

    struct MoomeStorageWithdrawPotato {
        storage_pool_id: 0x2::object::ID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        already_withdrawn: vector<vector<u8>>,
        shares_count: u256,
        all_shares_count: u256,
    }

    public(friend) fun consume_potato(arg0: &MoomeStoragePool, arg1: MoomeStorageWithdrawPotato) : 0x2::balance::Balance<0x2::sui::SUI> {
        let MoomeStorageWithdrawPotato {
            storage_pool_id   : v0,
            sui               : v1,
            already_withdrawn : _,
            shares_count      : _,
            all_shares_count  : _,
        } = arg1;
        assert!(0x2::object::id<MoomeStoragePool>(arg0) == v0, 9223372397632028671);
        v1
    }

    public fun first_time_seen_ms<T0>(arg0: &MoomeStoragePool) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::bag::contains<0x1::ascii::String>(&arg0.bag, v0)) {
            return 0
        };
        0x2::bag::borrow<0x1::ascii::String, MoomeStoragePoolRecord<T0>>(&arg0.bag, v0).first_time_seen_ms
    }

    public(friend) fun get_with_potato<T0>(arg0: &mut MoomeStoragePool, arg1: &mut MoomeStorageWithdrawPotato) : 0x2::balance::Balance<T0> {
        if (type_is_sui<T0>()) {
            abort 2
        };
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::object::id<MoomeStoragePool>(arg0) == arg1.storage_pool_id, 9223372449171636223);
        if (0x1::vector::contains<vector<u8>>(&arg1.already_withdrawn, &v0)) {
            abort 3
        };
        0x1::vector::push_back<vector<u8>>(&mut arg1.already_withdrawn, v0);
        internal_get<T0>(arg0, arg1.shares_count, arg1.all_shares_count)
    }

    fun internal_get<T0>(arg0: &mut MoomeStoragePool, arg1: u256, arg2: u256) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.bag, v0)) {
            let v1 = &mut 0x2::bag::borrow_mut<0x1::ascii::String, MoomeStoragePoolRecord<T0>>(&mut arg0.bag, v0).balance;
            let (v2, v3) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::math::try_mul_div_down((0x2::balance::value<T0>(v1) as u256), arg1, arg2);
            if (v2 && v3 > 0) {
                0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_unstaked_event(v0, (v3 as u64));
                *0x2::vec_map::get_mut<0x1::ascii::String, u64>(&mut arg0.stored_amounts, &v0) = 0x2::balance::value<T0>(v1);
                return 0x2::balance::split<T0>(v1, (v3 as u64))
            };
        };
        0x2::balance::zero<T0>()
    }

    fun internal_get_sui(arg0: &mut MoomeStoragePool, arg1: u64, arg2: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (v0, v1) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::math::try_mul_div_down((0x2::balance::value<0x2::sui::SUI>(&arg0.sui) as u256), (arg1 as u256), (arg2 as u256));
        if (v0 && v1 > 0) {
            let v2 = 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>());
            0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_unstaked_event(v2, (v1 as u64));
            *0x2::vec_map::get_mut<0x1::ascii::String, u64>(&mut arg0.stored_amounts, &v2) = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui);
            return 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, (v1 as u64))
        };
        0x2::balance::zero<0x2::sui::SUI>()
    }

    public(friend) fun make(arg0: &mut 0x2::tx_context::TxContext) : MoomeStoragePool {
        MoomeStoragePool{
            id             : 0x2::object::new(arg0),
            sui            : 0x2::balance::zero<0x2::sui::SUI>(),
            bag            : 0x2::bag::new(arg0),
            stored_amounts : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            meta           : 0x1::vector::empty<u8>(),
        }
    }

    public(friend) fun put<T0>(arg0: &mut MoomeStoragePool, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: vector<u8>) {
        save_record<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun put_sui(arg0: &mut MoomeStoragePool, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>());
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_staked_event(v0, 0x2::balance::value<0x2::sui::SUI>(&arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, arg1);
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.stored_amounts, &v0)) {
            *0x2::vec_map::get_mut<0x1::ascii::String, u64>(&mut arg0.stored_amounts, &v0) = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui);
        } else {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.stored_amounts, v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui));
        };
    }

    fun save_record<T0>(arg0: &mut MoomeStoragePool, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: vector<u8>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_staked_event(v0, 0x2::balance::value<T0>(&arg1));
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.bag, v0)) {
            let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, MoomeStoragePoolRecord<T0>>(&mut arg0.bag, v0);
            let v2 = &mut v1.balance;
            0x2::balance::join<T0>(v2, arg1);
            v1.most_recent_seen_ms = 0x2::clock::timestamp_ms(arg2);
            v1.most_recent_seen_meta = arg3;
            *0x2::vec_map::get_mut<0x1::ascii::String, u64>(&mut arg0.stored_amounts, &v0) = 0x2::balance::value<T0>(v2);
        } else {
            if (type_is_sui<T0>()) {
                abort 2
            };
            let v3 = MoomeStoragePoolRecord<T0>{
                coin_type             : v0,
                first_time_seen_ms    : 0x2::clock::timestamp_ms(arg2),
                first_time_seen_meta  : arg3,
                most_recent_seen_ms   : 0,
                most_recent_seen_meta : 0x1::vector::empty<u8>(),
                balance               : arg1,
            };
            0x2::bag::add<0x1::ascii::String, MoomeStoragePoolRecord<T0>>(&mut arg0.bag, v0, v3);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.stored_amounts, v0, 0x2::balance::value<T0>(&arg1));
        };
    }

    public fun stored_amount<T0>(arg0: &MoomeStoragePool) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (type_is_sui<T0>()) {
            return 0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
        };
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.bag, v0)) {
            return 0x2::balance::value<T0>(&0x2::bag::borrow<0x1::ascii::String, MoomeStoragePoolRecord<T0>>(&arg0.bag, v0).balance)
        };
        0
    }

    public fun stored_amounts(arg0: &MoomeStoragePool) : &0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        &arg0.stored_amounts
    }

    public fun type_is_sui<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()
    }

    public(friend) fun withdraw(arg0: &mut MoomeStoragePool, arg1: u64, arg2: u64) : MoomeStorageWithdrawPotato {
        let v0 = 0x2::object::id<MoomeStoragePool>(arg0);
        MoomeStorageWithdrawPotato{
            storage_pool_id   : v0,
            sui               : internal_get_sui(arg0, arg1, arg2),
            already_withdrawn : 0x1::vector::empty<vector<u8>>(),
            shares_count      : (arg1 as u256),
            all_shares_count  : (arg2 as u256),
        }
    }

    // decompiled from Move bytecode v6
}

