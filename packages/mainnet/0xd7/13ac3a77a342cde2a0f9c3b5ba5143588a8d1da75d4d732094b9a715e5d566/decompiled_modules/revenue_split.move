module 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split {
    struct RevenueSplit has store, key {
        id: 0x2::object::UID,
        owner: address,
        recipients: vector<address>,
        shares: vector<u64>,
    }

    struct PendingRevenue<phantom T0> has store, key {
        id: 0x2::object::UID,
        split_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        total_received: u64,
        total_distributed: u64,
    }

    struct RevenueSplitCap has store, key {
        id: 0x2::object::UID,
        split_id: 0x2::object::ID,
    }

    public fun calculate_distribution(arg0: &RevenueSplit, arg1: u64) : vector<u64> {
        let v0 = 0x1::vector::length<address>(&arg0.recipients);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = if (v3 == v0 - 1) {
                arg1 - v2
            } else {
                arg1 * *0x1::vector::borrow<u64>(&arg0.shares, v3) / 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::basis_points_100_percent()
            };
            0x1::vector::push_back<u64>(&mut v1, v4);
            v2 = v2 + v4;
            v3 = v3 + 1;
        };
        v1
    }

    public fun cap_split_id(arg0: &RevenueSplitCap) : 0x2::object::ID {
        arg0.split_id
    }

    entry fun create_and_share(arg0: vector<address>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_split(arg0, arg1, arg2);
        0x2::transfer::share_object<RevenueSplit>(v0);
        0x2::transfer::transfer<RevenueSplitCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun create_pending_revenue<T0>(arg0: &RevenueSplit, arg1: &RevenueSplitCap, arg2: &mut 0x2::tx_context::TxContext) : PendingRevenue<T0> {
        assert!(arg1.split_id == 0x2::object::id<RevenueSplit>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_owner());
        PendingRevenue<T0>{
            id                : 0x2::object::new(arg2),
            split_id          : 0x2::object::id<RevenueSplit>(arg0),
            balance           : 0x2::balance::zero<T0>(),
            total_received    : 0,
            total_distributed : 0,
        }
    }

    public fun create_split(arg0: vector<address>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : (RevenueSplit, RevenueSplitCap) {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::zero_recipients());
        assert!(0x1::vector::length<u64>(&arg1) == v0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::length_mismatch());
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg1, v2);
            v2 = v2 + 1;
        };
        assert!(v1 == 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::basis_points_100_percent(), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_shares());
        let v3 = RevenueSplit{
            id         : 0x2::object::new(arg2),
            owner      : 0x2::tx_context::sender(arg2),
            recipients : arg0,
            shares     : arg1,
        };
        let v4 = 0x2::object::id<RevenueSplit>(&v3);
        let v5 = RevenueSplitCap{
            id       : 0x2::object::new(arg2),
            split_id : v4,
        };
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_revenue_split_created(v4, 0x2::tx_context::sender(arg2), v0, 0x2::tx_context::epoch_timestamp_ms(arg2));
        (v3, v5)
    }

    public fun destroy_pending_revenue<T0>(arg0: PendingRevenue<T0>) {
        let PendingRevenue {
            id                : v0,
            split_id          : _,
            balance           : v2,
            total_received    : _,
            total_distributed : _,
        } = arg0;
        let v5 = v2;
        assert!(0x2::balance::value<T0>(&v5) == 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::no_revenue());
        0x2::balance::destroy_zero<T0>(v5);
        0x2::object::delete(v0);
    }

    public fun destroy_split(arg0: RevenueSplit, arg1: RevenueSplitCap) {
        let RevenueSplit {
            id         : v0,
            owner      : _,
            recipients : _,
            shares     : _,
        } = arg0;
        let RevenueSplitCap {
            id       : v4,
            split_id : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::object::delete(v4);
    }

    public fun distribute<T0>(arg0: &RevenueSplit, arg1: &mut PendingRevenue<T0>, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(arg1.split_id == 0x2::object::id<RevenueSplit>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_owner());
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        assert!(v0 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::no_revenue());
        let v1 = 0x1::vector::length<address>(&arg0.recipients);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v1) {
            let v5 = if (v4 == v1 - 1) {
                v0 - v3
            } else {
                v0 * *0x1::vector::borrow<u64>(&arg0.shares, v4) / 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::basis_points_100_percent()
            };
            if (v5 > 0) {
                0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v5), arg2));
                v3 = v3 + v5;
            } else {
                0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::zero<T0>(arg2));
            };
            v4 = v4 + 1;
        };
        arg1.total_distributed = arg1.total_distributed + v3;
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_revenue_split_distributed(0x2::object::id<RevenueSplit>(arg0), v3, 0x2::tx_context::epoch_timestamp_ms(arg2));
        v2
    }

    entry fun distribute_to_recipients<T0>(arg0: &RevenueSplit, arg1: &mut PendingRevenue<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = distribute<T0>(arg0, arg1, arg2);
        let v1 = &arg0.recipients;
        let v2 = 0x1::vector::length<0x2::coin::Coin<T0>>(&v0);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v0);
            if (0x2::coin::value<T0>(&v4) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, *0x1::vector::borrow<address>(v1, v2 - 1 - v3));
            } else {
                0x2::coin::destroy_zero<T0>(v4);
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(v0);
    }

    public fun get_recipient_share(arg0: &RevenueSplit, arg1: u64) : (address, u64) {
        (*0x1::vector::borrow<address>(&arg0.recipients, arg1), *0x1::vector::borrow<u64>(&arg0.shares, arg1))
    }

    public fun pending_balance<T0>(arg0: &PendingRevenue<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun pending_total_distributed<T0>(arg0: &PendingRevenue<T0>) : u64 {
        arg0.total_distributed
    }

    public fun pending_total_received<T0>(arg0: &PendingRevenue<T0>) : u64 {
        arg0.total_received
    }

    public fun receive<T0>(arg0: &mut PendingRevenue<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_received = arg0.total_received + v0;
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_revenue_split_received(arg0.split_id, v0, 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    entry fun receive_and_distribute<T0>(arg0: &RevenueSplit, arg1: &mut PendingRevenue<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        receive<T0>(arg1, arg2, arg3);
        distribute_to_recipients<T0>(arg0, arg1, arg3);
    }

    public fun split_num_recipients(arg0: &RevenueSplit) : u64 {
        0x1::vector::length<address>(&arg0.recipients)
    }

    public fun split_owner(arg0: &RevenueSplit) : address {
        arg0.owner
    }

    public fun split_recipients(arg0: &RevenueSplit) : &vector<address> {
        &arg0.recipients
    }

    public fun split_shares(arg0: &RevenueSplit) : &vector<u64> {
        &arg0.shares
    }

    public fun transfer_ownership(arg0: &mut RevenueSplit, arg1: &RevenueSplitCap, arg2: address) {
        assert!(arg1.split_id == 0x2::object::id<RevenueSplit>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_owner());
        arg0.owner = arg2;
    }

    public fun update_recipients(arg0: &mut RevenueSplit, arg1: &RevenueSplitCap, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.split_id == 0x2::object::id<RevenueSplit>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_owner());
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::zero_recipients());
        assert!(0x1::vector::length<u64>(&arg3) == v0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::length_mismatch());
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg3, v2);
            v2 = v2 + 1;
        };
        assert!(v1 == 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::basis_points_100_percent(), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_shares());
        arg0.recipients = arg2;
        arg0.shares = arg3;
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_revenue_split_recipients_updated(0x2::object::id<RevenueSplit>(arg0), v0, 0x2::tx_context::epoch_timestamp_ms(arg4));
    }

    // decompiled from Move bytecode v6
}

