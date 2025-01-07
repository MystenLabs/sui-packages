module 0x533793b0a2ab8bebcd7baeeb55467f80139eab572764ff5d330e4eb8d9186c4c::manager {
    struct GlobalState has key {
        id: 0x2::object::UID,
        bps: u32,
        admin_list: vector<address>,
    }

    struct EventRoute has copy, drop {
        sender: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        bps: u32,
        recipient: address,
    }

    struct EventWithdraw has copy, drop {
        sender: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    public entry fun add_admin(arg0: &mut GlobalState, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 403);
        0x1::vector::push_back<address>(&mut arg0.admin_list, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalState{
            id         : 0x2::object::new(arg0),
            bps        : 85,
            admin_list : v0,
        };
        0x2::transfer::share_object<GlobalState>(v1);
    }

    fun is_admin(arg0: &GlobalState, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admin_list, &arg1)
    }

    public entry fun remove_admin(arg0: &mut GlobalState, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 403);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admin_list, &arg1);
        assert!(v0, 404);
        0x1::vector::remove<address>(&mut arg0.admin_list, v1);
    }

    public entry fun route<T0>(arg0: &mut GlobalState, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        route_with_recipient<T0>(arg0, arg1, v0, arg2);
    }

    public entry fun route_with_recipient<T0>(arg0: &mut GlobalState, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            let v3 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
            0x2::coin::put<T0>(v3, arg1);
            v3
        } else {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
            0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v2, v1 - v1 * (arg0.bps as u64) / 10000, arg3), arg2);
        let v4 = EventRoute{
            sender    : 0x2::tx_context::sender(arg3),
            coin_type : v0,
            amount    : v1,
            bps       : arg0.bps,
            recipient : arg2,
        };
        0x2::event::emit<EventRoute>(v4);
    }

    public entry fun update_bps(arg0: &mut GlobalState, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 403);
        arg0.bps = arg1;
    }

    public entry fun withdraw<T0>(arg0: &mut GlobalState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_admin(arg0, v0), 403);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), arg1, arg2), v0);
            let v2 = EventWithdraw{
                sender    : v0,
                coin_type : v1,
                amount    : arg1,
            };
            0x2::event::emit<EventWithdraw>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

