module 0xcd0f021a76678ac50d49f6bb83d4c393321a506bc18b5c42720b37a5b2465bc4::access {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SubscriptionCap has key {
        id: 0x2::object::UID,
        subscriber: address,
    }

    struct InboxSettings has key {
        id: 0x2::object::UID,
        owner: address,
        min_payment: u64,
        show_price: bool,
    }

    struct Whitelist has key {
        id: 0x2::object::UID,
        owner: address,
        allowed: 0x2::vec_set::VecSet<address>,
    }

    struct ACCESS has drop {
        dummy_field: bool,
    }

    public entry fun create_settings(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1000000, 3);
        let v0 = InboxSettings{
            id          : 0x2::object::new(arg1),
            owner       : 0x2::tx_context::sender(arg1),
            min_payment : arg0,
            show_price  : true,
        };
        0x2::transfer::transfer<InboxSettings>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_whitelist(arg0: &SubscriptionCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Whitelist{
            id      : 0x2::object::new(arg1),
            owner   : 0x2::tx_context::sender(arg1),
            allowed : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::transfer<Whitelist>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: ACCESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_whitelisted(arg0: &Whitelist, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.allowed, &arg1)
    }

    public entry fun issue_subscription(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SubscriptionCap{
            id         : 0x2::object::new(arg2),
            subscriber : arg1,
        };
        0x2::transfer::transfer<SubscriptionCap>(v0, arg1);
    }

    public fun max_whitelist_size() : u64 {
        200
    }

    public fun min_payment(arg0: &InboxSettings) : u64 {
        arg0.min_payment
    }

    public entry fun set_min_payment(arg0: &mut InboxSettings, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(arg1 >= 1000000, 3);
        arg0.min_payment = arg1;
    }

    public entry fun set_show_price(arg0: &mut InboxSettings, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.show_price = arg1;
    }

    public fun subscription_holder(arg0: &SubscriptionCap) : address {
        arg0.subscriber
    }

    public entry fun whitelist_add(arg0: &mut Whitelist, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        if (!0x2::vec_set::contains<address>(&arg0.allowed, &arg1)) {
            assert!(0x2::vec_set::length<address>(&arg0.allowed) < 200, 1);
            0x2::vec_set::insert<address>(&mut arg0.allowed, arg1);
        };
    }

    public entry fun whitelist_remove(arg0: &mut Whitelist, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_set::contains<address>(&arg0.allowed, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.allowed, &arg1);
        };
    }

    public fun whitelist_size(arg0: &Whitelist) : u64 {
        0x2::vec_set::length<address>(&arg0.allowed)
    }

    // decompiled from Move bytecode v6
}

