module 0x948d0f354923a0dfd2b751894773af811b8535368936aa1801371cf986005cb1::items {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ItemDefinition has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        item_type: u8,
        heal_amount: u16,
        attack_bonus: u16,
        defense_bonus: u16,
        price_mist: u64,
        duration_ms: u64,
        supply_limit: u64,
        minted: u64,
        enabled: bool,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        definition_id: 0x2::object::ID,
        expiration_ms: u64,
        equipped: bool,
    }

    struct ItemDefinitionCreated has copy, drop {
        definition_id: 0x2::object::ID,
        name: 0x1::string::String,
        item_type: u8,
    }

    struct ItemDefinitionUpdated has copy, drop {
        definition_id: 0x2::object::ID,
        field: 0x1::string::String,
        value: u64,
    }

    struct ItemPurchased has copy, drop {
        item_id: 0x2::object::ID,
        buyer: address,
        definition_id: 0x2::object::ID,
    }

    public entry fun buy_item(arg0: &mut ItemDefinition, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 0);
        let v0 = arg0.price_mist;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg4)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (arg0.supply_limit > 0) {
            assert!(arg0.minted < arg0.supply_limit, 2);
        };
        let v1 = if (arg0.duration_ms == 0) {
            0
        } else {
            0x2::clock::timestamp_ms(arg3) + arg0.duration_ms
        };
        let v2 = Item{
            id            : 0x2::object::new(arg4),
            definition_id : 0x2::object::id<ItemDefinition>(arg0),
            expiration_ms : v1,
            equipped      : false,
        };
        arg0.minted = arg0.minted + 1;
        let v3 = ItemPurchased{
            item_id       : 0x2::object::id<Item>(&v2),
            buyer         : 0x2::tx_context::sender(arg4),
            definition_id : 0x2::object::id<ItemDefinition>(arg0),
        };
        0x2::event::emit<ItemPurchased>(v3);
        0x2::transfer::public_transfer<Item>(v2, 0x2::tx_context::sender(arg4));
    }

    public entry fun create_item_definition(arg0: &AdminCap, arg1: 0x1::string::String, arg2: u8, arg3: u16, arg4: u16, arg5: u16, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2, 8);
        let v0 = ItemDefinition{
            id            : 0x2::object::new(arg9),
            name          : arg1,
            item_type     : arg2,
            heal_amount   : arg3,
            attack_bonus  : arg4,
            defense_bonus : arg5,
            price_mist    : arg6,
            duration_ms   : arg7,
            supply_limit  : arg8,
            minted        : 0,
            enabled       : true,
        };
        0x2::transfer::share_object<ItemDefinition>(v0);
        let v1 = ItemDefinitionCreated{
            definition_id : 0x2::object::id<ItemDefinition>(&v0),
            name          : 0x1::string::utf8(*0x1::string::bytes(&arg1)),
            item_type     : arg2,
        };
        0x2::event::emit<ItemDefinitionCreated>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Treasury>(v1);
    }

    public entry fun list_item_for_sale(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: Item, arg3: u64) {
        assert!(arg3 > 0, 9);
        0x2::kiosk::place_and_list<Item>(arg0, arg1, arg2, arg3);
    }

    public entry fun toggle_enabled(arg0: &AdminCap, arg1: &mut ItemDefinition, arg2: bool) {
        arg1.enabled = arg2;
        let v0 = if (arg2) {
            1
        } else {
            0
        };
        let v1 = ItemDefinitionUpdated{
            definition_id : 0x2::object::id<ItemDefinition>(arg1),
            field         : 0x1::string::utf8(b"enabled"),
            value         : v0,
        };
        0x2::event::emit<ItemDefinitionUpdated>(v1);
    }

    public entry fun update_price(arg0: &AdminCap, arg1: &mut ItemDefinition, arg2: u64) {
        arg1.price_mist = arg2;
        let v0 = ItemDefinitionUpdated{
            definition_id : 0x2::object::id<ItemDefinition>(arg1),
            field         : 0x1::string::utf8(b"price"),
            value         : arg2,
        };
        0x2::event::emit<ItemDefinitionUpdated>(v0);
    }

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

