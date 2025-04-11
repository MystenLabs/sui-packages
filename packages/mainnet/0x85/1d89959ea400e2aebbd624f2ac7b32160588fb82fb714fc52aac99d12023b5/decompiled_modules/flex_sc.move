module 0x851d89959ea400e2aebbd624f2ac7b32160588fb82fb714fc52aac99d12023b5::flex_sc {
    struct FLEX_SC has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FlexCard has store, key {
        id: 0x2::object::UID,
        card_type: u8,
        message: 0x1::string::String,
        created_epoch: u64,
        amount_paid: u64,
    }

    struct CardInfo has copy, drop, store {
        id: address,
        card_type: u8,
        message: 0x1::string::String,
        created_epoch: u64,
        amount_paid: u64,
        owner: address,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        cards_created: vector<address>,
        card_details: vector<CardInfo>,
        admin: address,
    }

    struct FlexCardCreated has copy, drop {
        card_id: address,
        creator: address,
        card_type: u8,
        message: 0x1::string::String,
        amount_paid: u64,
        created_epoch: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        admin: address,
    }

    public entry fun claim(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 3);
        let v0 = FeesWithdrawn{
            amount : arg2,
            admin  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeesWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun buy_flex(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 100000000 && v0 <= 20000000000, 0);
        assert!(arg2 >= 1 && arg2 <= 4, 1);
        let v1 = 0x1::string::utf8(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v3 = FlexCard{
            id            : 0x2::object::new(arg5),
            card_type     : arg2,
            message       : v1,
            created_epoch : v2,
            amount_paid   : v0,
        };
        let v4 = 0x2::object::uid_to_address(&v3.id);
        0x1::vector::push_back<address>(&mut arg0.cards_created, v4);
        let v5 = 0x2::tx_context::sender(arg5);
        let v6 = CardInfo{
            id            : v4,
            card_type     : arg2,
            message       : v1,
            created_epoch : v2,
            amount_paid   : v0,
            owner         : v5,
        };
        0x1::vector::push_back<CardInfo>(&mut arg0.card_details, v6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v7 = FlexCardCreated{
            card_id       : v4,
            creator       : v5,
            card_type     : arg2,
            message       : v1,
            amount_paid   : v0,
            created_epoch : v2,
        };
        0x2::event::emit<FlexCardCreated>(v7);
        0x2::transfer::transfer<FlexCard>(v3, v5);
    }

    fun init(arg0: FLEX_SC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<FLEX_SC>(arg0, arg1), v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = Treasury{
            id            : 0x2::object::new(arg1),
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            cards_created : 0x1::vector::empty<address>(),
            card_details  : 0x1::vector::empty<CardInfo>(),
            admin         : v0,
        };
        0x2::transfer::share_object<Treasury>(v2);
    }

    public fun view_admin(arg0: &Treasury) : address {
        arg0.admin
    }

    public fun view_all_card_details(arg0: &Treasury) : vector<CardInfo> {
        arg0.card_details
    }

    public fun view_all_cards(arg0: &Treasury) : vector<address> {
        arg0.cards_created
    }

    public fun view_cards_by_owner(arg0: &Treasury, arg1: address) : vector<CardInfo> {
        let v0 = 0x1::vector::empty<CardInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<CardInfo>(&arg0.card_details)) {
            let v2 = 0x1::vector::borrow<CardInfo>(&arg0.card_details, v1);
            if (v2.owner == arg1) {
                0x1::vector::push_back<CardInfo>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun view_cards_by_type(arg0: &Treasury, arg1: u8) : vector<CardInfo> {
        let v0 = 0x1::vector::empty<CardInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<CardInfo>(&arg0.card_details)) {
            let v2 = 0x1::vector::borrow<CardInfo>(&arg0.card_details, v1);
            if (v2.card_type == arg1) {
                0x1::vector::push_back<CardInfo>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun view_flex_card(arg0: &FlexCard) : (u8, 0x1::string::String, u64, u64) {
        (arg0.card_type, arg0.message, arg0.created_epoch, arg0.amount_paid)
    }

    public fun view_recent_cards(arg0: &Treasury, arg1: u64) : vector<CardInfo> {
        let v0 = 0x1::vector::empty<CardInfo>();
        let v1 = 0x1::vector::length<CardInfo>(&arg0.card_details);
        if (arg1 >= v1) {
            return arg0.card_details
        };
        let v2 = v1 - arg1;
        while (v2 < v1) {
            0x1::vector::push_back<CardInfo>(&mut v0, *0x1::vector::borrow<CardInfo>(&arg0.card_details, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun view_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    // decompiled from Move bytecode v6
}

