module 0x8080ec446284b2e129b116843dc4b0dced9f98eb1805c11585a9b4c601fc5e2::normie_item {
    struct Ticket has store, key {
        id: 0x2::object::UID,
    }

    struct ItemStoreV2<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        price: u64,
        burn_number: u64,
        version: u64,
        admin: 0x2::object::ID,
    }

    struct ItemStore<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        price: u64,
    }

    struct SlotOptionImage has copy, drop, store {
        slot: u8,
        url: 0x2::url::Url,
        name: 0x1::string::String,
        probability: u8,
    }

    struct SlotOptionsEffect has copy, drop, store {
        slot: u8,
        effect: 0x1::string::String,
        effect_magnitude: u64,
        probability: u8,
    }

    struct SlotOptionsV2 has store, key {
        id: 0x2::object::UID,
        slot: u8,
        images: vector<SlotOptionImage>,
        effects: vector<SlotOptionsEffect>,
    }

    struct SlotOptions has store, key {
        id: 0x2::object::UID,
        slot: u8,
        options: vector<SlotOption>,
    }

    struct SlotOption has copy, drop, store {
        slot: u8,
        effect: 0x1::string::String,
        effect_magnitude: u64,
        name: 0x1::string::String,
        probability: u8,
        url: 0x2::url::Url,
    }

    struct NormieItem has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        slot: u8,
        effect: 0x1::string::String,
        effect_magnitude: u64,
    }

    struct StoreOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ItemCreated has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    entry fun add_effect_option<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStoreV2<T0>, arg2: u8, arg3: vector<u8>, arg4: u64, arg5: u8) {
        assert!(arg1.version == 1, 1);
        let v0 = SlotOptionsEffect{
            slot             : arg2,
            effect           : 0x1::string::utf8(arg3),
            effect_magnitude : arg4,
            probability      : arg5,
        };
        let v1 = b"mouth";
        if (arg2 == 1) {
            v1 = b"head";
        } else if (arg2 == 2) {
            v1 = b"body";
        } else if (arg2 == 3) {
            v1 = b"arms";
        } else if (arg2 == 4) {
            v1 = b"eyes";
        };
        0x1::vector::push_back<SlotOptionsEffect>(&mut 0x2::dynamic_object_field::borrow_mut<vector<u8>, SlotOptionsV2>(&mut arg1.id, v1).effects, v0);
    }

    entry fun add_image_option<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStoreV2<T0>, arg2: u8, arg3: vector<u8>, arg4: u8) {
        assert!(arg1.version == 1, 1);
        let v0 = SlotOptionImage{
            slot        : arg2,
            url         : img_url(arg3),
            name        : 0x1::string::utf8(arg3),
            probability : arg4,
        };
        let v1 = b"mouth";
        if (arg2 == 1) {
            v1 = b"head";
        } else if (arg2 == 2) {
            v1 = b"body";
        } else if (arg2 == 3) {
            v1 = b"arms";
        } else if (arg2 == 4) {
            v1 = b"eyes";
        };
        0x1::vector::push_back<SlotOptionImage>(&mut 0x2::dynamic_object_field::borrow_mut<vector<u8>, SlotOptionsV2>(&mut arg1.id, v1).images, v0);
    }

    fun arithmetic_is_less_than(arg0: u8, arg1: u8, arg2: u8) : u8 {
        assert!(arg2 >= arg1 && arg1 > 0, 0);
        let v0 = arg2 / arg1;
        (v0 - arg0 / arg1) / v0
    }

    public fun burn_items_for_ticket<T0>(arg0: &mut ItemStoreV2<T0>, arg1: vector<NormieItem>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(0x1::vector::length<NormieItem>(&arg1) == arg0.burn_number, 0);
        while (!0x1::vector::is_empty<NormieItem>(&arg1)) {
            let NormieItem {
                id               : v0,
                name             : _,
                url              : _,
                slot             : _,
                effect           : _,
                effect_magnitude : _,
            } = 0x1::vector::pop_back<NormieItem>(&mut arg1);
            0x2::object::delete(v0);
        };
        let v6 = Ticket{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<Ticket>(v6, 0x2::tx_context::sender(arg2));
        0x1::vector::destroy_empty<NormieItem>(arg1);
    }

    public entry fun buy_ticket<T0>(arg0: &mut ItemStore<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.price, 0);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v0 = Ticket{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<Ticket>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun buy_ticket_v2<T0>(arg0: &mut ItemStoreV2<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.price, 0);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v0 = Ticket{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<Ticket>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun collect_profits<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStore<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun collect_profits_v2<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStoreV2<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_store<T0>(arg0: &StoreOwnerCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ItemStore<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
            price   : arg1,
        };
        let v1 = SlotOptions{
            id      : 0x2::object::new(arg2),
            slot    : 1,
            options : 0x1::vector::empty<SlotOption>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, SlotOptions>(&mut v0.id, b"head", v1);
        let v2 = SlotOptions{
            id      : 0x2::object::new(arg2),
            slot    : 2,
            options : 0x1::vector::empty<SlotOption>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, SlotOptions>(&mut v0.id, b"body", v2);
        let v3 = SlotOptions{
            id      : 0x2::object::new(arg2),
            slot    : 3,
            options : 0x1::vector::empty<SlotOption>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, SlotOptions>(&mut v0.id, b"arms", v3);
        let v4 = SlotOptions{
            id      : 0x2::object::new(arg2),
            slot    : 4,
            options : 0x1::vector::empty<SlotOption>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, SlotOptions>(&mut v0.id, b"eyes", v4);
        let v5 = SlotOptions{
            id      : 0x2::object::new(arg2),
            slot    : 5,
            options : 0x1::vector::empty<SlotOption>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, SlotOptions>(&mut v0.id, b"mouth", v5);
        0x2::transfer::share_object<ItemStore<T0>>(v0);
    }

    public entry fun create_store_v2<T0>(arg0: &StoreOwnerCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ItemStoreV2<T0>{
            id          : 0x2::object::new(arg3),
            balance     : 0x2::balance::zero<T0>(),
            price       : arg1,
            burn_number : arg2,
            version     : 1,
            admin       : 0x2::object::id<StoreOwnerCap>(arg0),
        };
        let v1 = SlotOptionsV2{
            id      : 0x2::object::new(arg3),
            slot    : 1,
            images  : 0x1::vector::empty<SlotOptionImage>(),
            effects : 0x1::vector::empty<SlotOptionsEffect>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, SlotOptionsV2>(&mut v0.id, b"head", v1);
        let v2 = SlotOptionsV2{
            id      : 0x2::object::new(arg3),
            slot    : 2,
            images  : 0x1::vector::empty<SlotOptionImage>(),
            effects : 0x1::vector::empty<SlotOptionsEffect>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, SlotOptionsV2>(&mut v0.id, b"body", v2);
        let v3 = SlotOptionsV2{
            id      : 0x2::object::new(arg3),
            slot    : 3,
            images  : 0x1::vector::empty<SlotOptionImage>(),
            effects : 0x1::vector::empty<SlotOptionsEffect>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, SlotOptionsV2>(&mut v0.id, b"arms", v3);
        let v4 = SlotOptionsV2{
            id      : 0x2::object::new(arg3),
            slot    : 4,
            images  : 0x1::vector::empty<SlotOptionImage>(),
            effects : 0x1::vector::empty<SlotOptionsEffect>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, SlotOptionsV2>(&mut v0.id, b"eyes", v4);
        let v5 = SlotOptionsV2{
            id      : 0x2::object::new(arg3),
            slot    : 5,
            images  : 0x1::vector::empty<SlotOptionImage>(),
            effects : 0x1::vector::empty<SlotOptionsEffect>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, SlotOptionsV2>(&mut v0.id, b"mouth", v5);
        0x2::transfer::share_object<ItemStoreV2<T0>>(v0);
    }

    entry fun delete_slot_images_and_effects<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStoreV2<T0>, arg2: u8) {
        assert!(arg1.version == 1, 1);
        let v0 = b"mouth";
        if (arg2 == 1) {
            v0 = b"head";
        } else if (arg2 == 2) {
            v0 = b"body";
        } else if (arg2 == 3) {
            v0 = b"arms";
        } else if (arg2 == 4) {
            v0 = b"eyes";
        };
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, SlotOptionsV2>(&mut arg1.id, v0);
        v1.images = 0x1::vector::empty<SlotOptionImage>();
        v1.effects = 0x1::vector::empty<SlotOptionsEffect>();
    }

    fun destroy_ticket(arg0: Ticket) {
        let Ticket { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun get_options_effects_for_slot<T0>(arg0: &ItemStoreV2<T0>, arg1: u8) : &vector<SlotOptionsEffect> {
        if (arg1 == 1) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"head").effects
        } else if (arg1 == 2) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"body").effects
        } else if (arg1 == 3) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"arms").effects
        } else if (arg1 == 4) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"eyes").effects
        } else if (arg1 == 5) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"mouth").effects
        } else {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"head").effects
        }
    }

    fun get_options_images_for_slot<T0>(arg0: &ItemStoreV2<T0>, arg1: u8) : &vector<SlotOptionImage> {
        if (arg1 == 1) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"head").images
        } else if (arg1 == 2) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"body").images
        } else if (arg1 == 3) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"arms").images
        } else if (arg1 == 4) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"eyes").images
        } else if (arg1 == 5) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"mouth").images
        } else {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptionsV2>(&arg0.id, b"head").images
        }
    }

    fun get_slot(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100);
        let v2 = arithmetic_is_less_than(v1, 21, 100);
        let v3 = arithmetic_is_less_than(v1, 41, 100) * (1 - v2);
        let v4 = arithmetic_is_less_than(v1, 61, 100) * (1 - v2) * (1 - v3);
        let v5 = arithmetic_is_less_than(v1, 81, 100) * (1 - v2) * (1 - v3) * (1 - v4);
        v2 * 1 + v3 * 2 + (1 - v2) * (1 - v3) * (1 - v4) * (1 - v5) * 3 + v4 * 5 + v5 * 4
    }

    fun get_slot_option_effect(arg0: &mut 0x2::random::RandomGenerator, arg1: &vector<SlotOptionsEffect>) : &SlotOptionsEffect {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<SlotOptionsEffect>(arg1)) {
            let v2 = 0x1::vector::borrow<SlotOptionsEffect>(arg1, v1);
            v0 = v0 + v2.probability;
            if (arithmetic_is_less_than(0x2::random::generate_u8_in_range(arg0, 1, 100), v0, 100) == 1) {
                return v2
            };
            v1 = v1 + 1;
        };
        0x1::vector::borrow<SlotOptionsEffect>(arg1, 0)
    }

    fun get_slot_option_image(arg0: &mut 0x2::random::RandomGenerator, arg1: &vector<SlotOptionImage>) : &SlotOptionImage {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<SlotOptionImage>(arg1)) {
            let v2 = 0x1::vector::borrow<SlotOptionImage>(arg1, v1);
            v0 = v0 + v2.probability;
            if (arithmetic_is_less_than(0x2::random::generate_u8_in_range(arg0, 1, 100), v0, 100) == 1) {
                return v2
            };
            v1 = v1 + 1;
        };
        0x1::vector::borrow<SlotOptionImage>(arg1, 0)
    }

    public entry fun give_item<T0>(arg0: &StoreOwnerCap, arg1: &ItemStore<T0>, arg2: address, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun give_item_v2<T0>(arg0: &StoreOwnerCap, arg1: &ItemStoreV2<T0>, arg2: address, arg3: u8, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        let v0 = 0x1::vector::borrow<SlotOptionsEffect>(get_options_effects_for_slot<T0>(arg1, arg3), arg4);
        let v1 = 0x1::vector::borrow<SlotOptionImage>(get_options_images_for_slot<T0>(arg1, arg3), arg5);
        let v2 = 0x2::object::new(arg6);
        let v3 = ItemCreated{
            id   : 0x2::object::uid_to_inner(&v2),
            name : v1.name,
        };
        0x2::event::emit<ItemCreated>(v3);
        let v4 = NormieItem{
            id               : v2,
            name             : v1.name,
            url              : v1.url,
            slot             : arg3,
            effect           : v0.effect,
            effect_magnitude : v0.effect_magnitude,
        };
        0x2::transfer::public_transfer<NormieItem>(v4, arg2);
    }

    public entry fun give_ticket<T0>(arg0: &StoreOwnerCap, arg1: &ItemStore<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<Ticket>(v0, arg2);
    }

    public entry fun give_ticket_v2<T0>(arg0: &StoreOwnerCap, arg1: &ItemStoreV2<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<Ticket>(v0, arg2);
    }

    fun img_url(arg0: vector<u8>) : 0x2::url::Url {
        let v0 = b"https://normie-items.swaye.me/";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, b".png");
        0x2::url::new_unsafe_from_bytes(v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StoreOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<StoreOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate<T0>(arg0: &mut ItemStoreV2<T0>, arg1: &StoreOwnerCap) {
        assert!(arg0.admin == 0x2::object::id<StoreOwnerCap>(arg1), 2);
        assert!(arg0.version < 1, 3);
        arg0.version = 1;
    }

    entry fun redeem_ticket<T0>(arg0: Ticket, arg1: &ItemStoreV2<T0>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        destroy_ticket(arg0);
        let v0 = 0x2::object::new(arg3);
        let v1 = get_slot(arg2, arg3);
        let v2 = 0x2::random::new_generator(arg2, arg3);
        let v3 = 0x2::random::new_generator(arg2, arg3);
        let v4 = &mut v2;
        let v5 = get_slot_option_image(v4, get_options_images_for_slot<T0>(arg1, v1));
        let v6 = &mut v3;
        let v7 = get_slot_option_effect(v6, get_options_effects_for_slot<T0>(arg1, v1));
        let v8 = ItemCreated{
            id   : 0x2::object::uid_to_inner(&v0),
            name : v5.name,
        };
        0x2::event::emit<ItemCreated>(v8);
        let v9 = NormieItem{
            id               : v0,
            name             : v5.name,
            url              : v5.url,
            slot             : v1,
            effect           : v7.effect,
            effect_magnitude : v7.effect_magnitude,
        };
        0x2::transfer::public_transfer<NormieItem>(v9, 0x2::tx_context::sender(arg3));
    }

    public entry fun set_burn_number<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStoreV2<T0>, arg2: u64) {
        assert!(arg1.version == 1, 1);
        arg1.burn_number = arg2;
    }

    public entry fun set_price<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStore<T0>, arg2: u64) {
        arg1.price = arg2;
    }

    public entry fun set_price_v2<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStoreV2<T0>, arg2: u64) {
        arg1.price = arg2;
    }

    // decompiled from Move bytecode v6
}

