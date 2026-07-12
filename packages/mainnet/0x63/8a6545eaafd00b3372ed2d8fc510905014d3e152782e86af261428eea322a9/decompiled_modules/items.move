module 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::items {
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

    public fun deposit_equipment(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::Equipment) {
        let v0 = GearDeposited{
            player_id  : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            kind       : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::kind(&arg1),
            armory_key : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::put_in_armory(arg0, arg1),
        };
        0x2::event::emit<GearDeposited>(v0);
    }

    public fun deposit_items<T0>(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::treasury::Treasury, arg2: 0x2::coin::Coin<T0>) {
        let (v0, v1) = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::treasury::burn<T0>(arg1, arg2);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_item(arg0, v0, v1);
        let v2 = ItemsDeposited{
            player_id : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            kind      : v0,
            qty       : v1,
        };
        0x2::event::emit<ItemsDeposited>(v2);
    }

    fun init(arg0: ITEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ITEMS>(arg0, arg1);
        let v1 = 0x2::display::new<0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::Equipment>(&v0, arg1);
        0x2::display::add<0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::Equipment>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::Equipment>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/equipment/{kind}.png"));
        0x2::display::add<0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::Equipment>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"49646c652054696465732065717569706d656e7420e2809420666f7267656420696e2067616d652c207765617261626c65206f6e2072656465706f7369742e"));
        0x2::display::update_version<0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::Equipment>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::Equipment>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun withdraw_equipment(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg2, arg3);
        let v0 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::take_from_armory(arg0, arg1);
        let v1 = GearWithdrawn{
            player_id : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            kind      : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::kind(&v0),
            gear_id   : 0x2::object::id<0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::Equipment>(&v0),
        };
        0x2::event::emit<GearWithdrawn>(v1);
        0x2::transfer::public_transfer<0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::Equipment>(v0, 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::owner(arg0));
    }

    public fun withdraw_items<T0>(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::treasury::Treasury, arg3: u16, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::assert_version(arg1);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg5, arg6);
        assert!(arg4 > 0, 13906834578070306817);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item(arg1, arg3);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::debit_item(arg0, arg3, arg4);
        let v0 = ItemsWithdrawn{
            player_id : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            kind      : arg3,
            qty       : arg4,
        };
        0x2::event::emit<ItemsWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::treasury::mint<T0>(arg2, arg3, arg4, arg6), 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::owner(arg0));
    }

    // decompiled from Move bytecode v7
}

