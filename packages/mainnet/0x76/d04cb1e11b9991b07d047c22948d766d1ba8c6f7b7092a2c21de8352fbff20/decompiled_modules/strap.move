module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap {
    struct STRAP has drop {
        dummy_field: bool,
    }

    struct BottleStrap<phantom T0> has store, key {
        id: 0x2::object::UID,
        fee_rate: 0x1::option::Option<u64>,
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : BottleStrap<T0> {
        BottleStrap<T0>{
            id       : 0x2::object::new(arg0),
            fee_rate : 0x1::option::none<u64>(),
        }
    }

    public(friend) fun destroy<T0>(arg0: BottleStrap<T0>) {
        let BottleStrap {
            id       : v0,
            fee_rate : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun fee_rate<T0>(arg0: &BottleStrap<T0>) : 0x1::option::Option<u64> {
        arg0.fee_rate
    }

    public fun get_address<T0>(arg0: &BottleStrap<T0>) : address {
        0x2::object::id_to_address(0x2::object::borrow_id<BottleStrap<T0>>(arg0))
    }

    fun init(arg0: STRAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<STRAP>(arg0, arg1);
    }

    public(friend) fun new_with_fee_rate<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : BottleStrap<T0> {
        BottleStrap<T0>{
            id       : 0x2::object::new(arg1),
            fee_rate : 0x1::option::some<u64>(arg0),
        }
    }

    // decompiled from Move bytecode v6
}

