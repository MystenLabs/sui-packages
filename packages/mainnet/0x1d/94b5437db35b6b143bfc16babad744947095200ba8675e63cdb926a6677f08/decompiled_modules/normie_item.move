module 0x8080ec446284b2e129b116843dc4b0dced9f98eb1805c11585a9b4c601fc5e2::normie_item {
    struct Ticket has store, key {
        id: 0x2::object::UID,
    }

    struct ItemStore<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        price: u64,
    }

    struct SlotOption has copy, drop, store {
        slot: u8,
        effect: 0x1::string::String,
        effect_magnitude: u64,
        name: 0x1::string::String,
        probability: u8,
        url: 0x2::url::Url,
    }

    struct SlotOptions has store, key {
        id: 0x2::object::UID,
        slot: u8,
        options: vector<SlotOption>,
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

    entry fun add_option<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStore<T0>, arg2: u8, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u8) {
        let v0 = SlotOption{
            slot             : arg2,
            effect           : 0x1::string::utf8(arg3),
            effect_magnitude : arg4,
            name             : 0x1::string::utf8(arg5),
            probability      : arg6,
            url              : img_url(arg5),
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
        0x1::vector::push_back<SlotOption>(&mut 0x2::dynamic_object_field::borrow_mut<vector<u8>, SlotOptions>(&mut arg1.id, v1).options, v0);
    }

    fun arithmetic_is_less_than(arg0: u8, arg1: u8, arg2: u8) : u8 {
        assert!(arg2 >= arg1 && arg1 > 0, 0);
        let v0 = arg2 / arg1;
        (v0 - arg0 / arg1) / v0
    }

    public entry fun buy_ticket<T0>(arg0: &mut ItemStore<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.price, 0);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v0 = Ticket{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<Ticket>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun collect_profits<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStore<T0>, arg2: &mut 0x2::tx_context::TxContext) {
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

    entry fun delete_slot_option<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStore<T0>, arg2: u8) {
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
        0x2::dynamic_object_field::borrow_mut<vector<u8>, SlotOptions>(&mut arg1.id, v0).options = 0x1::vector::empty<SlotOption>();
    }

    fun destroy_ticket(arg0: Ticket) {
        let Ticket { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun get_options_for_slot<T0>(arg0: &ItemStore<T0>, arg1: u8) : &vector<SlotOption> {
        if (arg1 == 1) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptions>(&arg0.id, b"head").options
        } else if (arg1 == 2) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptions>(&arg0.id, b"body").options
        } else if (arg1 == 3) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptions>(&arg0.id, b"arms").options
        } else if (arg1 == 4) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptions>(&arg0.id, b"eyes").options
        } else if (arg1 == 5) {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptions>(&arg0.id, b"mouth").options
        } else {
            &0x2::dynamic_object_field::borrow<vector<u8>, SlotOptions>(&arg0.id, b"head").options
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

    fun get_slot_option(arg0: &0x2::random::Random, arg1: &vector<SlotOption>, arg2: &mut 0x2::tx_context::TxContext) : &SlotOption {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<SlotOption>(arg1)) {
            let v3 = 0x1::vector::borrow<SlotOption>(arg1, v2);
            v1 = v1 + v3.probability;
            if (arithmetic_is_less_than(0x2::random::generate_u8_in_range(&mut v0, 1, 100), v1, 100) == 1) {
                return v3
            };
            v2 = v2 + 1;
        };
        0x1::vector::borrow<SlotOption>(arg1, 0)
    }

    public entry fun give_item<T0>(arg0: &StoreOwnerCap, arg1: &ItemStore<T0>, arg2: address, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow<SlotOption>(get_options_for_slot<T0>(arg1, arg3), arg4);
        let v1 = 0x2::object::new(arg5);
        let v2 = ItemCreated{
            id   : 0x2::object::uid_to_inner(&v1),
            name : v0.name,
        };
        0x2::event::emit<ItemCreated>(v2);
        let v3 = NormieItem{
            id               : v1,
            name             : v0.name,
            url              : v0.url,
            slot             : arg3,
            effect           : v0.effect,
            effect_magnitude : v0.effect_magnitude,
        };
        0x2::transfer::public_transfer<NormieItem>(v3, arg2);
    }

    public entry fun give_ticket<T0>(arg0: &StoreOwnerCap, arg1: &ItemStore<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
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

    entry fun redeem_ticket<T0>(arg0: Ticket, arg1: &ItemStore<T0>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        destroy_ticket(arg0);
        let v0 = 0x2::object::new(arg3);
        let v1 = get_slot(arg2, arg3);
        let v2 = get_slot_option(arg2, get_options_for_slot<T0>(arg1, v1), arg3);
        let v3 = ItemCreated{
            id   : 0x2::object::uid_to_inner(&v0),
            name : v2.name,
        };
        0x2::event::emit<ItemCreated>(v3);
        let v4 = NormieItem{
            id               : v0,
            name             : v2.name,
            url              : v2.url,
            slot             : v1,
            effect           : v2.effect,
            effect_magnitude : v2.effect_magnitude,
        };
        0x2::transfer::public_transfer<NormieItem>(v4, 0x2::tx_context::sender(arg3));
    }

    public entry fun set_price<T0>(arg0: &StoreOwnerCap, arg1: &mut ItemStore<T0>, arg2: u64) {
        arg1.price = arg2;
    }

    // decompiled from Move bytecode v6
}

