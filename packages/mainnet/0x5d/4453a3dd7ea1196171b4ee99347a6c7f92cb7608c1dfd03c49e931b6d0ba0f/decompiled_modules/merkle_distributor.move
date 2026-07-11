module 0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::merkle_distributor {
    struct Distributor has key {
        id: 0x2::object::UID,
        admin: address,
        funds: 0x2::balance::Balance<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER>,
        merkle_root: vector<u8>,
        claimed: 0x2::table::Table<address, bool>,
        deadline_ms: u64,
    }

    struct DistributorClaimed has copy, drop {
        account: address,
        amount: u64,
    }

    public fun claim(arg0: &mut Distributor, arg1: u64, arg2: vector<vector<u8>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.deadline_ms, 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v0), 0);
        assert!(verify(&arg2, &arg0.merkle_root, leaf_hash(v0, arg1)), 1);
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        let v1 = DistributorClaimed{
            account : v0,
            amount  : arg1,
        };
        0x2::event::emit<DistributorClaimed>(v1);
        0x2::coin::from_balance<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER>(0x2::balance::split<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER>(&mut arg0.funds, arg1), arg4)
    }

    public fun create(arg0: 0x2::coin::Coin<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Distributor {
        Distributor{
            id          : 0x2::object::new(arg3),
            admin       : 0x2::tx_context::sender(arg3),
            funds       : 0x2::coin::into_balance<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER>(arg0),
            merkle_root : arg1,
            claimed     : 0x2::table::new<address, bool>(arg3),
            deadline_ms : arg2,
        }
    }

    public fun has_claimed(arg0: &Distributor, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    public fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = b"";
        if (le_bytes(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x2::hash::keccak256(&v0)
    }

    fun le_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 <= v1
    }

    public fun leaf_hash(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x2::hash::keccak256(&v0)
    }

    public fun remaining(arg0: &Distributor) : u64 {
        0x2::balance::value<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER>(&arg0.funds)
    }

    public fun sweep(arg0: &mut Distributor, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER> {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.deadline_ms, 3);
        0x2::coin::from_balance<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER>(0x2::balance::split<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER>(&mut arg0.funds, 0x2::balance::value<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER>(&arg0.funds)), arg2)
    }

    fun verify(arg0: &vector<vector<u8>>, arg1: &vector<u8>, arg2: vector<u8>) : bool {
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            v0 = hash_pair(v0, *0x1::vector::borrow<vector<u8>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0 == *arg1
    }

    // decompiled from Move bytecode v7
}

