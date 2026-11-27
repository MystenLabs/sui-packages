module 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::accounting {
    struct AccountingKey has copy, drop, store {
        executor: address,
        asset: 0x1::type_name::TypeName,
    }

    struct Position has store {
        magnitude: u128,
        negative: bool,
    }

    struct Accounting has store {
        positions: 0x2::table::Table<AccountingKey, Position>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Accounting {
        Accounting{positions: 0x2::table::new<AccountingKey, Position>(arg0)}
    }

    fun add_signed(arg0: bool, arg1: u128, arg2: bool, arg3: u128) : (bool, u128) {
        if (arg0 == arg2) {
            return (arg0, arg1 + arg3)
        };
        if (arg1 == arg3) {
            (false, 0)
        } else if (arg1 > arg3) {
            (arg0, arg1 - arg3)
        } else {
            (arg2, arg3 - arg1)
        }
    }

    public(friend) fun apply(arg0: &mut Accounting, arg1: address, arg2: 0x1::type_name::TypeName, arg3: bool, arg4: u128) {
        if (arg4 == 0) {
            return
        };
        let v0 = AccountingKey{
            executor : arg1,
            asset    : arg2,
        };
        if (!0x2::table::contains<AccountingKey, Position>(&arg0.positions, v0)) {
            let v1 = Position{
                magnitude : 0,
                negative  : false,
            };
            0x2::table::add<AccountingKey, Position>(&mut arg0.positions, v0, v1);
        };
        let v2 = 0x2::table::borrow_mut<AccountingKey, Position>(&mut arg0.positions, v0);
        let (v3, v4) = add_signed(v2.negative, v2.magnitude, arg3, arg4);
        v2.negative = v3;
        v2.magnitude = v4;
        0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::events::emit_accounting_updated(arg1, arg2, arg3, arg4, v3, v4);
    }

    public fun position_of<T0>(arg0: &Accounting, arg1: address) : (bool, u128) {
        let v0 = AccountingKey{
            executor : arg1,
            asset    : 0x1::type_name::with_defining_ids<T0>(),
        };
        if (0x2::table::contains<AccountingKey, Position>(&arg0.positions, v0)) {
            let v3 = 0x2::table::borrow<AccountingKey, Position>(&arg0.positions, v0);
            (v3.negative, v3.magnitude)
        } else {
            (false, 0)
        }
    }

    // decompiled from Move bytecode v7
}

