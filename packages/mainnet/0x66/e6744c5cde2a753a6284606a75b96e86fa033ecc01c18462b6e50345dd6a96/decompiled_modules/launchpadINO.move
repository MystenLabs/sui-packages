module 0x66e6744c5cde2a753a6284606a75b96e86fa033ecc01c18462b6e50345dd6a96::launchpadINO {
    struct AdminConfig has store, key {
        id: 0x2::object::UID,
        fees_sales: u8,
        permissions: vector<address>,
        owner: address,
    }

    struct Account has copy, drop, store {
        adr: address,
        amount: u64,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct LaunchpadINOCreatedEvent has copy, drop {
        launchpad_ino_id: 0x2::object::ID,
    }

    struct RefundCreatedEvent has copy, drop {
        refund_id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct ListSlugINOEvent has copy, drop {
        code: 0x1::string::String,
        launchpad_ino_id: 0x2::object::ID,
    }

    struct LaunchpadINO has key {
        id: 0x2::object::UID,
        community_id: address,
        code: 0x1::string::String,
        banner: 0x1::string::String,
        url_nft: 0x1::string::String,
        thumbnail: 0x1::string::String,
        nameProject: 0x1::string::String,
        category: vector<0x1::string::String>,
        short_desc: 0x1::string::String,
        description: 0x1::string::String,
        pitchdeck: 0x1::string::String,
        socials: vector<0x1::string::String>,
        rules: 0x1::string::String,
        pools: vector<0x2::object::ID>,
        vote_id: 0x2::object::ID,
        status: u8,
        isVerify: u8,
        isAudit: u8,
        owner: address,
        create_date: u64,
        update_date: u64,
    }

    struct Buy has store, key {
        id: 0x2::object::UID,
        account: address,
        amount: u64,
    }

    struct Listing<T0: store + key> has store, key {
        id: 0x2::object::UID,
        item: T0,
        owner: address,
    }

    public(friend) fun add_more_pools(arg0: &mut LaunchpadINO, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pools, arg1);
    }

    public entry fun add_permission(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        0x1::vector::push_back<address>(&mut arg0.permissions, arg1);
    }

    public entry fun audit_launchpad(arg0: &mut AdminConfig, arg1: &mut LaunchpadINO, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.permissions, &v0) == true, 135289670007);
        assert!(v0 == arg1.owner, 135289670003);
        arg1.isAudit = arg2;
    }

    public entry fun create_launchpad(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<0x1::string::String>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<0x1::string::String>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg12);
        0x2::object::uid_to_inner(&v0);
        let v1 = LaunchpadINO{
            id           : v0,
            community_id : arg0,
            code         : 0x1::string::utf8(arg4),
            banner       : 0x1::string::utf8(arg1),
            url_nft      : 0x1::string::utf8(arg2),
            thumbnail    : 0x1::string::utf8(arg3),
            nameProject  : 0x1::string::utf8(arg5),
            category     : arg6,
            short_desc   : 0x1::string::utf8(arg7),
            description  : 0x1::string::utf8(arg8),
            pitchdeck    : 0x1::string::utf8(arg9),
            socials      : arg10,
            rules        : 0x1::string::utf8(arg11),
            pools        : 0x1::vector::empty<0x2::object::ID>(),
            vote_id      : 0x2::object::id_from_address(@0x7b),
            status       : 0,
            isVerify     : 0,
            isAudit      : 0,
            owner        : 0x2::tx_context::sender(arg12),
            create_date  : 0,
            update_date  : 0,
        };
        let v2 = LaunchpadINOCreatedEvent{launchpad_ino_id: 0x2::object::id<LaunchpadINO>(&v1)};
        0x2::event::emit<LaunchpadINOCreatedEvent>(v2);
        let v3 = ListSlugINOEvent{
            code             : 0x1::string::utf8(arg4),
            launchpad_ino_id : 0x2::object::id<LaunchpadINO>(&v1),
        };
        0x2::event::emit<ListSlugINOEvent>(v3);
        0x2::transfer::share_object<LaunchpadINO>(v1);
    }

    public entry fun delete_permission(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        let (_, v1) = 0x1::vector::index_of<address>(&mut arg0.permissions, &arg1);
        0x1::vector::remove<address>(&mut arg0.permissions, v1);
    }

    public(friend) fun get_admin() : address {
        @0x790169f7b248c93f249432509b73e36d83ba9f1e9da1127dcd58181916663e3c
    }

    fun get_amount_by_account_whitelist(arg0: &vector<Account>, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Account>(arg0)) {
            let v1 = 0x1::vector::borrow<Account>(arg0, v0);
            if (v1.adr == arg1) {
                return (v1.amount as u64)
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public entry fun get_id(arg0: &mut LaunchpadINO) : 0x2::object::ID {
        0x2::object::id<LaunchpadINO>(arg0)
    }

    public(friend) fun get_owner(arg0: &mut LaunchpadINO) : address {
        arg0.owner
    }

    public(friend) fun get_vote_id(arg0: &mut LaunchpadINO) : 0x2::object::ID {
        arg0.vote_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminConfig{
            id          : 0x2::object::new(arg0),
            fees_sales  : 3,
            permissions : 0x1::vector::empty<address>(),
            owner       : @0x790169f7b248c93f249432509b73e36d83ba9f1e9da1127dcd58181916663e3c,
        };
        0x2::transfer::share_object<AdminConfig>(v0);
    }

    public fun maybe_split_and_transfer_rest<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x2::coin::value<T0>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        0x2::coin::split<T0>(&mut arg0, arg1, arg3)
    }

    public entry fun tranfer_admin(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        arg0.owner = arg1;
    }

    public entry fun update_fees(arg0: &mut AdminConfig, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        arg0.fees_sales = arg1;
    }

    public entry fun update_launchpad(arg0: &mut LaunchpadINO, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.owner, 135289670003);
        arg0.banner = 0x1::string::utf8(arg1);
        arg0.thumbnail = 0x1::string::utf8(arg2);
        arg0.nameProject = 0x1::string::utf8(arg3);
        arg0.category = arg4;
        arg0.short_desc = 0x1::string::utf8(arg5);
        arg0.description = 0x1::string::utf8(arg6);
        arg0.pitchdeck = 0x1::string::utf8(arg7);
        arg0.socials = arg8;
    }

    public entry fun update_status_launchpad(arg0: &mut AdminConfig, arg1: &mut LaunchpadINO, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.permissions, &v0) == true, 135289670007);
        assert!(v0 == arg1.owner, 135289670003);
        arg1.status = arg2;
    }

    public(friend) fun update_vote_id(arg0: &mut LaunchpadINO, arg1: 0x2::object::ID) {
        arg0.vote_id = arg1;
    }

    public entry fun verify_launchpad(arg0: &mut AdminConfig, arg1: &mut LaunchpadINO, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.permissions, &v0) == true, 135289670007);
        assert!(v0 == arg1.owner, 135289670003);
        arg1.isVerify = arg2;
    }

    // decompiled from Move bytecode v6
}

