module 0x2::funds_accumulator {
    struct Withdrawal<phantom T0: store> has drop {
        owner: address,
        limit: u256,
    }

    public(friend) fun add_impl<T0: store>(arg0: T0, arg1: address) {
        add_to_accumulator_address<T0>(0x2::accumulator::accumulator_address<T0>(arg1), arg1, arg0);
    }

    native fun add_to_accumulator_address<T0: store>(arg0: address, arg1: address, arg2: T0);
    public(friend) fun create_withdrawal<T0: store>(arg0: address, arg1: u256) : Withdrawal<T0> {
        Withdrawal<T0>{
            owner : arg0,
            limit : arg1,
        }
    }

    public(friend) fun redeem<T0: store>(arg0: Withdrawal<T0>, arg1: 0x1::internal::Permit<T0>) : T0 {
        let Withdrawal {
            owner : v0,
            limit : v1,
        } = arg0;
        withdraw_impl<T0>(v0, v1)
    }

    native fun withdraw_from_accumulator_address<T0: store>(arg0: address, arg1: address, arg2: u256) : T0;
    public(friend) fun withdraw_from_object<T0: store>(arg0: &mut 0x2::object::UID, arg1: u256) : Withdrawal<T0> {
        assert!(0x2::protocol_config::is_feature_enabled(b"enable_object_funds_withdraw"), 13835902875349614598);
        Withdrawal<T0>{
            owner : 0x2::object::uid_to_address(arg0),
            limit : arg1,
        }
    }

    fun withdraw_impl<T0: store>(arg0: address, arg1: u256) : T0 {
        withdraw_from_accumulator_address<T0>(0x2::accumulator::accumulator_address<T0>(arg0), arg0, arg1)
    }

    public fun withdrawal_join<T0: store>(arg0: &mut Withdrawal<T0>, arg1: Withdrawal<T0>) {
        assert!(arg0.owner == arg1.owner, 13835621305883492356);
        assert!(115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0.limit >= arg1.limit, 0);
        arg0.limit = arg0.limit + arg1.limit;
    }

    public fun withdrawal_limit<T0: store>(arg0: &Withdrawal<T0>) : u256 {
        arg0.limit
    }

    public fun withdrawal_owner<T0: store>(arg0: &Withdrawal<T0>) : address {
        arg0.owner
    }

    public fun withdrawal_split<T0: store>(arg0: &mut Withdrawal<T0>, arg1: u256) : Withdrawal<T0> {
        assert!(arg0.limit >= arg1, 13835339792251944962);
        arg0.limit = arg0.limit - arg1;
        Withdrawal<T0>{
            owner : arg0.owner,
            limit : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

