module 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Invitee has store {
        joined_at: u64,
        amount: u64,
    }

    struct Referral has store {
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_amount: u64,
        claimed_amount: u64,
        referral_fee_bp: u64,
        invitees: 0x2::table::Table<address, Invitee>,
        joined_at_invitee_pages: 0x2::table::Table<u64, vector<address>>,
        joined_at_invitee_page: u64,
    }

    struct ReferralRegistry has key {
        id: 0x2::object::UID,
        referrals: 0x2::table::Table<address, Referral>,
        invites: 0x2::table::Table<address, address>,
    }

    struct Registered has copy, drop {
        invitee: address,
        inviter: address,
    }

    struct Earned has copy, drop {
        invitee: address,
        inviter: address,
        amount: u64,
    }

    struct Claimed has copy, drop {
        inviter: address,
        amount: u64,
    }

    entry fun claim_referral_balance(arg0: &mut ReferralRegistry, arg1: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg2: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg1, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<address, Referral>(&mut arg0.referrals, v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, v2), arg2), v0);
        v1.claimed_amount = v1.claimed_amount + v2;
        let v3 = Claimed{
            inviter : v0,
            amount  : v2,
        };
        0x2::event::emit<Claimed>(v3);
    }

    public fun earn_referral_balance(arg0: &mut ReferralRegistry, arg1: address, arg2: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg3: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg2, 1);
        let v0 = get_inviter(arg0, arg1);
        let v1 = 0x1::option::extract<address>(&mut v0);
        let v2 = 0x2::table::borrow_mut<address, Referral>(&mut arg0.referrals, v1);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        v2.total_amount = v2.total_amount + v3;
        0x2::balance::join<0x2::sui::SUI>(&mut v2.balance, arg3);
        let v4 = 0x2::table::borrow_mut<address, Invitee>(&mut v2.invitees, arg1);
        v4.amount = v4.amount + v3;
        let v5 = Earned{
            invitee : arg1,
            inviter : v1,
            amount  : v3,
        };
        0x2::event::emit<Earned>(v5);
    }

    fun get_inviter(arg0: &ReferralRegistry, arg1: address) : 0x1::option::Option<address> {
        if (!0x2::table::contains<address, address>(&arg0.invites, arg1)) {
            return 0x1::option::none<address>()
        };
        0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.invites, arg1))
    }

    public fun get_referral_fee(arg0: &ReferralRegistry, arg1: address, arg2: u64) : u64 {
        let v0 = get_inviter(arg0, arg1);
        if (0x1::option::is_none<address>(&v0)) {
            return 0
        };
        arg2 * 0x2::table::borrow<address, Referral>(&arg0.referrals, 0x1::option::extract<address>(&mut v0)).referral_fee_bp / 10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralRegistry{
            id        : 0x2::object::new(arg0),
            referrals : 0x2::table::new<address, Referral>(arg0),
            invites   : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<ReferralRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun init_new_referral(arg0: &mut ReferralRegistry, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 9223372840014118920);
        assert!(!0x2::table::contains<address, Referral>(&arg0.referrals, arg1), 9223372848603594751);
        let v0 = Referral{
            balance                 : 0x2::balance::zero<0x2::sui::SUI>(),
            total_amount            : 0,
            claimed_amount          : 0,
            referral_fee_bp         : arg2,
            invitees                : 0x2::table::new<address, Invitee>(arg3),
            joined_at_invitee_pages : 0x2::table::new<u64, vector<address>>(arg3),
            joined_at_invitee_page  : 1,
        };
        0x2::table::add<address, Referral>(&mut arg0.referrals, arg1, v0);
        0x2::table::add<u64, vector<address>>(&mut 0x2::table::borrow_mut<address, Referral>(&mut arg0.referrals, arg1).joined_at_invitee_pages, 1, vector[]);
    }

    entry fun register_referral(arg0: &mut ReferralRegistry, arg1: address, arg2: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, address>(&arg0.invites, v0), 9223372337502683140);
        assert!(arg1 != v0, 9223372341797781510);
        0x2::table::add<address, address>(&mut arg0.invites, v0, arg1);
        if (!0x2::table::contains<address, Referral>(&arg0.referrals, arg1)) {
            init_new_referral(arg0, arg1, 1000, arg4);
        };
        let v1 = 0x2::table::borrow_mut<address, Referral>(&mut arg0.referrals, arg1);
        let v2 = Invitee{
            joined_at : 0x2::clock::timestamp_ms(arg3),
            amount    : 0,
        };
        0x2::table::add<address, Invitee>(&mut v1.invitees, v0, v2);
        let v3 = v1.joined_at_invitee_page;
        let v4 = 0x2::table::borrow_mut<u64, vector<address>>(&mut v1.joined_at_invitee_pages, v3);
        let v5 = v4;
        if (0x1::vector::length<address>(v4) >= 50) {
            let v6 = v3 + 1;
            v1.joined_at_invitee_page = v6;
            0x2::table::add<u64, vector<address>>(&mut v1.joined_at_invitee_pages, v6, vector[]);
            v5 = 0x2::table::borrow_mut<u64, vector<address>>(&mut v1.joined_at_invitee_pages, v6);
        };
        0x1::vector::push_back<address>(v5, v0);
        let v7 = Registered{
            invitee : v0,
            inviter : arg1,
        };
        0x2::event::emit<Registered>(v7);
    }

    entry fun update_referral(arg0: &AdminCap, arg1: &mut ReferralRegistry, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 10000, 9223372595200983048);
        if (!0x2::table::contains<address, Referral>(&arg1.referrals, arg2)) {
            init_new_referral(arg1, arg2, arg3, arg4);
            return
        };
        0x2::table::borrow_mut<address, Referral>(&mut arg1.referrals, arg2).referral_fee_bp = arg3;
    }

    // decompiled from Move bytecode v6
}

