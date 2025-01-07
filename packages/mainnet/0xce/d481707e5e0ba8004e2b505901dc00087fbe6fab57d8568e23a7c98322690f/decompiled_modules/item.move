module 0x6d08fef08074c0cd1eba57c46c5903c2fdc3e3a6680ef46d6f6abc7ec1669aee::item {
    struct ItemAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        level: u64,
        level_cap: u64,
        game_asset_ids: vector<0x1::string::String>,
        stat_names: vector<0x1::string::String>,
        stat_values: vector<0x1::string::String>,
        in_game: bool,
    }

    struct UnlockUpdatesTicket has store, key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
    }

    struct ItemStatsUpdated has copy, drop {
        id: 0x2::object::ID,
        stat_names: vector<0x1::string::String>,
        stat_values: vector<0x1::string::String>,
    }

    public fun admin_get_mut_uid(arg0: &mut ItemAdminCap, arg1: &mut Item) : &mut 0x2::object::UID {
        &mut arg1.id
    }

    public fun burn(arg0: Item) {
        let Item {
            id             : v0,
            name           : _,
            description    : _,
            image_url      : _,
            level          : _,
            level_cap      : _,
            game_asset_ids : _,
            stat_names     : _,
            stat_values    : _,
            in_game        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_unlock_updates_ticket(arg0: &mut ItemAdminCap, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : UnlockUpdatesTicket {
        UnlockUpdatesTicket{
            id      : 0x2::object::new(arg2),
            item_id : arg1,
        }
    }

    public fun cw_get_mut_uid(arg0: &mut Item) : &mut 0x2::object::UID {
        assert!(arg0.in_game == true, 3);
        &mut arg0.id
    }

    public fun get_immut_uid(arg0: &Item) : &0x2::object::UID {
        &arg0.id
    }

    public fun in_game(arg0: &Item) : bool {
        arg0.in_game
    }

    public fun lock_updates(arg0: &mut Item) {
        arg0.in_game = false;
    }

    public fun mint(arg0: &mut ItemAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : Item {
        assert!(arg4 <= arg5, 2);
        Item{
            id             : 0x2::object::new(arg10),
            name           : arg1,
            description    : arg2,
            image_url      : arg3,
            level          : arg4,
            level_cap      : arg5,
            game_asset_ids : arg6,
            stat_names     : arg7,
            stat_values    : arg8,
            in_game        : arg9,
        }
    }

    public fun mint_admin_cap_item(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<0x6d08fef08074c0cd1eba57c46c5903c2fdc3e3a6680ef46d6f6abc7ec1669aee::battle_pass::BattlePass>, arg1: &mut 0x2::tx_context::TxContext) : ItemAdminCap {
        ItemAdminCap{id: 0x2::object::new(arg1)}
    }

    public fun set_display_fields(arg0: &mut 0x2::display::Display<Item>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level_cap"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{level_cap}"));
        0x2::display::add_multiple<Item>(arg0, v0, v2);
    }

    public fun unlock_updates(arg0: &mut Item, arg1: UnlockUpdatesTicket) {
        assert!(arg1.item_id == 0x2::object::uid_to_inner(&arg0.id), 0);
        arg0.in_game = true;
        let UnlockUpdatesTicket {
            id      : v0,
            item_id : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun update(arg0: &mut Item, arg1: u64) {
        assert!(arg0.in_game, 1);
        assert!(arg1 <= arg0.level_cap, 2);
        arg0.level = arg1;
    }

    public fun update_game_asset_ids(arg0: &mut Item, arg1: vector<0x1::string::String>) {
        assert!(arg0.in_game == true, 1);
        arg0.game_asset_ids = arg1;
    }

    public fun update_stats(arg0: &mut Item, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) {
        assert!(in_game(arg0) == true, 1);
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 4);
        arg0.stat_names = arg1;
        arg0.stat_values = arg2;
        let v0 = ItemStatsUpdated{
            id          : 0x2::object::uid_to_inner(&arg0.id),
            stat_names  : arg0.stat_names,
            stat_values : arg0.stat_values,
        };
        0x2::event::emit<ItemStatsUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

