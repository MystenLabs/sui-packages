module 0x87ddebb37dc859a646fe097b46a286ff1b78af0d2fb0b457ede87066c825b320::mint_box {
    struct MintBox has store, key {
        id: 0x2::object::UID,
        marker: u64,
        box_ids: vector<0x2::object::ID>,
        size: u64,
    }

    public(friend) fun pop_back(arg0: &mut MintBox) : u256 {
        assert!(!is_empty(arg0), 2);
        let v0 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.box_ids);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, vector<u256>>(&mut arg0.id, v0);
        arg0.size = arg0.size - 1;
        if (0x1::vector::is_empty<u256>(v1)) {
            0x1::vector::destroy_empty<u256>(0x2::dynamic_field::remove<0x2::object::ID, vector<u256>>(&mut arg0.id, v0));
        } else {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.box_ids, v0);
        };
        0x1::vector::pop_back<u256>(v1)
    }

    public(friend) fun is_empty(arg0: &MintBox) : bool {
        arg0.size == 0
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : MintBox {
        MintBox{
            id      : 0x2::object::new(arg0),
            marker  : 0,
            box_ids : 0x1::vector::empty<0x2::object::ID>(),
            size    : 0,
        }
    }

    public(friend) fun destroy(arg0: MintBox) {
        let MintBox {
            id      : v0,
            marker  : _,
            box_ids : _,
            size    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun get(arg0: &mut MintBox, arg1: &mut 0x87ddebb37dc859a646fe097b46a286ff1b78af0d2fb0b457ede87066c825b320::pseudorandom::PseudoRandomCounter, arg2: &mut 0x2::tx_context::TxContext) : u256 {
        assert!(!is_empty(arg0), 2);
        let v0 = &mut arg0.box_ids;
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::object::uid_to_bytes(&arg0.id));
        let v2 = 0x87ddebb37dc859a646fe097b46a286ff1b78af0d2fb0b457ede87066c825b320::pseudorandom::rand(arg1, v1, arg2);
        let v3 = 0x87ddebb37dc859a646fe097b46a286ff1b78af0d2fb0b457ede87066c825b320::pseudorandom::select_u64(0x1::vector::length<0x2::object::ID>(v0), &v2);
        let v4 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, vector<u256>>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(v0, v3));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&v3));
        let v5 = 0x87ddebb37dc859a646fe097b46a286ff1b78af0d2fb0b457ede87066c825b320::pseudorandom::rand(arg1, v1, arg2);
        arg0.size = arg0.size - 1;
        if (0x1::vector::is_empty<u256>(v4)) {
            0x1::vector::destroy_empty<u256>(0x2::dynamic_field::remove<0x2::object::ID, vector<u256>>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(v0, v3)));
            0x1::vector::swap_remove<0x2::object::ID>(v0, v3);
        };
        0x1::vector::swap_remove<u256>(v4, 0x87ddebb37dc859a646fe097b46a286ff1b78af0d2fb0b457ede87066c825b320::pseudorandom::select_u64(0x1::vector::length<u256>(v4), &v5))
    }

    public(friend) fun load(arg0: &mut MintBox, arg1: u64, arg2: vector<u256>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.marker < arg1, 1);
        arg0.marker = arg1;
        let v0 = &mut arg0.box_ids;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&arg2)) {
            if (0x1::vector::length<0x2::object::ID>(v0) <= v1) {
                let v3 = 0x2::object::new(arg3);
                let v4 = 0x2::object::uid_to_inner(&v3);
                0x2::object::delete(v3);
                0x1::vector::push_back<0x2::object::ID>(v0, v4);
                0x2::dynamic_field::add<0x2::object::ID, vector<u256>>(&mut arg0.id, v4, 0x1::vector::empty<u256>());
            };
            let v5 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, vector<u256>>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(v0, v1));
            while (v2 < 0x1::vector::length<u256>(&arg2) && 0x1::vector::length<u256>(v5) < 5000) {
                0x1::vector::push_back<u256>(v5, *0x1::vector::borrow<u256>(&arg2, v2));
                v2 = v2 + 1;
                arg0.size = arg0.size + 1;
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun size(arg0: &MintBox) : u64 {
        arg0.size
    }

    // decompiled from Move bytecode v6
}

