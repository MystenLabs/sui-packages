module 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account {
    struct Registry has key {
        id: 0x2::object::UID,
        by_handle: 0x2::table::Table<0x1::string::String, address>,
        by_address: 0x2::table::Table<address, 0x1::string::String>,
    }

    struct SocialAccount has key {
        id: 0x2::object::UID,
        platform: 0x2::object::ID,
        owner: address,
        handle: 0x1::string::String,
        referrer: 0x1::option::Option<address>,
        created_at_ms: u64,
    }

    struct AccountOpened has copy, drop {
        account: 0x2::object::ID,
        platform: 0x2::object::ID,
        owner: address,
        handle: 0x1::string::String,
        referrer: 0x1::option::Option<address>,
        created_at_ms: u64,
    }

    struct AccountClosed has copy, drop {
        account: 0x2::object::ID,
        owner: address,
        handle: 0x1::string::String,
    }

    public(friend) fun assert_authenticates(arg0: &SocialAccount, arg1: address, arg2: 0x2::object::ID) {
        assert!(arg0.owner == arg1, 5);
        assert!(arg0.platform == arg2, 6);
    }

    fun assert_handle_valid(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        assert!(v1 >= 3 && v1 <= 30, 1);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 >= 48 && v3 <= 57) {
                true
            } else {
                v3 == 95
            };
            assert!(v4, 2);
            v2 = v2 + 1;
        };
    }

    public fun close(arg0: &mut Registry, arg1: SocialAccount, arg2: &0x2::tx_context::TxContext) {
        let SocialAccount {
            id            : v0,
            platform      : _,
            owner         : v2,
            handle        : v3,
            referrer      : _,
            created_at_ms : _,
        } = arg1;
        let v6 = v0;
        assert!(v2 == 0x2::tx_context::sender(arg2), 5);
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.by_handle, v3), 8);
        assert!(*0x2::table::borrow<0x1::string::String, address>(&arg0.by_handle, v3) == v2, 8);
        0x2::table::remove<0x1::string::String, address>(&mut arg0.by_handle, v3);
        0x2::table::remove<address, 0x1::string::String>(&mut arg0.by_address, v2);
        let v7 = AccountClosed{
            account : 0x2::object::uid_to_inner(&v6),
            owner   : v2,
            handle  : v3,
        };
        0x2::event::emit<AccountClosed>(v7);
        0x2::object::delete(v6);
    }

    public fun created_at_ms(arg0: &SocialAccount) : u64 {
        arg0.created_at_ms
    }

    public fun handle(arg0: &SocialAccount) : &0x1::string::String {
        &arg0.handle
    }

    public fun has_account(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, 0x1::string::String>(&arg0.by_address, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id         : 0x2::object::new(arg0),
            by_handle  : 0x2::table::new<0x1::string::String, address>(arg0),
            by_address : 0x2::table::new<address, 0x1::string::String>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_handle_taken(arg0: &Registry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, address>(&arg0.by_handle, arg1)
    }

    public fun max_handle_len() : u64 {
        30
    }

    public fun min_handle_len() : u64 {
        3
    }

    public fun open(arg0: &mut 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform, arg1: &mut Registry, arg2: 0x1::string::String, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::assert_can_create(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert_handle_valid(&arg2);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg1.by_handle, arg2), 3);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg1.by_address, v0), 4);
        if (0x1::option::is_some<address>(&arg3)) {
            assert!(*0x1::option::borrow<address>(&arg3) != v0, 7);
        };
        0x2::table::add<0x1::string::String, address>(&mut arg1.by_handle, arg2, v0);
        0x2::table::add<address, 0x1::string::String>(&mut arg1.by_address, v0, arg2);
        let v1 = SocialAccount{
            id            : 0x2::object::new(arg5),
            platform      : 0x2::object::id<0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform>(arg0),
            owner         : v0,
            handle        : arg2,
            referrer      : arg3,
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        let v2 = AccountOpened{
            account       : 0x2::object::id<SocialAccount>(&v1),
            platform      : 0x2::object::id<0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform>(arg0),
            owner         : v0,
            handle        : arg2,
            referrer      : arg3,
            created_at_ms : v1.created_at_ms,
        };
        0x2::event::emit<AccountOpened>(v2);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::record_account_created(arg0);
        0x2::transfer::transfer<SocialAccount>(v1, v0);
    }

    public fun owner(arg0: &SocialAccount) : address {
        arg0.owner
    }

    public fun platform_id(arg0: &SocialAccount) : 0x2::object::ID {
        arg0.platform
    }

    public fun referrer(arg0: &SocialAccount) : 0x1::option::Option<address> {
        arg0.referrer
    }

    public fun resolve(arg0: &Registry, arg1: 0x1::string::String) : address {
        *0x2::table::borrow<0x1::string::String, address>(&arg0.by_handle, arg1)
    }

    // decompiled from Move bytecode v7
}

