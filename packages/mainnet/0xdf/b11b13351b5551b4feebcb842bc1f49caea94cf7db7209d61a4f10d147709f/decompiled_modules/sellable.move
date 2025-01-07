module 0xdfb11b13351b5551b4feebcb842bc1f49caea94cf7db7209d61a4f10d147709f::sellable {
    struct CredenzaSellableConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        price_fiat: u64,
        price_sui: u64,
        price_coin: u64,
        coin: 0x2::bag::Bag,
    }

    struct CredenzaSellableConfigCreatedEvent<phantom T0> has copy, drop {
        id: 0x2::object::ID,
    }

    public fun accept_payment_coin<T0, T1>(arg0: &CredenzaSellableConfig<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(arg0.price_coin > 0, 10001);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0), 10001);
        assert!(arg0.price_coin <= 0x2::coin::value<T1>(&arg1), 10002);
        if (arg0.price_coin < 0x2::coin::value<T1>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, 0x2::coin::value<T1>(&arg1) - arg0.price_coin, arg2), 0x2::tx_context::sender(arg2));
        };
        0x2::bag::borrow<0x2::object::ID, 0x2::coin::Coin<T1>>(&arg0.coin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, arg0.owner);
    }

    public fun create_config<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (T0, CredenzaSellableConfig<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 10004);
        let v0 = CredenzaSellableConfig<T0>{
            id         : 0x2::object::new(arg1),
            owner      : 0x2::tx_context::sender(arg1),
            price_fiat : 0,
            price_sui  : 0,
            price_coin : 0,
            coin       : 0x2::bag::new(arg1),
        };
        let v1 = CredenzaSellableConfigCreatedEvent<T0>{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<CredenzaSellableConfigCreatedEvent<T0>>(v1);
        (arg0, v0)
    }

    public fun price_coin<T0>(arg0: &CredenzaSellableConfig<T0>) : u64 {
        arg0.price_coin
    }

    public fun price_sui<T0>(arg0: &CredenzaSellableConfig<T0>) : u64 {
        arg0.price_sui
    }

    public fun set_owner<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 10003);
        arg0.owner = arg1;
    }

    public fun set_price_coin<T0, T1>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 10003);
        arg0.price_coin = arg1;
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        if (0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0)) {
            0x2::coin::destroy_zero<T0>(0x2::bag::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0));
        };
        0x2::bag::add<0x2::object::ID, 0x2::coin::Coin<T1>>(&mut arg0.coin, v0, 0x2::coin::zero<T1>(arg2));
    }

    public fun set_price_fiat<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 10003);
        arg0.price_fiat = arg1;
    }

    public fun set_price_sui<T0>(arg0: &mut CredenzaSellableConfig<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 10003);
        arg0.price_sui = arg1;
    }

    // decompiled from Move bytecode v6
}

