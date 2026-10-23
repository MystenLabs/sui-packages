module 0x6a5e43b04523f8acf9cd5a07c0868eb37d549a947d78a4f9628f2ec34b5e54fd::paywall {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct Post<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        price: u64,
        record: 0x1::string::String,
        unlocks: u64,
        open: bool,
        buyers: 0x2::table::Table<address, bool>,
        version: u64,
    }

    struct PostCreated has copy, drop {
        post: 0x2::object::ID,
        creator: address,
        price: u64,
        coin: 0x1::ascii::String,
    }

    struct Unlocked has copy, drop {
        post: 0x2::object::ID,
        buyer: address,
        creator: address,
        amount: u64,
        creator_amount: u64,
        fee_amount: u64,
    }

    struct PostUpdated has copy, drop {
        post: 0x2::object::ID,
        price: u64,
        open: bool,
    }

    fun check_record(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        assert!(0x1::vector::length<u8>(v0) > 0 && 0x1::vector::length<u8>(v0) <= 128, 8);
    }

    public fun create<T0>(arg0: u64, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0 > 0, 1);
        check_record(&arg1);
        let v0 = Post<T0>{
            id      : 0x2::object::new(arg2),
            creator : 0x2::tx_context::sender(arg2),
            price   : arg0,
            record  : arg1,
            unlocks : 0,
            open    : true,
            buyers  : 0x2::table::new<address, bool>(arg2),
            version : 1,
        };
        let v1 = 0x2::object::id<Post<T0>>(&v0);
        let v2 = PostCreated{
            post    : v1,
            creator : v0.creator,
            price   : arg0,
            coin    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<PostCreated>(v2);
        0x2::transfer::share_object<Post<T0>>(v0);
        v1
    }

    public fun creator<T0>(arg0: &Post<T0>) : address {
        arg0.creator
    }

    public fun fee_bps(arg0: &FeeConfig) : u64 {
        arg0.fee_bps
    }

    public fun fee_recipient(arg0: &FeeConfig) : address {
        arg0.fee_recipient
    }

    public fun has_access<T0>(arg0: &Post<T0>, arg1: address) : bool {
        arg1 == arg0.creator || 0x2::table::contains<address, bool>(&arg0.buyers, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = FeeConfig{
            id            : 0x2::object::new(arg0),
            fee_bps       : 250,
            fee_recipient : v0,
        };
        0x2::transfer::share_object<FeeConfig>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun is_open<T0>(arg0: &Post<T0>) : bool {
        arg0.open
    }

    public fun price<T0>(arg0: &Post<T0>) : u64 {
        arg0.price
    }

    public fun quote(arg0: &FeeConfig, arg1: u64) : (u64, u64) {
        let v0 = (((arg1 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        (arg1 - v0, v0)
    }

    public fun record<T0>(arg0: &Post<T0>) : 0x1::string::String {
        arg0.record
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64) {
        assert!(arg2 <= 500, 2);
        arg1.fee_bps = arg2;
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public fun unlock<T0>(arg0: &FeeConfig, arg1: &mut Post<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.open, 4);
        assert!(v0 != arg1.creator, 7);
        assert!(!0x2::table::contains<address, bool>(&arg1.buyers, v0), 5);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 == arg1.price, 3);
        let (v2, v3) = quote(arg0, v1);
        let (v4, v5) = if (0x6a5e43b04523f8acf9cd5a07c0868eb37d549a947d78a4f9628f2ec34b5e54fd::exempt::is_exempt(v0) || 0x6a5e43b04523f8acf9cd5a07c0868eb37d549a947d78a4f9628f2ec34b5e54fd::exempt::is_exempt(arg1.creator)) {
            (v2 + v3, 0)
        } else {
            (v2, v3)
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v5, arg3), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1.creator);
        0x2::table::add<address, bool>(&mut arg1.buyers, v0, true);
        arg1.unlocks = arg1.unlocks + 1;
        let v6 = Unlocked{
            post           : 0x2::object::id<Post<T0>>(arg1),
            buyer          : v0,
            creator        : arg1.creator,
            amount         : v1,
            creator_amount : v4,
            fee_amount     : v5,
        };
        0x2::event::emit<Unlocked>(v6);
    }

    public fun unlocks<T0>(arg0: &Post<T0>) : u64 {
        arg0.unlocks
    }

    public fun update<T0>(arg0: &mut Post<T0>, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 6);
        assert!(arg1 > 0, 1);
        arg0.price = arg1;
        arg0.open = arg2;
        let v0 = PostUpdated{
            post  : 0x2::object::id<Post<T0>>(arg0),
            price : arg1,
            open  : arg2,
        };
        0x2::event::emit<PostUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

