module 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::holder_rewards {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        operator: address,
        holder_bps: u64,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        reserved: u64,
        credits: 0x2::table::Table<address, u64>,
        round: u64,
        snapshot_ms: u64,
        manifest_hash: vector<u8>,
    }

    struct Created has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
        operator: address,
        holder_bps: u64,
    }

    struct Funded has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct Allocated has copy, drop {
        vault_id: 0x2::object::ID,
        round: u64,
        snapshot_ms: u64,
        manifest_hash: vector<u8>,
        total: u64,
    }

    struct Credited has copy, drop {
        vault_id: 0x2::object::ID,
        round: u64,
        recipient: address,
        amount: u64,
    }

    struct Claimed has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public fun allocate<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<address>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.operator, 1);
        assert!(arg1 == arg0.round + 1 && 0x1::vector::length<u8>(&arg3) == 32, 2);
        assert!(arg2 >= arg0.snapshot_ms + 3600000 && arg2 <= 0x2::clock::timestamp_ms(arg6), 2);
        let v0 = if (!0x1::vector::is_empty<address>(&arg4)) {
            if (0x1::vector::length<address>(&arg4) <= 500) {
                0x1::vector::length<address>(&arg4) == 0x1::vector::length<u64>(&arg5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg4)) {
            let v3 = *0x1::vector::borrow<address>(&arg4, v2);
            let v4 = if (v3 != @0x0) {
                if (v3 != arg0.creator) {
                    v3 != 0x2::object::id_address<Vault<T0>>(arg0)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v4, 0);
            if (v2 > 0) {
                assert!(0x2::address::to_u256(*0x1::vector::borrow<address>(&arg4, v2 - 1)) < 0x2::address::to_u256(v3), 0);
            };
            assert!(*0x1::vector::borrow<u64>(&arg5, v2) > 0, 0);
            v1 = v1 + *0x1::vector::borrow<u64>(&arg5, v2);
            v2 = v2 + 1;
        };
        assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.funds) - arg0.reserved, 3);
        v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg4)) {
            let v5 = *0x1::vector::borrow<address>(&arg4, v2);
            if (!0x2::table::contains<address, u64>(&arg0.credits, v5)) {
                0x2::table::add<address, u64>(&mut arg0.credits, v5, 0);
            };
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg0.credits, v5);
            *v6 = *v6 + *0x1::vector::borrow<u64>(&arg5, v2);
            let v7 = Credited{
                vault_id  : 0x2::object::id<Vault<T0>>(arg0),
                round     : arg1,
                recipient : v5,
                amount    : *0x1::vector::borrow<u64>(&arg5, v2),
            };
            0x2::event::emit<Credited>(v7);
            v2 = v2 + 1;
        };
        arg0.reserved = arg0.reserved + v1;
        arg0.round = arg1;
        arg0.snapshot_ms = arg2;
        arg0.manifest_hash = arg3;
        let v8 = Allocated{
            vault_id      : 0x2::object::id<Vault<T0>>(arg0),
            round         : arg1,
            snapshot_ms   : arg2,
            manifest_hash : arg3,
            total         : v1,
        };
        0x2::event::emit<Allocated>(v8);
    }

    public fun claim<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.credits, v0), 4);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.credits, v0);
        let v2 = *v1;
        assert!(v2 > 0, 4);
        *v1 = 0;
        arg0.reserved = arg0.reserved - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, v2), arg1), v0);
        let v3 = Claimed{
            vault_id  : 0x2::object::id<Vault<T0>>(arg0),
            recipient : v0,
            amount    : v2,
        };
        0x2::event::emit<Claimed>(v3);
    }

    public(friend) fun create<T0>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = if (arg0 != @0x0) {
            if (arg1 > 0) {
                arg1 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0);
        let v2 = Vault<T0>{
            id            : 0x2::object::new(arg2),
            creator       : v0,
            operator      : arg0,
            holder_bps    : arg1,
            funds         : 0x2::balance::zero<0x2::sui::SUI>(),
            reserved      : 0,
            credits       : 0x2::table::new<address, u64>(arg2),
            round         : 0,
            snapshot_ms   : 0,
            manifest_hash : b"",
        };
        let v3 = Created{
            vault_id   : 0x2::object::id<Vault<T0>>(&v2),
            creator    : v0,
            operator   : arg0,
            holder_bps : arg1,
        };
        0x2::event::emit<Created>(v3);
        v2
    }

    public fun receive_fee<T0>(arg0: &mut Vault<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
        let v1 = Funded{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<Funded>(v1);
    }

    public(friend) fun share<T0>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    // decompiled from Move bytecode v7
}

