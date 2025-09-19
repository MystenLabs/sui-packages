module 0x45ee2d8287ba1243dc49ee49aeeb7471ec9cf50b0b6b48b4ca4e821b3c0de51::distributor {
    struct Distributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        operator: address,
        merkle_root: vector<u8>,
        start_time_s: u64,
        end_time_s: u64,
        initial_total_amount: u64,
        vault: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<address, u64>,
    }

    struct Created has copy, drop {
        id: address,
        owner: address,
        operator: address,
        total: u64,
    }

    struct TimeSet has copy, drop {
        id: address,
        start_time_s: u64,
        end_time_s: u64,
    }

    struct RootSet has copy, drop {
        id: address,
        merkle_root: vector<u8>,
    }

    struct Claimed has copy, drop {
        id: address,
        recipient: address,
        amount: u64,
        cumulative: u64,
    }

    struct Withdrawn has copy, drop {
        id: address,
        to: address,
        amount: u64,
    }

    struct Funded has copy, drop {
        id: address,
        funder: address,
        amount: u64,
    }

    public entry fun claim<T0>(arg0: &mut Distributor<T0>, arg1: u64, arg2: vector<vector<u8>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(arg0.start_time_s > 0, 7);
        assert!(v0 >= arg0.start_time_s, 10);
        assert!(v0 <= arg0.end_time_s, 11);
        assert!(arg0.merkle_root != 0x1::vector::empty<u8>(), 8);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = get_claimed<T0>(arg0, v1);
        assert!(arg1 > v2, 4);
        let v3 = 0x45ee2d8287ba1243dc49ee49aeeb7471ec9cf50b0b6b48b4ca4e821b3c0de51::merkle::leaf(v1, arg1);
        assert!(0x45ee2d8287ba1243dc49ee49aeeb7471ec9cf50b0b6b48b4ca4e821b3c0de51::merkle::verify(&arg0.merkle_root, &v3, &arg2), 5);
        let v4 = arg1 - v2;
        assert!(0x2::balance::value<T0>(&arg0.vault) >= v4, 13);
        if (v2 == 0) {
            0x2::table::add<address, u64>(&mut arg0.claimed, v1, arg1);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claimed, v1) = arg1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v4), arg4), v1);
        let v5 = Claimed{
            id         : id_address<T0>(arg0),
            recipient  : v1,
            amount     : v4,
            cumulative : arg1,
        };
        0x2::event::emit<Claimed>(v5);
    }

    public(friend) fun create_and_share<T0>(arg0: address, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        assert!(0x2::balance::value<T0>(&v0) == arg2, 4);
        let v1 = Distributor<T0>{
            id                   : 0x2::object::new(arg4),
            owner                : arg0,
            operator             : arg1,
            merkle_root          : 0x1::vector::empty<u8>(),
            start_time_s         : 0,
            end_time_s           : 0,
            initial_total_amount : arg2,
            vault                : v0,
            claimed              : 0x2::table::new<address, u64>(arg4),
        };
        let v2 = Created{
            id       : 0x2::object::uid_to_address(&v1.id),
            owner    : arg0,
            operator : arg1,
            total    : arg2,
        };
        0x2::event::emit<Created>(v2);
        0x2::transfer::share_object<Distributor<T0>>(v1);
    }

    public entry fun fund<T0>(arg0: &mut Distributor<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == arg1 && arg1 > 0, 4);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg2));
        let v0 = Funded{
            id     : id_address<T0>(arg0),
            funder : 0x2::tx_context::sender(arg3),
            amount : arg1,
        };
        0x2::event::emit<Funded>(v0);
    }

    public fun get_claimed<T0>(arg0: &Distributor<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claimed, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed, arg1)
        } else {
            0
        }
    }

    public fun get_vault_amount<T0>(arg0: &Distributor<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public fun id_address<T0>(arg0: &Distributor<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public entry fun set_merkle_root<T0>(arg0: &mut Distributor<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.operator, 2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 12);
        arg0.merkle_root = arg1;
        let v0 = RootSet{
            id          : id_address<T0>(arg0),
            merkle_root : arg0.merkle_root,
        };
        0x2::event::emit<RootSet>(v0);
    }

    public entry fun set_time<T0>(arg0: &mut Distributor<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.operator, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = v0 >= arg0.start_time_s && arg0.start_time_s > 0;
        assert!(!v1, 9);
        assert!(arg1 > v0, 3);
        assert!(arg1 <= v0 + 7776000, 3);
        arg0.start_time_s = arg1;
        arg0.end_time_s = arg1 + 1209600;
        let v2 = TimeSet{
            id           : id_address<T0>(arg0),
            start_time_s : arg1,
            end_time_s   : arg0.end_time_s,
        };
        0x2::event::emit<TimeSet>(v2);
    }

    public entry fun withdraw<T0>(arg0: &mut Distributor<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 > arg0.end_time_s, 6);
        let v1 = 0x2::balance::value<T0>(&arg0.vault);
        assert!(v1 > 0, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v1), arg2), v0);
        let v2 = Withdrawn{
            id     : id_address<T0>(arg0),
            to     : v0,
            amount : v1,
        };
        0x2::event::emit<Withdrawn>(v2);
    }

    // decompiled from Move bytecode v6
}

