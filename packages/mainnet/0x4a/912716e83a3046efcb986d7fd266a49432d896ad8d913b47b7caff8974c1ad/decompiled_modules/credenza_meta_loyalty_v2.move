module 0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::credenza_meta_loyalty_v2 {
    struct LoyaltyConfig has store, key {
        id: 0x2::object::UID,
        ownership: 0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::CredenzaOwnership,
        lifetime_points: 0x2::table::Table<address, u64>,
        points_per_event: 0x2::table::Table<address, 0x2::table::Table<0x1::string::String, u64>>,
        current_points: 0x2::table::Table<address, u64>,
        event_ids: vector<0x1::string::String>,
        coin: 0x2::bag::Bag,
        rate: u64,
        version: u8,
    }

    struct PointsAddedEvent has copy, drop {
        user: address,
        event_id: 0x1::string::String,
        amount: u64,
        meta: 0x1::string::String,
    }

    struct PointsAddedUserEvent has key {
        id: 0x2::object::UID,
        event_id: 0x1::string::String,
        amount: u64,
        meta: 0x1::string::String,
    }

    struct LoyaltyConfigCreatedEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct PointsRedeemedEvent has copy, drop {
        user: address,
        amount: u64,
        event_id: 0x1::string::String,
    }

    public fun add_points(arg0: &mut LoyaltyConfig, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        add_points_with_meta(arg0, arg1, arg2, arg3, 0x1::string::utf8(b""), arg4);
    }

    public fun add_points_with_meta(arg0: &mut LoyaltyConfig, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg5));
        let v0 = PointsAddedEvent{
            user     : arg1,
            event_id : arg3,
            amount   : arg2,
            meta     : arg4,
        };
        0x2::event::emit<PointsAddedEvent>(v0);
        let v1 = PointsAddedUserEvent{
            id       : 0x2::object::new(arg5),
            event_id : arg3,
            amount   : arg2,
            meta     : arg4,
        };
        0x2::transfer::transfer<PointsAddedUserEvent>(v1, arg1);
        if (!0x1::vector::contains<0x1::string::String>(&arg0.event_ids, &arg3)) {
            0x1::vector::push_back<0x1::string::String>(&mut arg0.event_ids, arg3);
        };
        let v2 = 0;
        if (0x2::table::contains<address, u64>(&arg0.lifetime_points, arg1)) {
            v2 = 0x2::table::remove<address, u64>(&mut arg0.lifetime_points, arg1);
        };
        0x2::table::add<address, u64>(&mut arg0.lifetime_points, arg1, v2 + arg2);
        let v3 = 0;
        if (0x2::table::contains<address, u64>(&arg0.current_points, arg1)) {
            v3 = 0x2::table::remove<address, u64>(&mut arg0.current_points, arg1);
        };
        0x2::table::add<address, u64>(&mut arg0.current_points, arg1, v3 + arg2);
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::string::String, u64>>(&arg0.points_per_event, arg1)) {
            0x2::table::add<address, 0x2::table::Table<0x1::string::String, u64>>(&mut arg0.points_per_event, arg1, 0x2::table::new<0x1::string::String, u64>(arg5));
        };
        let v4 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::string::String, u64>>(&mut arg0.points_per_event, arg1);
        let v5 = 0;
        if (0x2::table::contains<0x1::string::String, u64>(v4, arg3)) {
            v5 = 0x2::table::remove<0x1::string::String, u64>(v4, arg3);
        };
        0x2::table::add<0x1::string::String, u64>(v4, arg3, v5 + arg2);
    }

    public fun convert_points_to_coins<T0>(arg0: &mut LoyaltyConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rate > 0, 1);
        let v0 = PointsRedeemedEvent{
            user     : 0x2::tx_context::sender(arg2),
            amount   : arg1,
            event_id : 0x1::string::utf8(b"CONVERT_POINTS_TO_COINS"),
        };
        0x2::event::emit<PointsRedeemedEvent>(v0);
        let v1 = 0x2::coin::split<T0>(0x2::bag::borrow_mut<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, 0x2::object::uid_to_inner(&arg0.id)), arg1 / arg0.rate, arg2);
        subtract_points(arg0, 0x2::tx_context::sender(arg2), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun deposit<T0>(arg0: &mut LoyaltyConfig, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        if (0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0), arg1);
        } else {
            0x2::bag::add<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0, arg1);
        };
    }

    public fun forfeit_points(arg0: &mut LoyaltyConfig, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        subtract_points(arg0, arg1, arg2);
    }

    public fun forfeit_points_for_event_id(arg0: &mut LoyaltyConfig, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::table::borrow_mut<0x1::string::String, u64>(0x2::table::borrow_mut<address, 0x2::table::Table<0x1::string::String, u64>>(&mut arg0.points_per_event, arg1), arg3);
        assert!(*v0 >= arg2, 2);
        *v0 = *v0 - arg2;
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.current_points, arg1);
        *v1 = *v1 - arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = LoyaltyConfig{
            id               : v0,
            ownership        : 0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::create_ownership(0x2::object::uid_to_inner(&v0), arg0),
            lifetime_points  : 0x2::table::new<address, u64>(arg0),
            points_per_event : 0x2::table::new<address, 0x2::table::Table<0x1::string::String, u64>>(arg0),
            current_points   : 0x2::table::new<address, u64>(arg0),
            event_ids        : 0x1::vector::empty<0x1::string::String>(),
            coin             : 0x2::bag::new(arg0),
            rate             : 0,
            version          : 21,
        };
        0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::add_owner(&mut v1.ownership, 0x2::tx_context::sender(arg0));
        let v2 = LoyaltyConfigCreatedEvent{id: 0x2::object::uid_to_inner(&v1.id)};
        0x2::event::emit<LoyaltyConfigCreatedEvent>(v2);
        0x2::transfer::share_object<LoyaltyConfig>(v1);
    }

    public fun redeem_points(arg0: &mut LoyaltyConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        subtract_points(arg0, 0x2::tx_context::sender(arg2), arg1);
        let v0 = PointsRedeemedEvent{
            user     : 0x2::tx_context::sender(arg2),
            amount   : arg1,
            event_id : 0x1::string::utf8(b""),
        };
        0x2::event::emit<PointsRedeemedEvent>(v0);
    }

    public fun redeem_points_for_address(arg0: &mut LoyaltyConfig, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg4));
        subtract_points(arg0, arg1, arg2);
        let v0 = PointsRedeemedEvent{
            user     : arg1,
            amount   : arg2,
            event_id : arg3,
        };
        0x2::event::emit<PointsRedeemedEvent>(v0);
    }

    public fun redeem_points_with_event(arg0: &mut LoyaltyConfig, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        subtract_points(arg0, 0x2::tx_context::sender(arg3), arg1);
        let v0 = PointsRedeemedEvent{
            user     : 0x2::tx_context::sender(arg3),
            amount   : arg1,
            event_id : arg2,
        };
        0x2::event::emit<PointsRedeemedEvent>(v0);
    }

    public fun set_coin<T0, T1>(arg0: &mut LoyaltyConfig, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        if (0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0), 0x2::tx_context::sender(arg3));
        };
        arg0.rate = arg2;
        0x2::bag::add<0x2::object::ID, 0x2::coin::Coin<T1>>(&mut arg0.coin, v0, arg1);
    }

    public fun set_owner(arg0: &mut LoyaltyConfig, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::set_owner(&mut arg0.ownership, arg1, arg2);
    }

    fun subtract_points(arg0: &mut LoyaltyConfig, arg1: address, arg2: u64) {
        assert!(*0x2::table::borrow<address, u64>(&mut arg0.current_points, arg1) >= arg2, 2);
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::string::String, u64>>(&mut arg0.points_per_event, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0.event_ids) && arg2 > 0) {
            let v2 = 0x2::table::borrow_mut<0x1::string::String, u64>(v0, *0x1::vector::borrow<0x1::string::String>(&arg0.event_ids, v1));
            let v3 = *v2;
            if (v3 > arg2) {
                *v2 = v3 - arg2;
                arg2 = 0;
            } else {
                *v2 = 0;
                arg2 = arg2 - v3;
            };
            v1 = v1 + 1;
        };
        let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.current_points, arg1);
        *v4 = *v4 - arg2;
    }

    public fun withdraw<T0>(arg0: &mut LoyaltyConfig, arg1: &mut 0x2::tx_context::TxContext) {
        0x4a912716e83a3046efcb986d7fd266a49432d896ad8d913b47b7caff8974c1ad::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, 0x2::object::uid_to_inner(&arg0.id)), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

