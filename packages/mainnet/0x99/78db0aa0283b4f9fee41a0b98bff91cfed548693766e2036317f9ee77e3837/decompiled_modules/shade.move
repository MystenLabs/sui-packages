module 0xfcd0b2b4f69758cd3ed0d35a55335417cac6304017c3c5d9a5aaff75c367aaff::shade {
    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        deposit: u64,
    }

    struct OrderExecuted has copy, drop {
        order_id: 0x2::object::ID,
        executor: address,
        domain: vector<u8>,
        target_address: address,
        deposit: u64,
    }

    struct OrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        deposit: u64,
    }

    struct OrderToppedUp has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        added: u64,
        new_total: u64,
    }

    struct ShadeOrder has key {
        id: 0x2::object::UID,
        owner: address,
        deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        commitment: vector<u8>,
        sealed_payload: vector<u8>,
    }

    struct StableShadeOrder<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        deposit: 0x2::balance::Balance<T0>,
        commitment: vector<u8>,
        sealed_payload: vector<u8>,
    }

    struct StableOrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        deposit: u64,
    }

    struct StableOrderExecuted has copy, drop {
        order_id: 0x2::object::ID,
        executor: address,
        domain: vector<u8>,
        target_address: address,
        deposit: u64,
    }

    struct StableOrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        deposit: u64,
    }

    entry fun cancel(arg0: ShadeOrder, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = OrderCancelled{
            order_id : 0x2::object::id<ShadeOrder>(&arg0),
            owner    : arg0.owner,
            deposit  : 0x2::balance::value<0x2::sui::SUI>(&arg0.deposit),
        };
        0x2::event::emit<OrderCancelled>(v0);
        let ShadeOrder {
            id             : v1,
            owner          : _,
            deposit        : v3,
            commitment     : _,
            sealed_payload : _,
        } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun cancel_refund(arg0: &mut ShadeOrder, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.deposit);
        assert!(v0 > 0, 4);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.deposit, v0, arg1), arg0.owner);
        };
        let v1 = OrderCancelled{
            order_id : 0x2::object::id<ShadeOrder>(arg0),
            owner    : arg0.owner,
            deposit  : v0,
        };
        0x2::event::emit<OrderCancelled>(v1);
    }

    entry fun cancel_refund_stable<T0>(arg0: &mut StableShadeOrder<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = 0x2::balance::value<T0>(&arg0.deposit);
        assert!(v0 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.deposit, v0, arg1), arg0.owner);
        let v1 = StableOrderCancelled{
            order_id : 0x2::object::id<StableShadeOrder<T0>>(arg0),
            owner    : arg0.owner,
            deposit  : v0,
        };
        0x2::event::emit<StableOrderCancelled>(v1);
    }

    entry fun cancel_stable<T0>(arg0: StableShadeOrder<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = StableOrderCancelled{
            order_id : 0x2::object::id<StableShadeOrder<T0>>(&arg0),
            owner    : arg0.owner,
            deposit  : 0x2::balance::value<T0>(&arg0.deposit),
        };
        0x2::event::emit<StableOrderCancelled>(v0);
        let StableShadeOrder {
            id             : v1,
            owner          : _,
            deposit        : v3,
            commitment     : _,
            sealed_payload : _,
        } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun commitment(arg0: &ShadeOrder) : vector<u8> {
        arg0.commitment
    }

    entry fun create(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 3);
        let v0 = ShadeOrder{
            id             : 0x2::object::new(arg3),
            owner          : 0x2::tx_context::sender(arg3),
            deposit        : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            commitment     : arg1,
            sealed_payload : arg2,
        };
        let v1 = OrderCreated{
            order_id : 0x2::object::id<ShadeOrder>(&v0),
            owner    : v0.owner,
            deposit  : 0x2::balance::value<0x2::sui::SUI>(&v0.deposit),
        };
        0x2::event::emit<OrderCreated>(v1);
        0x2::transfer::share_object<ShadeOrder>(v0);
    }

    entry fun create_stable<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 3);
        let v0 = StableShadeOrder<T0>{
            id             : 0x2::object::new(arg3),
            owner          : 0x2::tx_context::sender(arg3),
            deposit        : 0x2::coin::into_balance<T0>(arg0),
            commitment     : arg1,
            sealed_payload : arg2,
        };
        let v1 = StableOrderCreated{
            order_id : 0x2::object::id<StableShadeOrder<T0>>(&v0),
            owner    : v0.owner,
            deposit  : 0x2::balance::value<T0>(&v0.deposit),
        };
        0x2::event::emit<StableOrderCreated>(v1);
        0x2::transfer::share_object<StableShadeOrder<T0>>(v0);
    }

    public fun deposit_value(arg0: &ShadeOrder) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.deposit)
    }

    public fun execute(arg0: ShadeOrder, arg1: vector<u8>, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::clock::timestamp_ms(arg5) >= arg2, 1);
        0x1::vector::append<u8>(&mut arg1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut arg1, 0x2::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut arg1, arg4);
        assert!(0x2::hash::keccak256(&arg1) == arg0.commitment, 2);
        let v0 = OrderExecuted{
            order_id       : 0x2::object::id<ShadeOrder>(&arg0),
            executor       : 0x2::tx_context::sender(arg6),
            domain         : arg1,
            target_address : arg3,
            deposit        : 0x2::balance::value<0x2::sui::SUI>(&arg0.deposit),
        };
        0x2::event::emit<OrderExecuted>(v0);
        let ShadeOrder {
            id             : v1,
            owner          : _,
            deposit        : v3,
            commitment     : _,
            sealed_payload : _,
        } = arg0;
        0x2::object::delete(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg6)
    }

    public fun execute_stable<T0>(arg0: StableShadeOrder<T0>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: vector<u8>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::clock::timestamp_ms(arg6) >= arg2, 1);
        0x1::vector::append<u8>(&mut arg1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut arg1, 0x2::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut arg1, arg4);
        assert!(0x2::hash::keccak256(&arg1) == arg0.commitment, 2);
        let v0 = 0x2::balance::value<T0>(&arg0.deposit);
        let v1 = StableOrderExecuted{
            order_id       : 0x2::object::id<StableShadeOrder<T0>>(&arg0),
            executor       : 0x2::tx_context::sender(arg7),
            domain         : arg1,
            target_address : arg3,
            deposit        : v0,
        };
        0x2::event::emit<StableOrderExecuted>(v1);
        let StableShadeOrder {
            id             : v2,
            owner          : _,
            deposit        : v4,
            commitment     : _,
            sealed_payload : _,
        } = arg0;
        0x2::object::delete(v2);
        let v7 = v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v0 / 10), arg7), arg5);
        0x2::coin::from_balance<T0>(v7, arg7)
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun namespace(arg0: &ShadeOrder) : vector<u8> {
        arg0.commitment
    }

    public fun owner(arg0: &ShadeOrder) : address {
        arg0.owner
    }

    entry fun reap_cancelled(arg0: ShadeOrder, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.deposit) == 0, 5);
        let ShadeOrder {
            id             : v0,
            owner          : _,
            deposit        : v2,
            commitment     : _,
            sealed_payload : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg1));
    }

    entry fun reap_cancelled_stable<T0>(arg0: StableShadeOrder<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.deposit) == 0, 5);
        let StableShadeOrder {
            id             : v0,
            owner          : _,
            deposit        : v2,
            commitment     : _,
            sealed_payload : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::destroy_zero<T0>(0x2::coin::from_balance<T0>(v2, arg1));
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &ShadeOrder, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        assert!(is_prefix(namespace(arg1), arg0), 0);
    }

    public fun sealed_payload(arg0: &ShadeOrder) : vector<u8> {
        arg0.sealed_payload
    }

    entry fun top_up(arg0: &mut ShadeOrder, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.deposit, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = OrderToppedUp{
            order_id  : 0x2::object::id<ShadeOrder>(arg0),
            owner     : arg0.owner,
            added     : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_total : 0x2::balance::value<0x2::sui::SUI>(&arg0.deposit),
        };
        0x2::event::emit<OrderToppedUp>(v0);
    }

    // decompiled from Move bytecode v7
}

