module 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool {
    struct PoolTicket has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        owner_address: address,
        ticket_price: u64,
    }

    struct WinerPoolTicket has copy, drop, store {
        ticket_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        owner_address: address,
        ticket_price: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        ticket_price: u64,
        interval: u64,
        max_cap: u64,
        start_time: u64,
        end_time: u64,
        sold_cap: u64,
        total_bonus: 0x2::balance::Balance<T0>,
        status: u8,
        tickets: 0x2::table_vec::TableVec<PoolTicket>,
        pool_fee_address: 0x1::option::Option<address>,
        pool_fee: u64,
        settle_fee: u64,
        fee_rate: u64,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        ticket_price: u64,
        interval: u64,
        max_cap: u64,
        start_time: u64,
        end_time: u64,
        receive_coin: 0x1::type_name::TypeName,
        pool_fee_address: 0x1::option::Option<address>,
        pool_fee: u64,
        settle_fee: u64,
        fee_rate: u64,
        sender: address,
    }

    struct BuyTicketEvent has copy, drop {
        ticket_ids: vector<0x2::object::ID>,
        pool_id: 0x2::object::ID,
        owner_address: address,
        ticket_price: u64,
        ticket_amount: u64,
    }

    struct SettlePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        winner_ticket: WinerPoolTicket,
        pool_fee_amount: u64,
        settle_fee_amount: u64,
        bonus: u64,
    }

    public(friend) fun buy_ticket<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_inprocess(0x2::clock::timestamp_ms(arg2), arg0.start_time, arg0.end_time, arg0.status), 100);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = (arg0.ticket_price as u64);
        assert!(v0 >= v1, 101);
        let v2 = v0 / v1;
        0x1::debug::print<u64>(&v2);
        assert!(v2 + arg0.sold_cap <= arg0.max_cap, 102);
        let v3 = 0x2::coin::split<T0>(&mut arg1, v2 * v1, arg3);
        0x1::debug::print<0x2::coin::Coin<T0>>(&v3);
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        arg0.sold_cap = arg0.sold_cap + v2;
        0x2::balance::join<T0>(&mut arg0.total_bonus, 0x2::coin::into_balance<T0>(v3));
        let v5 = 0;
        while (v5 < v2) {
            let v6 = PoolTicket{
                id            : 0x2::object::new(arg3),
                pool_id       : 0x2::object::uid_to_inner(&arg0.id),
                owner_address : 0x2::tx_context::sender(arg3),
                ticket_price  : arg0.ticket_price,
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::uid_to_inner(&v6.id));
            0x2::table_vec::push_back<PoolTicket>(&mut arg0.tickets, v6);
            v5 = v5 + 1;
        };
        let v7 = BuyTicketEvent{
            ticket_ids    : v4,
            pool_id       : 0x2::object::uid_to_inner(&arg0.id),
            owner_address : 0x2::tx_context::sender(arg3),
            ticket_price  : v1,
            ticket_amount : v2,
        };
        0x2::event::emit<BuyTicketEvent>(v7);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public fun copy_pool_ticket(arg0: &PoolTicket) : WinerPoolTicket {
        WinerPoolTicket{
            ticket_id     : 0x2::object::uid_to_inner(&arg0.id),
            pool_id       : arg0.pool_id,
            owner_address : arg0.owner_address,
            ticket_price  : arg0.ticket_price,
        }
    }

    public(friend) fun create_pool<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id               : 0x2::object::new(arg9),
            name             : arg0,
            ticket_price     : arg1,
            interval         : arg2,
            max_cap          : arg3,
            start_time       : arg4,
            end_time         : arg4 + arg2,
            sold_cap         : 0,
            total_bonus      : 0x2::balance::zero<T0>(),
            status           : 1,
            tickets          : 0x2::table_vec::empty<PoolTicket>(arg9),
            pool_fee_address : arg5,
            pool_fee         : arg6,
            settle_fee       : arg7,
            fee_rate         : arg8,
        };
        let v1 = CreatePoolEvent{
            pool_id          : 0x2::object::uid_to_inner(&v0.id),
            name             : v0.name,
            ticket_price     : v0.ticket_price,
            interval         : v0.interval,
            max_cap          : v0.max_cap,
            start_time       : v0.start_time,
            end_time         : v0.end_time,
            receive_coin     : 0x1::type_name::get<T0>(),
            pool_fee_address : v0.pool_fee_address,
            pool_fee         : v0.pool_fee,
            settle_fee       : v0.settle_fee,
            fee_rate         : v0.fee_rate,
            sender           : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<CreatePoolEvent>(v1);
        0x2::transfer::public_share_object<Pool<T0>>(v0);
    }

    public(friend) fun distribute_pool<T0>(arg0: &mut Pool<T0>, arg1: WinerPoolTicket, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<address>(&arg0.pool_fee_address)) {
            let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.total_bonus), arg2);
            let v1 = 0x2::coin::value<T0>(&v0);
            let v2 = (arg0.pool_fee as u64);
            let v3 = (arg0.settle_fee as u64);
            let v4 = (arg0.fee_rate as u64);
            let v5 = 0;
            let v6 = 0;
            if (v2 > 0) {
                let v7 = v1 * v2 / v4;
                v5 = v7;
                if (v7 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v7, arg2), *0x1::option::borrow<address>(&arg0.pool_fee_address));
                };
            };
            if (v3 > 0) {
                let v8 = v1 * v3 / v4;
                v6 = v8;
                if (v8 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v8, arg2), 0x2::tx_context::sender(arg2));
                };
            };
            let v9 = SettlePoolEvent{
                pool_id           : 0x2::object::uid_to_inner(&arg0.id),
                winner_ticket     : arg1,
                pool_fee_amount   : v5,
                settle_fee_amount : v6,
                bonus             : 0x2::coin::value<T0>(&v0),
            };
            0x1::debug::print<SettlePoolEvent>(&v9);
            0x2::event::emit<SettlePoolEvent>(v9);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1.owner_address);
        };
    }

    public fun get_end_time<T0>(arg0: &Pool<T0>) : u64 {
        arg0.end_time
    }

    public fun get_max_cap<T0>(arg0: &Pool<T0>) : u64 {
        arg0.max_cap
    }

    public fun get_sold_cap<T0>(arg0: &Pool<T0>) : u64 {
        arg0.sold_cap
    }

    public fun get_start_time<T0>(arg0: &Pool<T0>) : u64 {
        arg0.start_time
    }

    public fun get_tickets<T0>(arg0: &Pool<T0>) : &0x2::table_vec::TableVec<PoolTicket> {
        &arg0.tickets
    }

    fun is_inprocess(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : bool {
        if (arg3 == 0) {
            return false
        };
        if (arg0 < arg1) {
            return false
        };
        if (arg0 > arg2) {
            return false
        };
        true
    }

    public(friend) fun reset_pool<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        arg0.start_time = arg1;
        arg0.end_time = arg1 + arg0.interval;
        arg0.sold_cap = 0;
        if (!0x2::table_vec::is_empty<PoolTicket>(&arg0.tickets)) {
            while (!0x2::table_vec::is_empty<PoolTicket>(&arg0.tickets)) {
                let PoolTicket {
                    id            : v0,
                    pool_id       : _,
                    owner_address : _,
                    ticket_price  : _,
                } = 0x2::table_vec::pop_back<PoolTicket>(&mut arg0.tickets);
                0x2::object::delete(v0);
            };
        };
    }

    public(friend) fun update_pool_status<T0>(arg0: &mut Pool<T0>, arg1: u8) {
        arg0.status = arg1;
    }

    // decompiled from Move bytecode v6
}

