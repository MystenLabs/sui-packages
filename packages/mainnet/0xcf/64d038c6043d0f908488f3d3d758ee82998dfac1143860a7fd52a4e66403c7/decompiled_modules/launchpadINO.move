module 0xcf64d038c6043d0f908488f3d3d758ee82998dfac1143860a7fd52a4e66403c7::launchpadINO {
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

    struct BuyCreatedEvent has copy, drop {
        buy_id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct ClaimCreatedEvent has copy, drop {
        claim_id: 0x2::object::ID,
        amount: u64,
        owner: address,
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

    struct Pool has store, key {
        id: 0x2::object::UID,
        total_raised_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_raise_nfts: u64,
        accounts_whitelist: vector<Account>,
        price: u64,
        maximum_amount: u64,
        minimum_amount: u64,
        time_allow_list_start: u64,
        time_start_sales: u64,
        time_end_sales: u64,
        time_claim: u64,
        isRefund: u8,
        status: u8,
        owner: address,
    }

    struct LaunchpadINO has key {
        id: 0x2::object::UID,
        community_id: address,
        code: 0x1::string::String,
        banner: 0x1::string::String,
        thumbnail: 0x1::string::String,
        nameProject: 0x1::string::String,
        category: vector<0x1::string::String>,
        short_desc: 0x1::string::String,
        description: 0x1::string::String,
        pitchdeck: 0x1::string::String,
        socials: vector<0x1::string::String>,
        rules: 0x1::string::String,
        vote_id: 0x2::object::ID,
        status: u8,
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

    public entry fun add_permission(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        0x1::vector::push_back<address>(&mut arg0.permissions, arg1);
    }

    public entry fun create_launchpad(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<0x1::string::String>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<0x1::string::String>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg11);
        0x2::object::uid_to_inner(&v0);
        let v1 = LaunchpadINO{
            id           : v0,
            community_id : arg0,
            code         : 0x1::string::utf8(arg1),
            banner       : 0x1::string::utf8(arg1),
            thumbnail    : 0x1::string::utf8(arg2),
            nameProject  : 0x1::string::utf8(arg4),
            category     : arg5,
            short_desc   : 0x1::string::utf8(arg6),
            description  : 0x1::string::utf8(arg7),
            pitchdeck    : 0x1::string::utf8(arg8),
            socials      : arg9,
            rules        : 0x1::string::utf8(arg10),
            vote_id      : 0x2::object::id_from_address(@0x7b),
            status       : 0,
            owner        : 0x2::tx_context::sender(arg11),
            create_date  : 0,
            update_date  : 0,
        };
        let v2 = LaunchpadINOCreatedEvent{launchpad_ino_id: 0x2::object::id<LaunchpadINO>(&v1)};
        0x2::event::emit<LaunchpadINOCreatedEvent>(v2);
        let v3 = ListSlugINOEvent{
            code             : 0x1::string::utf8(arg3),
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

    public entry fun get_id(arg0: &mut LaunchpadINO) : 0x2::object::ID {
        0x2::object::id<LaunchpadINO>(arg0)
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

    // decompiled from Move bytecode v6
}

