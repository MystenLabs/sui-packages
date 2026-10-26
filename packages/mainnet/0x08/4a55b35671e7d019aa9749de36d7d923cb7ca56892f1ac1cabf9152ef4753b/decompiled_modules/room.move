module 0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::room {
    struct Room<phantom T0> has key {
        id: 0x2::object::UID,
        space_id: 0x2::object::ID,
        fees: vector<u64>,
        treasury: 0x2::balance::Balance<T0>,
    }

    struct FeePaid has copy, drop {
        room_id: 0x2::object::ID,
        kind: u8,
        payer: address,
        amount: u64,
        memo: 0x1::string::String,
    }

    struct AgentMessage has copy, drop {
        room_id: 0x2::object::ID,
        from: address,
        to_agent: 0x1::string::String,
        blob_id: 0x1::string::String,
    }

    public fun agent_message<T0>(arg0: &mut Room<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        pay<T0>(arg0, 3, arg1, 0x1::string::utf8(b"agent_message"), arg4);
        let v0 = AgentMessage{
            room_id  : 0x2::object::id<Room<T0>>(arg0),
            from     : 0x2::tx_context::sender(arg4),
            to_agent : arg2,
            blob_id  : arg3,
        };
        0x2::event::emit<AgentMessage>(v0);
    }

    entry fun create_room<T0>(arg0: &0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::memory_space::OwnerCap, arg1: &0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::memory_space::Space, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::memory_space::cap_space_id(arg0) == 0x2::object::id<0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::memory_space::Space>(arg1), 10);
        assert!(0x1::vector::length<u64>(&arg2) == 4, 11);
        let v0 = Room<T0>{
            id       : 0x2::object::new(arg3),
            space_id : 0x2::object::id<0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::memory_space::Space>(arg1),
            fees     : arg2,
            treasury : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Room<T0>>(v0);
    }

    public fun fee<T0>(arg0: &Room<T0>, arg1: u8) : u64 {
        *0x1::vector::borrow<u64>(&arg0.fees, (arg1 as u64))
    }

    public fun join_room<T0>(arg0: &mut Room<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        pay<T0>(arg0, 0, arg1, 0x1::string::utf8(b"join_room"), arg2);
    }

    public fun pay<T0>(arg0: &mut Room<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 3, 11);
        let v0 = *0x1::vector::borrow<u64>(&arg0.fees, (arg1 as u64));
        assert!(0x2::coin::value<T0>(&arg2) >= v0, 12);
        0x2::balance::join<T0>(&mut arg0.treasury, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v0, arg4)));
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        };
        let v1 = FeePaid{
            room_id : 0x2::object::id<Room<T0>>(arg0),
            kind    : arg1,
            payer   : 0x2::tx_context::sender(arg4),
            amount  : v0,
            memo    : arg3,
        };
        0x2::event::emit<FeePaid>(v1);
    }

    public fun read_memory<T0>(arg0: &mut Room<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        pay<T0>(arg0, 2, arg1, arg2, arg3);
    }

    public fun set_fee<T0>(arg0: &0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::memory_space::OwnerCap, arg1: &mut Room<T0>, arg2: u8, arg3: u64) {
        assert!(0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::memory_space::cap_space_id(arg0) == arg1.space_id, 10);
        assert!(arg2 <= 3, 11);
        *0x1::vector::borrow_mut<u64>(&mut arg1.fees, (arg2 as u64)) = arg3;
    }

    public fun treasury_value<T0>(arg0: &Room<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    public fun withdraw<T0>(arg0: &0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::memory_space::OwnerCap, arg1: &mut Room<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::memory_space::cap_space_id(arg0) == arg1.space_id, 10);
        0x2::coin::take<T0>(&mut arg1.treasury, arg2, arg3)
    }

    public fun write_memory<T0>(arg0: &mut Room<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= *0x1::vector::borrow<u64>(&arg0.fees, (1 as u64)) + arg2, 12);
        0x2::balance::join<T0>(&mut arg0.treasury, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg4)));
        pay<T0>(arg0, 1, arg1, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

