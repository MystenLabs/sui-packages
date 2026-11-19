module 0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry {
    struct ReferralRegistry has key {
        id: 0x2::object::UID,
        root_account: address,
        whitelist: vector<address>,
        blacklist: vector<address>,
        referrer: 0x2::table::Table<address, address>,
        referrals: 0x2::table::Table<address, vector<address>>,
        team_count: 0x2::table::Table<address, u64>,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct WhitelistAdded has copy, drop {
        account: address,
    }

    struct WhitelistRemoved has copy, drop {
        account: address,
    }

    struct BlacklistAdded has copy, drop {
        account: address,
    }

    struct BlacklistRemoved has copy, drop {
        account: address,
    }

    struct Bind has copy, drop {
        referrer: address,
        referee: address,
    }

    struct RootAccountChanged has copy, drop {
        previous_root: address,
        new_root: address,
    }

    public fun add_blacklist(arg0: &mut ReferralRegistry, arg1: &OwnerCap, arg2: address) {
        assert_registry_owner(arg0, arg1);
        assert!(arg2 != @0x0, 9);
        if (!0x1::vector::contains<address>(&arg0.blacklist, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.blacklist, arg2);
            let v0 = BlacklistAdded{account: arg2};
            0x2::event::emit<BlacklistAdded>(v0);
        };
    }

    public fun add_blacklist_batch(arg0: &mut ReferralRegistry, arg1: &OwnerCap, arg2: vector<address>) {
        assert_registry_owner(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x1::vector::contains<address>(&arg0.blacklist, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.blacklist, v1);
                let v2 = BlacklistAdded{account: v1};
                0x2::event::emit<BlacklistAdded>(v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun add_whitelist(arg0: &mut ReferralRegistry, arg1: &OwnerCap, arg2: address) {
        assert_registry_owner(arg0, arg1);
        assert!(arg2 != @0x0, 9);
        if (!0x1::vector::contains<address>(&arg0.whitelist, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.whitelist, arg2);
            let v0 = WhitelistAdded{account: arg2};
            0x2::event::emit<WhitelistAdded>(v0);
        };
    }

    fun assert_is_whitelisted(arg0: &ReferralRegistry, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &arg1), 0);
    }

    fun assert_registry_owner(arg0: &ReferralRegistry, arg1: &OwnerCap) {
        assert!(0x2::object::id<ReferralRegistry>(arg0) == arg1.registry_id, 11);
    }

    public fun bind(arg0: &mut ReferralRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        bind_internal(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun bind_batch(arg0: &mut ReferralRegistry, arg1: address, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 9);
        assert_is_whitelisted(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            bind_internal(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun bind_entry(arg0: &mut ReferralRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        bind_internal(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    fun bind_internal(arg0: &mut ReferralRegistry, arg1: address, arg2: address) {
        assert!(arg1 != @0x0 && arg2 != @0x0, 9);
        assert!(!0x1::vector::contains<address>(&arg0.blacklist, &arg1), 12);
        assert!(!0x1::vector::contains<address>(&arg0.blacklist, &arg2), 12);
        assert!(arg1 != arg2, 8);
        assert!(arg2 != arg0.root_account, 4);
        assert!(!0x2::table::contains<address, address>(&arg0.referrer, arg2), 1);
        if (0x2::table::contains<address, vector<address>>(&arg0.referrals, arg2)) {
            assert!(0x1::vector::length<address>(0x2::table::borrow<address, vector<address>>(&arg0.referrals, arg2)) == 0, 2);
        };
        assert!(arg1 == arg0.root_account || 0x2::table::contains<address, address>(&arg0.referrer, arg1), 3);
        0x2::table::add<address, address>(&mut arg0.referrer, arg2, arg1);
        if (!0x2::table::contains<address, vector<address>>(&arg0.referrals, arg1)) {
            0x2::table::add<address, vector<address>>(&mut arg0.referrals, arg1, vector[]);
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg0.referrals, arg1), arg2);
        let v0 = 0;
        while (v0 < 30 && arg1 != @0x0) {
            if (0x2::table::contains<address, u64>(&arg0.team_count, arg1)) {
                let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.team_count, arg1);
                *v1 = *v1 + 1;
            } else {
                0x2::table::add<address, u64>(&mut arg0.team_count, arg1, 1);
            };
            if (!0x2::table::contains<address, address>(&arg0.referrer, arg1)) {
                break
            };
            let v2 = 0x2::table::borrow<address, address>(&arg0.referrer, arg1);
            arg1 = *v2;
            v0 = v0 + 1;
        };
        let v3 = Bind{
            referrer : arg1,
            referee  : arg2,
        };
        0x2::event::emit<Bind>(v3);
    }

    public fun can_refer(arg0: &ReferralRegistry, arg1: address) : bool {
        arg1 != @0x0 && (arg1 == arg0.root_account || 0x2::table::contains<address, address>(&arg0.referrer, arg1))
    }

    public fun get_all_blacklist(arg0: &ReferralRegistry) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.blacklist)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(&arg0.blacklist, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_all_whitelist(arg0: &ReferralRegistry) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.whitelist)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(&arg0.whitelist, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_blacklist_at(arg0: &ReferralRegistry, arg1: u64) : address {
        *0x1::vector::borrow<address>(&arg0.blacklist, arg1)
    }

    public fun get_blacklist_count(arg0: &ReferralRegistry) : u64 {
        0x1::vector::length<address>(&arg0.blacklist)
    }

    public fun get_direct_referral_count(arg0: &ReferralRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<address>>(&arg0.referrals, arg1)) {
            0x1::vector::length<address>(0x2::table::borrow<address, vector<address>>(&arg0.referrals, arg1))
        } else {
            0
        }
    }

    public fun get_direct_referrals(arg0: &ReferralRegistry, arg1: address) : vector<address> {
        if (0x2::table::contains<address, vector<address>>(&arg0.referrals, arg1)) {
            *0x2::table::borrow<address, vector<address>>(&arg0.referrals, arg1)
        } else {
            vector[]
        }
    }

    public fun get_referrer(arg0: &ReferralRegistry, arg1: address) : (bool, address) {
        if (0x2::table::contains<address, address>(&arg0.referrer, arg1)) {
            (true, *0x2::table::borrow<address, address>(&arg0.referrer, arg1))
        } else {
            (false, @0x0)
        }
    }

    public fun get_team_count(arg0: &ReferralRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.team_count, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.team_count, arg1)
        } else {
            0
        }
    }

    public fun get_upward_referrers(arg0: &ReferralRegistry, arg1: address, arg2: u64) : vector<address> {
        if (arg2 == 0) {
            return vector[]
        };
        assert!(arg2 <= 30, 10);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg2) {
            if (!0x2::table::contains<address, address>(&arg0.referrer, arg1)) {
                break
            };
            let v2 = *0x2::table::borrow<address, address>(&arg0.referrer, arg1);
            0x1::vector::push_back<address>(&mut v0, v2);
            arg1 = v2;
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_whitelist_at(arg0: &ReferralRegistry, arg1: u64) : address {
        *0x1::vector::borrow<address>(&arg0.whitelist, arg1)
    }

    public fun get_whitelist_count(arg0: &ReferralRegistry) : u64 {
        0x1::vector::length<address>(&arg0.whitelist)
    }

    public fun has_referrer(arg0: &ReferralRegistry, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.referrer, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = ReferralRegistry{
            id           : 0x2::object::new(arg0),
            root_account : v0,
            whitelist    : v1,
            blacklist    : vector[],
            referrer     : 0x2::table::new<address, address>(arg0),
            referrals    : 0x2::table::new<address, vector<address>>(arg0),
            team_count   : 0x2::table::new<address, u64>(arg0),
        };
        let v3 = OwnerCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<ReferralRegistry>(&v2),
        };
        let v4 = WhitelistAdded{account: v0};
        0x2::event::emit<WhitelistAdded>(v4);
        let v5 = RootAccountChanged{
            previous_root : @0x0,
            new_root      : v0,
        };
        0x2::event::emit<RootAccountChanged>(v5);
        0x2::transfer::share_object<ReferralRegistry>(v2);
        0x2::transfer::transfer<OwnerCap>(v3, v0);
    }

    public fun is_blacklisted(arg0: &ReferralRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.blacklist, &arg1)
    }

    public fun is_whitelisted(arg0: &ReferralRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun remove_blacklist(arg0: &mut ReferralRegistry, arg1: &OwnerCap, arg2: address) {
        assert_registry_owner(arg0, arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.blacklist, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.blacklist, v1);
            let v2 = BlacklistRemoved{account: arg2};
            0x2::event::emit<BlacklistRemoved>(v2);
        };
    }

    public fun remove_whitelist(arg0: &mut ReferralRegistry, arg1: &OwnerCap, arg2: address) {
        assert_registry_owner(arg0, arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.whitelist, v1);
            let v2 = WhitelistRemoved{account: arg2};
            0x2::event::emit<WhitelistRemoved>(v2);
        };
    }

    public fun set_root_account(arg0: &mut ReferralRegistry, arg1: &OwnerCap, arg2: address) {
        assert_registry_owner(arg0, arg1);
        assert!(arg2 != @0x0, 9);
        assert!(arg2 != arg0.root_account, 5);
        assert!(!0x2::table::contains<address, address>(&arg0.referrer, arg2), 6);
        if (0x2::table::contains<address, vector<address>>(&arg0.referrals, arg2)) {
            assert!(0x1::vector::length<address>(0x2::table::borrow<address, vector<address>>(&arg0.referrals, arg2)) == 0, 7);
        };
        arg0.root_account = arg2;
        let v0 = RootAccountChanged{
            previous_root : arg0.root_account,
            new_root      : arg2,
        };
        0x2::event::emit<RootAccountChanged>(v0);
    }

    // decompiled from Move bytecode v7
}

