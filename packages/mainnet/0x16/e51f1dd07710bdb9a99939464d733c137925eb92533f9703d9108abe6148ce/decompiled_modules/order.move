module 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order {
    struct Order has drop, store {
        order_id: u64,
        client_order_id: u64,
        maker_asset: 0x1::type_name::TypeName,
        taker_asset: 0x1::type_name::TypeName,
        maker: address,
        recipient: address,
        allowed_taker: 0x1::option::Option<address>,
        making_amount: u64,
        remaining_amount: u64,
        original_taking_amount: u64,
        taking_amount: u64,
        expires_timestamp: u64,
        allowed_partial_fills: bool,
    }

    public fun client_order_id(arg0: &Order) : u64 {
        arg0.client_order_id
    }

    public fun clone(arg0: &Order) : Order {
        Order{
            order_id               : arg0.order_id,
            client_order_id        : arg0.client_order_id,
            maker_asset            : arg0.maker_asset,
            taker_asset            : arg0.taker_asset,
            maker                  : arg0.maker,
            recipient              : arg0.recipient,
            allowed_taker          : arg0.allowed_taker,
            making_amount          : arg0.making_amount,
            remaining_amount       : arg0.remaining_amount,
            original_taking_amount : arg0.original_taking_amount,
            taking_amount          : arg0.taking_amount,
            expires_timestamp      : arg0.expires_timestamp,
            allowed_partial_fills  : arg0.allowed_partial_fills,
        }
    }

    public(friend) fun destroy(arg0: Order) {
        let Order {
            order_id               : _,
            client_order_id        : _,
            maker_asset            : _,
            taker_asset            : _,
            maker                  : _,
            recipient              : _,
            allowed_taker          : _,
            making_amount          : _,
            remaining_amount       : _,
            original_taking_amount : _,
            taking_amount          : _,
            expires_timestamp      : _,
            allowed_partial_fills  : _,
        } = arg0;
    }

    public(friend) fun fill(arg0: &mut Order, arg1: u64) : u64 {
        arg0.taking_amount = arg0.taking_amount + arg1;
        arg0.taking_amount
    }

    public fun is_allowed_partial_fills(arg0: &Order) : bool {
        arg0.allowed_partial_fills
    }

    public fun is_allowed_taker(arg0: &Order, arg1: address) : bool {
        arg0.maker != arg1 && (0x1::option::is_none<address>(&arg0.allowed_taker) || 0x1::option::borrow<address>(&arg0.allowed_taker) == &arg1)
    }

    public fun is_expired(arg0: &Order, arg1: &0x2::clock::Clock) : bool {
        arg0.expires_timestamp != 0 && arg0.expires_timestamp < 0x2::clock::timestamp_ms(arg1)
    }

    public fun maker(arg0: &Order) : address {
        arg0.maker
    }

    public fun maker_asset(arg0: &Order) : &0x1::type_name::TypeName {
        &arg0.maker_asset
    }

    public fun making_amount(arg0: &Order) : u64 {
        arg0.making_amount
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u64, arg2: address, arg3: address, arg4: 0x1::option::Option<address>, arg5: u64, arg6: u64, arg7: u64, arg8: bool) : Order {
        Order{
            order_id               : arg0,
            client_order_id        : arg1,
            maker_asset            : 0x1::type_name::get<T0>(),
            taker_asset            : 0x1::type_name::get<T1>(),
            maker                  : arg2,
            recipient              : arg3,
            allowed_taker          : arg4,
            making_amount          : arg5,
            remaining_amount       : arg5,
            original_taking_amount : arg6,
            taking_amount          : 0,
            expires_timestamp      : arg7,
            allowed_partial_fills  : arg8,
        }
    }

    public fun order_id(arg0: &Order) : u64 {
        arg0.order_id
    }

    public fun original_taking_amount(arg0: &Order) : u64 {
        arg0.original_taking_amount
    }

    public fun recipient(arg0: &Order) : address {
        arg0.recipient
    }

    public fun remaining_amount(arg0: &Order) : u64 {
        arg0.remaining_amount
    }

    public(friend) fun remains(arg0: &mut Order, arg1: u64) : u64 {
        arg0.remaining_amount = arg0.remaining_amount - arg1;
        arg0.remaining_amount
    }

    public fun taker_asset(arg0: &Order) : &0x1::type_name::TypeName {
        &arg0.taker_asset
    }

    public fun taking_amount(arg0: &Order) : u64 {
        arg0.taking_amount
    }

    // decompiled from Move bytecode v6
}

