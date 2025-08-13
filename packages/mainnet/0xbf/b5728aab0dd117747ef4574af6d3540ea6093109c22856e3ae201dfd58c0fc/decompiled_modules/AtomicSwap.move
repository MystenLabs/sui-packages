module 0xbfb5728aab0dd117747ef4574af6d3540ea6093109c22856e3ae201dfd58c0fc::AtomicSwap {
    struct Order<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_fulfilled: bool,
        initiator: address,
        redeemer: address,
        amount: u64,
        initiated_at: u256,
        coins: 0x2::coin::Coin<T0>,
        timelock: u256,
    }

    struct OrdersRegistry<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Initiated has copy, drop {
        order_id: vector<u8>,
        secret_hash: vector<u8>,
        amount: u64,
        destination_data: vector<u8>,
    }

    struct Redeemed has copy, drop {
        order_id: vector<u8>,
        secret_hash: vector<u8>,
        secret: vector<u8>,
    }

    struct Refunded has copy, drop {
        order_id: vector<u8>,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
    }

    fun create_order_id(arg0: vector<u8>, arg1: address, arg2: address, arg3: u256, arg4: u64, arg5: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"0000000000000000000000000000000000000000000000000000000000000000");
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg5));
        0x1::hash::sha2_256(v0)
    }

    public fun create_orders_registry<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = OrdersRegistry<T0>{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x2::transfer::share_object<OrdersRegistry<T0>>(v0);
        let v2 = RegistryCreated{registry_id: v1};
        0x2::event::emit<RegistryCreated>(v2);
        v1
    }

    fun encode(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x2::hash::keccak256(&v0)
    }

    public fun initiate<T0>(arg0: &mut OrdersRegistry<T0>, arg1: address, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u256, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        safe_params(arg2, arg1, arg4, arg5, arg3, 0x2::tx_context::sender(arg9));
        assert!(0x2::coin::value<T0>(&arg7) == arg4, 1);
        initiate_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun initiate_<T0>(arg0: &mut OrdersRegistry<T0>, arg1: address, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u256, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = create_order_id(arg3, arg1, arg2, arg5, arg4, 0x2::object::uid_to_address(&arg0.id));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0), 7);
        let v1 = Order<T0>{
            id           : 0x2::object::new(arg9),
            is_fulfilled : false,
            initiator    : arg1,
            redeemer     : arg2,
            amount       : arg4,
            initiated_at : (0x2::clock::timestamp_ms(arg8) as u256),
            coins        : arg7,
            timelock     : arg5,
        };
        0x2::dynamic_field::add<vector<u8>, Order<T0>>(&mut arg0.id, v0, v1);
        let v2 = Initiated{
            order_id         : v0,
            secret_hash      : arg3,
            amount           : arg4,
            destination_data : arg6,
        };
        0x2::event::emit<Initiated>(v2);
    }

    public fun instant_refund<T0>(arg0: &mut OrdersRegistry<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Order<T0>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v0.redeemer, 16);
        assert!(!v0.is_fulfilled, 14);
        v0.is_fulfilled = true;
        let v1 = Refunded{order_id: arg1};
        0x2::event::emit<Refunded>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coins, v0.amount, arg2), v0.initiator);
    }

    public fun instant_refund_digest(arg0: vector<u8>, arg1: address) : vector<u8> {
        encode(x"bc059cfbece4b82f519bdf7f4dea736fd886109806029923b32b99b4a698985a", arg0, 0x2::address::to_bytes(arg1))
    }

    public fun redeem<T0>(arg0: &mut OrdersRegistry<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Order<T0>>(&mut arg0.id, arg1);
        assert!(!v0.is_fulfilled, 14);
        let v1 = 0x1::hash::sha2_256(arg2);
        assert!(create_order_id(v1, v0.initiator, v0.redeemer, v0.timelock, v0.amount, 0x2::object::uid_to_address(&arg0.id)) == arg1, 8);
        v0.is_fulfilled = true;
        let v2 = Redeemed{
            order_id    : arg1,
            secret_hash : v1,
            secret      : arg2,
        };
        0x2::event::emit<Redeemed>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coins, v0.amount, arg3), v0.redeemer);
    }

    public fun refund<T0>(arg0: &mut OrdersRegistry<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Order<T0>>(&mut arg0.id, arg1);
        assert!(!v0.is_fulfilled, 14);
        assert!(v0.initiated_at + v0.timelock < (0x2::clock::timestamp_ms(arg2) as u256), 2);
        v0.is_fulfilled = true;
        let v1 = Refunded{order_id: arg1};
        0x2::event::emit<Refunded>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coins, v0.amount, arg3), v0.initiator);
    }

    fun safe_params(arg0: address, arg1: address, arg2: u64, arg3: u256, arg4: vector<u8>, arg5: address) {
        assert!(arg1 != 0x2::address::from_bytes(x"0000000000000000000000000000000000000000000000000000000000000000"), 3);
        assert!(arg0 != 0x2::address::from_bytes(x"0000000000000000000000000000000000000000000000000000000000000000"), 4);
        assert!(arg1 != arg0, 11);
        assert!(arg5 != arg0, 15);
        assert!(arg2 != 0, 10);
        assert!(arg3 > 0 && arg3 < 604800001, 9);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13);
    }

    // decompiled from Move bytecode v6
}

