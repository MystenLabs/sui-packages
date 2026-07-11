module 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::vendor {
    struct VendorTraded has copy, drop {
        player_id: 0x2::object::ID,
        kind: u16,
        qty: u64,
        coins: u64,
        bought: bool,
    }

    public fun buy_equipment(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: u16, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_can_play(arg0, arg3, arg4);
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::equipment(arg1, arg2);
        let v1 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::equipment_vendor_sell(&v0);
        assert!(v1 > 0, 13906834565185404929);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::debit_coins(arg0, v1);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::mint_into_armory(arg0, arg1, arg2, arg4);
        let v2 = VendorTraded{
            player_id : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind      : arg2,
            qty       : 1,
            coins     : v1,
            bought    : true,
        };
        0x2::event::emit<VendorTraded>(v2);
    }

    public fun buy_item(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: u16, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_can_play(arg0, arg4, arg5);
        assert!(arg3 > 0, 13906834350437302277);
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::item(arg1, arg2);
        let v1 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::item_vendor_sell(&v0);
        assert!(v1 > 0, 13906834359026974721);
        let v2 = v1 * arg3;
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::debit_coins(arg0, v2);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::credit_item(arg0, arg2, arg3);
        let v3 = VendorTraded{
            player_id : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind      : arg2,
            qty       : arg3,
            coins     : v2,
            bought    : true,
        };
        0x2::event::emit<VendorTraded>(v3);
    }

    public fun sell_item(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: u16, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_can_play(arg0, arg4, arg5);
        assert!(arg3 > 0, 13906834457811484677);
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::item(arg1, arg2);
        let v1 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::item_vendor_buy(&v0);
        assert!(v1 > 0, 13906834466401288195);
        let v2 = v1 * arg3;
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::debit_item(arg0, arg2, arg3);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::credit_coins(arg0, v2);
        let v3 = VendorTraded{
            player_id : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind      : arg2,
            qty       : arg3,
            coins     : v2,
            bought    : false,
        };
        0x2::event::emit<VendorTraded>(v3);
    }

    // decompiled from Move bytecode v7
}

