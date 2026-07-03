module 0x535639b192b85666eedaa2a346777c5f21ece686eaf74bfff76c76c2df8c5ce0::access {
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

    struct SubscriptionIssued has copy, drop {
        subscriber: address,
    }

    struct InboxSettingsCreated has copy, drop {
        owner: address,
        min_payment: u64,
    }

    struct MinPaymentUpdated has copy, drop {
        owner: address,
        min_payment: u64,
    }

    struct ShowPriceUpdated has copy, drop {
        owner: address,
        show_price: bool,
    }

    struct WhitelistCreated has copy, drop {
        owner: address,
    }

    struct WhitelistAddressAdded has copy, drop {
        owner: address,
        added: address,
    }

    struct WhitelistAddressRemoved has copy, drop {
        owner: address,
        removed: address,
    }

    struct ACCESS has drop {
        dummy_field: bool,
    }

    public entry fun create_settings(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1000000, 3);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = InboxSettings{
            id          : 0x2::object::new(arg1),
            owner       : v0,
            min_payment : arg0,
            show_price  : true,
        };
        0x2::transfer::transfer<InboxSettings>(v1, v0);
        let v2 = InboxSettingsCreated{
            owner       : v0,
            min_payment : arg0,
        };
        0x2::event::emit<InboxSettingsCreated>(v2);
    }

    public entry fun create_whitelist(arg0: &SubscriptionCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Whitelist{
            id      : 0x2::object::new(arg1),
            owner   : v0,
            allowed : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::transfer<Whitelist>(v1, v0);
        let v2 = WhitelistCreated{owner: v0};
        0x2::event::emit<WhitelistCreated>(v2);
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
        let v1 = SubscriptionIssued{subscriber: arg1};
        0x2::event::emit<SubscriptionIssued>(v1);
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
        let v0 = MinPaymentUpdated{
            owner       : arg0.owner,
            min_payment : arg1,
        };
        0x2::event::emit<MinPaymentUpdated>(v0);
    }

    public entry fun set_show_price(arg0: &mut InboxSettings, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.show_price = arg1;
        let v0 = ShowPriceUpdated{
            owner      : arg0.owner,
            show_price : arg1,
        };
        0x2::event::emit<ShowPriceUpdated>(v0);
    }

    public fun subscription_holder(arg0: &SubscriptionCap) : address {
        arg0.subscriber
    }

    public entry fun whitelist_add(arg0: &mut Whitelist, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        if (!0x2::vec_set::contains<address>(&arg0.allowed, &arg1)) {
            assert!(0x2::vec_set::length<address>(&arg0.allowed) < 200, 1);
            0x2::vec_set::insert<address>(&mut arg0.allowed, arg1);
            let v0 = WhitelistAddressAdded{
                owner : arg0.owner,
                added : arg1,
            };
            0x2::event::emit<WhitelistAddressAdded>(v0);
        };
    }

    public entry fun whitelist_remove(arg0: &mut Whitelist, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_set::contains<address>(&arg0.allowed, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.allowed, &arg1);
            let v0 = WhitelistAddressRemoved{
                owner   : arg0.owner,
                removed : arg1,
            };
            0x2::event::emit<WhitelistAddressRemoved>(v0);
        };
    }

    public fun whitelist_size(arg0: &Whitelist) : u64 {
        0x2::vec_set::length<address>(&arg0.allowed)
    }

    // decompiled from Move bytecode v7
}

