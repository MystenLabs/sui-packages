module 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::items {
    struct ITEMS has drop {
        dummy_field: bool,
    }

    struct ItemsWithdrawn has copy, drop {
        player_id: 0x2::object::ID,
        kind: u16,
        qty: u64,
    }

    struct ItemsDeposited has copy, drop {
        player_id: 0x2::object::ID,
        kind: u16,
        qty: u64,
    }

    struct GearWithdrawn has copy, drop {
        player_id: 0x2::object::ID,
        kind: u16,
        gear_id: 0x2::object::ID,
    }

    struct GearDeposited has copy, drop {
        player_id: 0x2::object::ID,
        kind: u16,
        armory_key: u64,
    }

    public fun deposit_equipment(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::Equipment) {
        let v0 = GearDeposited{
            player_id  : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind       : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::kind(&arg1),
            armory_key : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::put_in_armory(arg0, arg1),
        };
        0x2::event::emit<GearDeposited>(v0);
    }

    public fun deposit_items<T0>(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::treasury::Treasury, arg2: 0x2::coin::Coin<T0>) {
        let (v0, v1) = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::treasury::burn<T0>(arg1, arg2);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::credit_item(arg0, v0, v1);
        let v2 = ItemsDeposited{
            player_id : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind      : v0,
            qty       : v1,
        };
        0x2::event::emit<ItemsDeposited>(v2);
    }

    fun init(arg0: ITEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ITEMS>(arg0, arg1);
        let v1 = 0x2::display::new<0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::Equipment>(&v0, arg1);
        0x2::display::add<0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::Equipment>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::Equipment>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/equipment/{kind}.png"));
        0x2::display::add<0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::Equipment>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"49646c652054696465732065717569706d656e7420e2809420666f7267656420696e2067616d652c207765617261626c65206f6e2072656465706f7369742e"));
        0x2::display::update_version<0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::Equipment>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::Equipment>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun withdraw_equipment(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_can_play(arg0, arg2, arg3);
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::take_from_armory(arg0, arg1);
        let v1 = GearWithdrawn{
            player_id : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind      : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::kind(&v0),
            gear_id   : 0x2::object::id<0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::Equipment>(&v0),
        };
        0x2::event::emit<GearWithdrawn>(v1);
        0x2::transfer::public_transfer<0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::Equipment>(v0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::owner(arg0));
    }

    public fun withdraw_items<T0>(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::treasury::Treasury, arg3: u16, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_can_play(arg0, arg5, arg6);
        assert!(arg4 > 0, 13906834573775339521);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::item(arg1, arg3);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::debit_item(arg0, arg3, arg4);
        let v0 = ItemsWithdrawn{
            player_id : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind      : arg3,
            qty       : arg4,
        };
        0x2::event::emit<ItemsWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::treasury::mint<T0>(arg2, arg3, arg4, arg6), 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::owner(arg0));
    }

    // decompiled from Move bytecode v7
}

