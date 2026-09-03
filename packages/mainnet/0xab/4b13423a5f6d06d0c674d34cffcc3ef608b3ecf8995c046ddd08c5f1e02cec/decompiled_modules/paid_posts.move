module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::paid_posts {
    struct PostPaywall<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        feed: 0x2::object::ID,
        post_id: u64,
        author: address,
        recipient: address,
        price: u64,
        active: bool,
        purchases: 0x2::table::Table<address, u64>,
        purchase_count: u64,
    }

    struct PaywallCreated has copy, drop {
        paywall: 0x2::object::ID,
        feed: 0x2::object::ID,
        post_id: u64,
        price: u64,
    }

    struct PostPurchased has copy, drop {
        paywall: 0x2::object::ID,
        feed: 0x2::object::ID,
        post_id: u64,
        buyer: address,
        amount: u64,
        fee: u64,
        content_uri: 0x1::string::String,
    }

    struct PaywallPriceChanged has copy, drop {
        paywall: 0x2::object::ID,
        price: u64,
    }

    struct PaywallActiveChanged has copy, drop {
        paywall: 0x2::object::ID,
        active: bool,
    }

    struct PaywallRecipientChanged has copy, drop {
        paywall: 0x2::object::ID,
        recipient: address,
    }

    fun assert_author<T0>(arg0: &PostPaywall<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.author == 0x2::tx_context::sender(arg1), 0);
    }

    fun assert_version<T0>(arg0: &PostPaywall<T0>) {
        assert!(arg0.version == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 8);
    }

    public fun author<T0>(arg0: &PostPaywall<T0>) : address {
        arg0.author
    }

    public fun create<T0>(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::Feed, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        assert!(0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::post_exists(arg0, arg1), 1);
        let v0 = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::post(arg0, arg1);
        assert!(0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::post_author(&v0) == 0x2::tx_context::sender(arg3), 0);
        let v1 = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::post_reposted(&v0);
        assert!(0x1::option::is_none<u64>(&v1), 7);
        let v2 = PostPaywall<T0>{
            id             : 0x2::object::new(arg3),
            version        : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(),
            feed           : 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::Feed>(arg0),
            post_id        : arg1,
            author         : 0x2::tx_context::sender(arg3),
            recipient      : 0x2::tx_context::sender(arg3),
            price          : arg2,
            active         : true,
            purchases      : 0x2::table::new<address, u64>(arg3),
            purchase_count : 0,
        };
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::register_paywall(arg0, arg1, 0x2::object::id<PostPaywall<T0>>(&v2));
        let v3 = PaywallCreated{
            paywall : 0x2::object::id<PostPaywall<T0>>(&v2),
            feed    : 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::Feed>(arg0),
            post_id : arg1,
            price   : arg2,
        };
        0x2::event::emit<PaywallCreated>(v3);
        0x2::transfer::share_object<PostPaywall<T0>>(v2);
    }

    public fun has_purchased<T0>(arg0: &PostPaywall<T0>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.purchases, arg1)
    }

    public fun is_open<T0>(arg0: &PostPaywall<T0>) : bool {
        arg0.active
    }

    public fun migrate<T0>(arg0: &mut PostPaywall<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_author<T0>(arg0, arg1);
        assert!(arg0.version < 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 9);
        arg0.version = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version();
    }

    public fun post_id<T0>(arg0: &PostPaywall<T0>) : u64 {
        arg0.post_id
    }

    public fun price<T0>(arg0: &PostPaywall<T0>) : u64 {
        arg0.price
    }

    public fun purchase<T0>(arg0: &mut PostPaywall<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::FeeConfig, arg2: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::Feed, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg0.feed == 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::Feed>(arg2), 2);
        assert!(arg0.active, 3);
        assert!(arg0.price == arg3, 10);
        assert!(0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::post_exists(arg2, arg0.post_id), 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != arg0.author, 5);
        assert!(!0x2::table::contains<address, u64>(&arg0.purchases, v0), 4);
        0x2::table::add<address, u64>(&mut arg0.purchases, v0, arg0.price);
        arg0.purchase_count = arg0.purchase_count + 1;
        let v1 = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::post(arg2, arg0.post_id);
        let v2 = PostPurchased{
            paywall     : 0x2::object::id<PostPaywall<T0>>(arg0),
            feed        : arg0.feed,
            post_id     : arg0.post_id,
            buyer       : v0,
            amount      : arg0.price,
            fee         : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::collect<T0>(arg1, arg4, arg0.price, arg0.recipient, arg5),
            content_uri : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed::post_content_uri(&v1),
        };
        0x2::event::emit<PostPurchased>(v2);
    }

    public fun purchase_count<T0>(arg0: &PostPaywall<T0>) : u64 {
        arg0.purchase_count
    }

    public fun recipient<T0>(arg0: &PostPaywall<T0>) : address {
        arg0.recipient
    }

    public fun set_active<T0>(arg0: &mut PostPaywall<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_author<T0>(arg0, arg2);
        arg0.active = arg1;
        let v0 = PaywallActiveChanged{
            paywall : 0x2::object::id<PostPaywall<T0>>(arg0),
            active  : arg1,
        };
        0x2::event::emit<PaywallActiveChanged>(v0);
    }

    public fun set_price<T0>(arg0: &mut PostPaywall<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_author<T0>(arg0, arg2);
        assert!(arg1 > 0, 6);
        arg0.price = arg1;
        let v0 = PaywallPriceChanged{
            paywall : 0x2::object::id<PostPaywall<T0>>(arg0),
            price   : arg1,
        };
        0x2::event::emit<PaywallPriceChanged>(v0);
    }

    public fun set_recipient<T0>(arg0: &mut PostPaywall<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_author<T0>(arg0, arg2);
        arg0.recipient = arg1;
        let v0 = PaywallRecipientChanged{
            paywall   : 0x2::object::id<PostPaywall<T0>>(arg0),
            recipient : arg1,
        };
        0x2::event::emit<PaywallRecipientChanged>(v0);
    }

    public fun version<T0>(arg0: &PostPaywall<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

