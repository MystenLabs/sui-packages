module 0x77d7f26ed1d80f0d75d0c71ce586482f7ab77960fd070851801b16b39fefc54f::eternal_position {
    struct Eternal has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Sheet has key {
        id: 0x2::object::UID,
        debts: 0x2::vec_map::VecMap<address, u64>,
        caps: 0x2::vec_map::VecMap<address, u64>,
    }

    fun assert_sender_is_whitelisted(arg0: &Sheet, arg1: &0x2::tx_context::TxContext) : address {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_map::contains<address, u64>(&arg0.debts, &v0) || !0x2::vec_map::contains<address, u64>(&arg0.debts, &v0)) {
            err_sender_is_not_whitelisted();
        };
        v0
    }

    fun borrow_buck(arg0: &mut Sheet, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        let v0 = assert_sender_is_whitelisted(arg0, arg3);
        *0x2::vec_map::get_mut<address, u64>(&mut arg0.debts, &v0) = debt(arg0, v0) + arg2;
        if (debt(arg0, v0) > cap(arg0, v0)) {
            err_exceed_debt_cap();
        };
        let v1 = Eternal{dummy_field: false};
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::destroy_output_carrier<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, Eternal>(v1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::output_buck<Eternal>(arg1, arg2))
    }

    public fun cap(arg0: &Sheet, arg1: address) : u64 {
        *0x2::vec_map::get<address, u64>(&arg0.caps, &arg1)
    }

    public fun debt(arg0: &Sheet, arg1: address) : u64 {
        *0x2::vec_map::get<address, u64>(&arg0.debts, &arg1)
    }

    fun err_exceed_debt_cap() {
        abort 2
    }

    fun err_sender_is_not_whitelisted() {
        abort 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Sheet{
            id    : 0x2::object::new(arg0),
            debts : 0x2::vec_map::empty<address, u64>(),
            caps  : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Sheet>(v1);
    }

    fun repay_buck(arg0: &mut Sheet, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: address, arg3: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>) {
        *0x2::vec_map::get_mut<address, u64>(&mut arg0.debts, &arg2) = debt(arg0, arg2) - 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&arg3);
        let v0 = Eternal{dummy_field: false};
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::input_buck<Eternal>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::input<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, Eternal>(v0, arg3));
    }

    public fun repay_debt(arg0: &mut Sheet, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: address, arg3: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>) {
        repay_buck(arg0, arg1, arg2, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg3));
    }

    public fun repay_position<T0>(arg0: &mut Sheet, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_buck(arg0, arg1, arg3, arg5);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::top_up_coll<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay_debt<T0>(arg1, v0, arg2, arg5), 0x2::tx_context::sender(arg5), arg4, arg2);
    }

    public fun repay_position_with_proof<T0, T1>(arg0: &mut Sheet, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &mut 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::Fountain<T0, T1>, arg6: 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, T1>, arg7: &mut 0x2::tx_context::TxContext) : (0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, T1>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::unstake<T0, T1>(arg5, arg2, arg6, arg7);
        let v2 = v0;
        repay_position_with_strap<T0>(arg0, arg1, arg2, arg3, arg4, &v2, arg7);
        (0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::stake<T0, T1>(arg5, arg1, arg2, v2, arg7), v1)
    }

    public fun repay_position_with_strap<T0>(arg0: &mut Sheet, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_buck(arg0, arg1, arg3, arg6);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::top_up_coll<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay_with_strap<T0>(arg1, arg5, v0, arg2), 0x2::tx_context::sender(arg6), arg4, arg2);
    }

    public fun set_cap(arg0: &AdminCap, arg1: &mut Sheet, arg2: address, arg3: u64) {
        *0x2::vec_map::get_mut<address, u64>(&mut arg1.caps, &arg2) = arg3;
    }

    public fun whitelist(arg0: &AdminCap, arg1: &mut Sheet, arg2: address, arg3: u64) {
        0x2::vec_map::insert<address, u64>(&mut arg1.debts, arg2, 0);
        0x2::vec_map::insert<address, u64>(&mut arg1.caps, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

