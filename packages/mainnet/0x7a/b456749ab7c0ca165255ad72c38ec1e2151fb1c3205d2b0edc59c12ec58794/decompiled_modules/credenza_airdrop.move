module 0x7ab456749ab7c0ca165255ad72c38ec1e2151fb1c3205d2b0edc59c12ec58794::credenza_airdrop {
    struct CredenzaAirdropConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin: 0x2::bag::Bag,
        owner: address,
        per_address_limit: u64,
        dropped_amount: 0x2::table::Table<address, u64>,
    }

    struct CredenzaAirdropConfigCreatedEvent<phantom T0> has copy, drop {
        id: 0x2::object::ID,
    }

    public fun create_config<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CredenzaAirdropConfig<T0>{
            id                : 0x2::object::new(arg0),
            coin              : 0x2::bag::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            per_address_limit : 0,
            dropped_amount    : 0x2::table::new<address, u64>(arg0),
        };
        let v1 = CredenzaAirdropConfigCreatedEvent<T0>{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<CredenzaAirdropConfigCreatedEvent<T0>>(v1);
        0x2::transfer::share_object<CredenzaAirdropConfig<T0>>(v0);
    }

    public fun request_coin<T0>(arg0: &mut CredenzaAirdropConfig<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0), 1);
        let v2 = arg1;
        if (0x2::table::contains<address, u64>(&arg0.dropped_amount, v1)) {
            v2 = arg1 + 0x2::table::remove<address, u64>(&mut arg0.dropped_amount, v1);
        };
        if (arg0.per_address_limit > 0) {
            assert!(arg0.per_address_limit >= v2, 2);
        };
        0x2::table::add<address, u64>(&mut arg0.dropped_amount, v1, v2);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0);
        assert!(arg1 <= 0x2::coin::value<T0>(v3), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v3, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun set_coin<T0>(arg0: &mut CredenzaAirdropConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        if (0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0), 0x2::tx_context::sender(arg2));
        };
        0x2::bag::add<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0, arg1);
    }

    public fun set_drop_per_address_limit<T0>(arg0: &mut CredenzaAirdropConfig<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.per_address_limit = arg1;
    }

    // decompiled from Move bytecode v6
}

