module 0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::order {
    struct Order<phantom T0> has key {
        id: 0x2::object::UID,
        sender: address,
        amount: u64,
        rate: u64,
        institution_code: vector<u8>,
        message_hash: 0x1::string::String,
        sender_fee: u64,
        sender_fee_recipient: address,
        protocol_fee: u64,
        refund_address: address,
        escrow: 0x2::balance::Balance<T0>,
        settled_lp_amount: u64,
        status: u8,
        created_at_ms: u64,
    }

    public fun sender<T0>(arg0: &Order<T0>) : address {
        arg0.sender
    }

    public fun amount<T0>(arg0: &Order<T0>) : u64 {
        arg0.amount
    }

    public fun create_order<T0>(arg0: &0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::Gateway, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u8>, arg4: 0x1::string::String, arg5: u64, arg6: address, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::is_paused(arg0), 1);
        assert!(0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::is_coin_supported<T0>(arg0), 2);
        assert!(arg7 != @0x0, 4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = v0 * 0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::protocol_fee_bps(arg0) / 0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::max_bps(arg0);
        assert!(arg5 + v1 < v0, 5);
        let v2 = Order<T0>{
            id                   : 0x2::object::new(arg9),
            sender               : 0x2::tx_context::sender(arg9),
            amount               : v0,
            rate                 : arg2,
            institution_code     : arg3,
            message_hash         : arg4,
            sender_fee           : arg5,
            sender_fee_recipient : arg6,
            protocol_fee         : v1,
            refund_address       : arg7,
            escrow               : 0x2::coin::into_balance<T0>(arg1),
            settled_lp_amount    : 0,
            status               : 0,
            created_at_ms        : 0x2::clock::timestamp_ms(arg8),
        };
        0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::events::emit_order_created(0x2::object::id<Order<T0>>(&v2), v2.sender, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), v0, v1, arg2, v2.institution_code, v2.message_hash);
        0x2::transfer::share_object<Order<T0>>(v2);
    }

    public fun protocol_fee<T0>(arg0: &Order<T0>) : u64 {
        arg0.protocol_fee
    }

    public fun rate<T0>(arg0: &Order<T0>) : u64 {
        arg0.rate
    }

    public fun refund_order<T0>(arg0: &0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::AggregatorCap, arg1: &0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::Gateway, arg2: &mut Order<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 6);
        let v0 = 0x2::balance::value<T0>(&arg2.escrow);
        assert!(arg3 <= v0, 9);
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.escrow, arg3), arg4), 0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::treasury(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.escrow), arg4), arg2.refund_address);
        arg2.status = 2;
        0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::events::emit_order_refunded(arg3, 0x2::object::id<Order<T0>>(arg2), v0 - arg3);
    }

    public fun remaining<T0>(arg0: &Order<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun sender_fee<T0>(arg0: &Order<T0>) : u64 {
        arg0.sender_fee
    }

    public fun settle_order<T0>(arg0: &0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::AggregatorCap, arg1: &0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::Gateway, arg2: &mut Order<T0>, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 6);
        assert!(arg4 <= 0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::max_bps(arg1), 7);
        let v0 = arg2.amount - arg2.protocol_fee - arg2.sender_fee;
        let v1 = v0 * arg4 / 0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::max_bps(arg1);
        assert!(arg2.settled_lp_amount + v1 <= v0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.escrow, v1), arg6), arg3);
        arg2.settled_lp_amount = arg2.settled_lp_amount + v1;
        0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::events::emit_order_settled(arg5, 0x2::object::id<Order<T0>>(arg2), arg3, arg4, v1);
        if (arg2.settled_lp_amount == v0) {
            if (arg2.sender_fee > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.escrow, arg2.sender_fee), arg6), arg2.sender_fee_recipient);
                0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::events::emit_sender_fee_transferred(arg2.sender_fee_recipient, arg2.sender_fee);
            };
            if (arg2.protocol_fee > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.escrow, arg2.protocol_fee), arg6), 0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::treasury(arg1));
            };
            arg2.status = 1;
        };
    }

    public fun settled_lp_amount<T0>(arg0: &Order<T0>) : u64 {
        arg0.settled_lp_amount
    }

    public fun status<T0>(arg0: &Order<T0>) : u8 {
        arg0.status
    }

    public fun status_pending() : u8 {
        0
    }

    public fun status_refunded() : u8 {
        2
    }

    public fun status_settled() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

