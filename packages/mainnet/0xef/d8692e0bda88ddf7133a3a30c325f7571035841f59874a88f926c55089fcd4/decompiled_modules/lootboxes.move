module 0xefd8692e0bda88ddf7133a3a30c325f7571035841f59874a88f926c55089fcd4::lootboxes {
    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        mystery_box_price: u64,
        silver_box_price: u64,
        gold_box_price: u64,
        diamond_box_price: u64,
        treasury_address: address,
        purchases_paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LootboxPurchaseEvent has copy, drop {
        buyer: address,
        lootbox_type: 0x1::string::String,
        price: u64,
        quantity: u64,
        total_amount: u64,
    }

    fun check_version(arg0: &Store) {
        assert!(arg0.version == 1, 3);
    }

    public fun get_diamond_box_price(arg0: &Store) : u64 {
        arg0.diamond_box_price
    }

    public fun get_gold_box_price(arg0: &Store) : u64 {
        arg0.gold_box_price
    }

    public fun get_mystery_box_price(arg0: &Store) : u64 {
        arg0.mystery_box_price
    }

    public fun get_silver_box_price(arg0: &Store) : u64 {
        arg0.silver_box_price
    }

    public fun get_treasury_address(arg0: &Store) : address {
        arg0.treasury_address
    }

    public fun get_version(arg0: &Store) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id                : 0x2::object::new(arg0),
            version           : 1,
            mystery_box_price : 1000000000,
            silver_box_price  : 30000000000,
            gold_box_price    : 75000000000,
            diamond_box_price : 200000000000,
            treasury_address  : @0xa3585953487cf72b94233df0895ae7f6bb05c873772f6ad956dac9cafb946d5d,
            purchases_paused  : false,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Store>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_purchases_paused(arg0: &Store) : bool {
        arg0.purchases_paused
    }

    public entry fun pause_purchases(arg0: &AdminCap, arg1: &mut Store) {
        check_version(arg1);
        arg1.purchases_paused = true;
    }

    public fun purchase_diamond_box(arg0: &mut Store, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.purchases_paused, 2);
        let v0 = arg0.diamond_box_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg3), arg0.treasury_address);
        let v1 = LootboxPurchaseEvent{
            buyer        : 0x2::tx_context::sender(arg3),
            lootbox_type : 0x1::string::utf8(b"diamond"),
            price        : arg0.diamond_box_price,
            quantity     : arg2,
            total_amount : v0,
        };
        0x2::event::emit<LootboxPurchaseEvent>(v1);
    }

    public fun purchase_gold_box(arg0: &mut Store, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.purchases_paused, 2);
        let v0 = arg0.gold_box_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg3), arg0.treasury_address);
        let v1 = LootboxPurchaseEvent{
            buyer        : 0x2::tx_context::sender(arg3),
            lootbox_type : 0x1::string::utf8(b"gold"),
            price        : arg0.gold_box_price,
            quantity     : arg2,
            total_amount : v0,
        };
        0x2::event::emit<LootboxPurchaseEvent>(v1);
    }

    public fun purchase_mystery_box(arg0: &mut Store, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.purchases_paused, 2);
        let v0 = arg0.mystery_box_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg3), arg0.treasury_address);
        let v1 = LootboxPurchaseEvent{
            buyer        : 0x2::tx_context::sender(arg3),
            lootbox_type : 0x1::string::utf8(b"mystery"),
            price        : arg0.mystery_box_price,
            quantity     : arg2,
            total_amount : v0,
        };
        0x2::event::emit<LootboxPurchaseEvent>(v1);
    }

    public fun purchase_silver_box(arg0: &mut Store, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.purchases_paused, 2);
        let v0 = arg0.silver_box_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg3), arg0.treasury_address);
        let v1 = LootboxPurchaseEvent{
            buyer        : 0x2::tx_context::sender(arg3),
            lootbox_type : 0x1::string::utf8(b"silver"),
            price        : arg0.silver_box_price,
            quantity     : arg2,
            total_amount : v0,
        };
        0x2::event::emit<LootboxPurchaseEvent>(v1);
    }

    public entry fun resume_purchases(arg0: &AdminCap, arg1: &mut Store) {
        check_version(arg1);
        arg1.purchases_paused = false;
    }

    public entry fun update_diamond_box_price(arg0: &AdminCap, arg1: &mut Store, arg2: u64) {
        check_version(arg1);
        arg1.diamond_box_price = arg2;
    }

    public entry fun update_gold_box_price(arg0: &AdminCap, arg1: &mut Store, arg2: u64) {
        check_version(arg1);
        arg1.gold_box_price = arg2;
    }

    public entry fun update_mystery_box_price(arg0: &AdminCap, arg1: &mut Store, arg2: u64) {
        check_version(arg1);
        arg1.mystery_box_price = arg2;
    }

    public entry fun update_silver_box_price(arg0: &AdminCap, arg1: &mut Store, arg2: u64) {
        check_version(arg1);
        arg1.silver_box_price = arg2;
    }

    public entry fun update_treasury_address(arg0: &AdminCap, arg1: &mut Store, arg2: address) {
        check_version(arg1);
        arg1.treasury_address = arg2;
    }

    public entry fun update_version(arg0: &AdminCap, arg1: &mut Store, arg2: u64) {
        check_version(arg1);
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

