module 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_recipient: address,
        arbiter: address,
        review_ms: u64,
        pubkey: vector<u8>,
    }

    struct Menu<phantom T0> has key {
        id: 0x2::object::UID,
        seller: address,
        title: 0x1::string::String,
        handle: 0x1::string::String,
        names: vector<0x1::string::String>,
        prices: vector<u64>,
        kinds: vector<u8>,
        fee_free: vector<bool>,
        deadline_ms: u64,
        ad_tag: bool,
        orders: u64,
        done: u64,
        open: bool,
        version: u64,
    }

    struct Order<phantom T0> has key {
        id: 0x2::object::UID,
        menu: 0x2::object::ID,
        offer: u64,
        seller: address,
        buyer: address,
        kind: u8,
        fee_free: bool,
        waived: bool,
        amount: u64,
        escrow: 0x2::balance::Balance<T0>,
        brief: 0x1::string::String,
        proof: 0x1::string::String,
        reason: 0x1::string::String,
        status: u8,
        paid_ms: u64,
        deadline_ms: u64,
        delivered_ms: u64,
        review_ms: u64,
        version: u64,
    }

    struct MenuCreated has copy, drop {
        menu: 0x2::object::ID,
        seller: address,
        coin: 0x1::ascii::String,
    }

    struct OrderPaid has copy, drop {
        order: 0x2::object::ID,
        menu: 0x2::object::ID,
        buyer: address,
        seller: address,
        amount: u64,
    }

    struct OrderDelivered has copy, drop {
        order: 0x2::object::ID,
        proof: 0x1::string::String,
    }

    struct OrderDisputed has copy, drop {
        order: 0x2::object::ID,
        reason: 0x1::string::String,
    }

    struct OrderReleased has copy, drop {
        order: 0x2::object::ID,
        seller: address,
        seller_amount: u64,
        fee_amount: u64,
        how: u8,
    }

    struct OrderSplit has copy, drop {
        order: 0x2::object::ID,
        seller: address,
        seller_amount: u64,
        buyer: address,
        buyer_amount: u64,
    }

    struct OrderRefunded has copy, drop {
        order: 0x2::object::ID,
        buyer: address,
        amount: u64,
        how: u8,
    }

    struct VersionKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun approve<T0>(arg0: &Config, arg1: &mut Menu<T0>, arg2: &mut Order<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg2.buyer, 6);
        assert!(arg2.status == 0 || arg2.status == 1, 9);
        release<T0>(arg0, arg1, arg2, 1, arg3);
    }

    public fun arbiter(arg0: &Config) : address {
        assert_version(arg0);
        arg0.arbiter
    }

    public(friend) fun assert_version(arg0: &Config) {
        assert!(version(arg0) == 1, 900);
    }

    public fun buy<T0>(arg0: &Config, arg1: &mut Menu<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg1.open, 4);
        assert!(v0 != arg1.seller, 7);
        assert!(arg2 < 0x1::vector::length<0x1::string::String>(&arg1.names), 14);
        check_len(&arg4, 500, true);
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 == *0x1::vector::borrow<u64>(&arg1.prices, arg2), 3);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = Order<T0>{
            id           : 0x2::object::new(arg6),
            menu         : 0x2::object::id<Menu<T0>>(arg1),
            offer        : arg2,
            seller       : arg1.seller,
            buyer        : v0,
            kind         : *0x1::vector::borrow<u8>(&arg1.kinds, arg2),
            fee_free     : *0x1::vector::borrow<bool>(&arg1.fee_free, arg2),
            waived       : false,
            amount       : v1,
            escrow       : 0x2::coin::into_balance<T0>(arg3),
            brief        : arg4,
            proof        : 0x1::string::utf8(b""),
            reason       : 0x1::string::utf8(b""),
            status       : 0,
            paid_ms      : v2,
            deadline_ms  : v2 + arg1.deadline_ms,
            delivered_ms : 0,
            review_ms    : arg0.review_ms,
            version      : 1,
        };
        arg1.orders = arg1.orders + 1;
        let v4 = 0x2::object::id<Order<T0>>(&v3);
        let v5 = OrderPaid{
            order  : v4,
            menu   : v3.menu,
            buyer  : v0,
            seller : v3.seller,
            amount : v1,
        };
        0x2::event::emit<OrderPaid>(v5);
        0x2::transfer::share_object<Order<T0>>(v3);
        v4
    }

    fun check_len(arg0: &0x1::string::String, arg1: u64, arg2: bool) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 <= arg1 && (arg2 || v0 > 0), 8);
    }

    fun check_ticket(arg0: &Config, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg5) < arg4, 12);
        let v0 = ticket_message(arg1, arg2, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.pubkey, &v0), 12);
    }

    public fun create_menu<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<u8>, arg5: vector<bool>, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        let v1 = if (v0 > 0) {
            if (v0 <= 8) {
                if (0x1::vector::length<u64>(&arg3) == v0) {
                    if (0x1::vector::length<u8>(&arg4) == v0) {
                        0x1::vector::length<bool>(&arg5) == v0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        check_len(&arg0, 80, false);
        check_len(&arg1, 32, true);
        let v2 = 0;
        while (v2 < v0) {
            check_len(0x1::vector::borrow<0x1::string::String>(&arg2, v2), 80, false);
            assert!(*0x1::vector::borrow<u64>(&arg3, v2) > 0 && *0x1::vector::borrow<u8>(&arg4, v2) <= 2, 1);
            assert!(!*0x1::vector::borrow<bool>(&arg5, v2) || *0x1::vector::borrow<u8>(&arg4, v2) == 0, 1);
            v2 = v2 + 1;
        };
        assert!(arg6 >= 60000 && arg6 <= 5184000000, 15);
        let v3 = Menu<T0>{
            id          : 0x2::object::new(arg8),
            seller      : 0x2::tx_context::sender(arg8),
            title       : arg0,
            handle      : arg1,
            names       : arg2,
            prices      : arg3,
            kinds       : arg4,
            fee_free    : arg5,
            deadline_ms : arg6,
            ad_tag      : arg7,
            orders      : 0,
            done        : 0,
            open        : true,
            version     : 1,
        };
        let v4 = 0x2::object::id<Menu<T0>>(&v3);
        let v5 = MenuCreated{
            menu   : v4,
            seller : v3.seller,
            coin   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<MenuCreated>(v5);
        0x2::transfer::share_object<Menu<T0>>(v3);
        v4
    }

    public fun decline<T0>(arg0: &mut Order<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 5);
        assert!(arg0.status == 0 || arg0.status == 1, 9);
        refund<T0>(arg0, 0, arg1);
    }

    public fun dispute<T0>(arg0: &mut Order<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.buyer, 6);
        assert!(arg0.status == 1, 9);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.delivered_ms + arg0.review_ms, 10);
        check_len(&arg1, 500, false);
        arg0.reason = arg1;
        arg0.status = 2;
        let v0 = OrderDisputed{
            order  : 0x2::object::id<Order<T0>>(arg0),
            reason : arg1,
        };
        0x2::event::emit<OrderDisputed>(v0);
    }

    public(friend) fun dispute_timeout_ms() : u64 {
        1728000000
    }

    public fun escrow_value<T0>(arg0: &Order<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun fee_recipient(arg0: &Config) : address {
        assert_version(arg0);
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id            : 0x2::object::new(arg0),
            fee_bps       : 250,
            fee_recipient : v0,
            arbiter       : v0,
            review_ms     : 259200000,
            pubkey        : b"",
        };
        share_versioned_config(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun kind_post() : u8 {
        0
    }

    public fun kind_repost() : u8 {
        1
    }

    public fun mark_delivered<T0>(arg0: &mut Order<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 5);
        assert!(arg0.status == 0 || arg0.status == 1, 9);
        check_len(&arg1, 500, arg0.kind != 0);
        if (arg0.status == 0) {
            assert!(0x2::clock::timestamp_ms(arg2) < arg0.deadline_ms, 10);
            arg0.delivered_ms = 0x2::clock::timestamp_ms(arg2);
            arg0.status = 1;
        };
        arg0.proof = arg1;
        let v0 = OrderDelivered{
            order : 0x2::object::id<Order<T0>>(arg0),
            proof : arg1,
        };
        0x2::event::emit<OrderDelivered>(v0);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        let v0 = version(arg1);
        assert!(v0 < 1, 901);
        if (v0 == 0) {
            let v1 = VersionKey{dummy_field: false};
            0x2::dynamic_field::add<VersionKey, u64>(&mut arg1.id, v1, 1);
        } else {
            let v2 = VersionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<VersionKey, u64>(&mut arg1.id, v2) = 1;
        };
    }

    public fun quote(arg0: &Config, arg1: u64, arg2: bool) : (u64, u64) {
        assert_version(arg0);
        if (arg2) {
            return (arg1, 0)
        };
        let v0 = (((arg1 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        (arg1 - v0, v0)
    }

    fun refund<T0>(arg0: &mut Order<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg2), arg0.buyer);
        arg0.status = 4;
        let v0 = OrderRefunded{
            order  : 0x2::object::id<Order<T0>>(arg0),
            buyer  : arg0.buyer,
            amount : 0x2::balance::value<T0>(&arg0.escrow),
            how    : arg1,
        };
        0x2::event::emit<OrderRefunded>(v0);
    }

    public fun refund_timeout<T0>(arg0: &mut Order<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 9);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline_ms, 11);
        refund<T0>(arg0, 1, arg2);
    }

    fun release<T0>(arg0: &Config, arg1: &mut Menu<T0>, arg2: &mut Order<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.menu == 0x2::object::id<Menu<T0>>(arg1), 14);
        let v0 = if (arg2.waived) {
            true
        } else if (0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::exempt::is_exempt(arg2.seller)) {
            true
        } else {
            0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::exempt::is_exempt(arg2.buyer)
        };
        let (v1, v2) = quote(arg0, 0x2::balance::value<T0>(&arg2.escrow), v0);
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.escrow), arg4);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v2, arg4), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg2.seller);
        arg2.status = 3;
        arg1.done = arg1.done + 1;
        let v4 = OrderReleased{
            order         : 0x2::object::id<Order<T0>>(arg2),
            seller        : arg2.seller,
            seller_amount : v1,
            fee_amount    : v2,
            how           : arg3,
        };
        0x2::event::emit<OrderReleased>(v4);
    }

    public fun release_after_window<T0>(arg0: &Config, arg1: &mut Menu<T0>, arg2: &mut Order<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg2.status == 1, 9);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.delivered_ms + arg2.review_ms, 11);
        release<T0>(arg0, arg1, arg2, 2, arg4);
    }

    public fun release_with_sig<T0>(arg0: &Config, arg1: &mut Menu<T0>, arg2: &mut Order<T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg2.status == 1 && arg2.kind == 0, 9);
        check_ticket(arg0, b"tapdrop-shoutout-release", 0x2::object::id<Order<T0>>(arg2), arg3, arg4, arg5);
        release<T0>(arg0, arg1, arg2, 0, arg6);
    }

    public fun resolve<T0>(arg0: &Config, arg1: &mut Menu<T0>, arg2: &mut Order<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.arbiter, 13);
        assert!(arg2.status == 2, 9);
        if (arg3) {
            release<T0>(arg0, arg1, arg2, 3, arg4);
        } else {
            refund<T0>(arg2, 2, arg4);
        };
    }

    public fun review_ms(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.review_ms
    }

    public fun set_arbiter(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert_version(arg1);
        arg1.arbiter = arg2;
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 <= 500, 2);
        arg1.fee_bps = arg2;
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert_version(arg1);
        arg1.fee_recipient = arg2;
    }

    public fun set_open<T0>(arg0: &mut Menu<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 5);
        arg0.open = arg1;
    }

    public fun set_pubkey(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        assert_version(arg1);
        arg1.pubkey = arg2;
    }

    public fun set_review_ms(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 >= 60000 && arg2 <= 5184000000, 15);
        arg1.review_ms = arg2;
    }

    fun share_versioned_config(arg0: Config) {
        let v0 = VersionKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<VersionKey>(&arg0.id, v0)) {
            let v1 = VersionKey{dummy_field: false};
            0x2::dynamic_field::add<VersionKey, u64>(&mut arg0.id, v1, 1);
        };
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun split_after_dispute_timeout<T0>(arg0: &mut Menu<T0>, arg1: &mut Order<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 2, 9);
        assert!(arg1.menu == 0x2::object::id<Menu<T0>>(arg0), 14);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.delivered_ms + arg1.review_ms + 1728000000, 11);
        let v0 = &mut arg1.escrow;
        let (v1, v2) = split_timeout<T0>(v0, arg3);
        let v3 = v2;
        let v4 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, arg1.seller);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg1.buyer);
        arg1.status = 5;
        arg0.done = arg0.done + 1;
        let v5 = OrderSplit{
            order         : 0x2::object::id<Order<T0>>(arg1),
            seller        : arg1.seller,
            seller_amount : 0x2::coin::value<T0>(&v4),
            buyer         : arg1.buyer,
            buyer_amount  : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<OrderSplit>(v5);
    }

    public(friend) fun split_timeout<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, (((0x2::balance::value<T0>(arg0) as u128) * (5000 as u128) / 10000) as u64)), arg1), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1))
    }

    public fun status<T0>(arg0: &Order<T0>) : u8 {
        arg0.status
    }

    public fun ticket_message(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: u64) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut arg0, 0x2::bcs::to_bytes<u64>(&arg2));
        arg0
    }

    public(friend) fun verify_sig(arg0: &Config, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(&arg2, &arg0.pubkey, &arg1)
    }

    public fun version(arg0: &Config) : u64 {
        let v0 = VersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<VersionKey>(&arg0.id, v0)) {
            let v2 = VersionKey{dummy_field: false};
            *0x2::dynamic_field::borrow<VersionKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun waive_with_sig<T0>(arg0: &Config, arg1: &mut Order<T0>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(arg1.fee_free, 16);
        let v0 = if (arg1.status == 0) {
            true
        } else if (arg1.status == 1) {
            true
        } else {
            arg1.status == 2
        };
        assert!(v0, 9);
        check_ticket(arg0, b"tapdrop-shoutout-waive", 0x2::object::id<Order<T0>>(arg1), arg2, arg3, arg4);
        arg1.waived = true;
    }

    public fun waived<T0>(arg0: &Order<T0>) : bool {
        arg0.waived
    }

    // decompiled from Move bytecode v7
}

