module 0xfcd0b2b4f69758cd3ed0d35a55335417cac6304017c3c5d9a5aaff75c367aaff::shade {
    struct ShadeOrder has key {
        id: 0x2::object::UID,
        owner: address,
        deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        commitment: vector<u8>,
        sealed_payload: vector<u8>,
    }

    entry fun cancel(arg0: ShadeOrder, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let ShadeOrder {
            id             : v0,
            owner          : _,
            deposit        : v2,
            commitment     : _,
            sealed_payload : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg1), 0x2::tx_context::sender(arg1));
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
        0x2::transfer::share_object<ShadeOrder>(v0);
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
        let ShadeOrder {
            id             : v0,
            owner          : _,
            deposit        : v2,
            commitment     : _,
            sealed_payload : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(v2, arg6)
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
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun owner(arg0: &ShadeOrder) : address {
        arg0.owner
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
    }

    // decompiled from Move bytecode v6
}

