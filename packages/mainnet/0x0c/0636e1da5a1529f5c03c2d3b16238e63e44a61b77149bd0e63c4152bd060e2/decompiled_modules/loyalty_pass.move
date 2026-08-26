module 0xc0636e1da5a1529f5c03c2d3b16238e63e44a61b77149bd0e63c4152bd060e2::loyalty_pass {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        first_award_identities: vector<vector<u8>>,
    }

    struct LoyaltyPass has key {
        id: 0x2::object::UID,
        identity_commitment: vector<u8>,
        discount_bps: u64,
        credited_vehicles: u64,
    }

    struct LoyaltyAward has key {
        id: 0x2::object::UID,
        identity_commitment: vector<u8>,
        vehicle_commitment: vector<u8>,
        target_discount_bps: u64,
        redemption_mode: u8,
    }

    struct AwardCreated has copy, drop {
        recipient: address,
        target_discount_bps: u64,
    }

    struct PassRedeemed has copy, drop {
        owner: address,
        discount_bps: u64,
    }

    public entry fun create_first_award(arg0: &mut Registry, arg1: &AdminCap, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0 && arg5 <= 2500, 3);
        assert!(!0x1::vector::contains<vector<u8>>(&arg0.first_award_identities, &arg3), 4);
        0x1::vector::push_back<vector<u8>>(&mut arg0.first_award_identities, arg3);
        let v0 = LoyaltyAward{
            id                  : 0x2::object::new(arg6),
            identity_commitment : arg3,
            vehicle_commitment  : arg4,
            target_discount_bps : arg5,
            redemption_mode     : 0,
        };
        0x2::transfer::transfer<LoyaltyAward>(v0, arg2);
        let v1 = AwardCreated{
            recipient           : arg2,
            target_discount_bps : arg5,
        };
        0x2::event::emit<AwardCreated>(v1);
    }

    public entry fun create_upgrade_award(arg0: &Registry, arg1: &AdminCap, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0 && arg5 <= 2500, 3);
        let v0 = LoyaltyAward{
            id                  : 0x2::object::new(arg6),
            identity_commitment : arg3,
            vehicle_commitment  : arg4,
            target_discount_bps : arg5,
            redemption_mode     : 1,
        };
        0x2::transfer::transfer<LoyaltyAward>(v0, arg2);
        let v1 = AwardCreated{
            recipient           : arg2,
            target_discount_bps : arg5,
        };
        0x2::event::emit<AwardCreated>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id                     : 0x2::object::new(arg0),
            first_award_identities : 0x1::vector::empty<vector<u8>>(),
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public entry fun redeem_new(arg0: LoyaltyAward, arg1: &mut 0x2::tx_context::TxContext) {
        let LoyaltyAward {
            id                  : v0,
            identity_commitment : v1,
            vehicle_commitment  : _,
            target_discount_bps : v3,
            redemption_mode     : v4,
        } = arg0;
        assert!(v4 == 0, 5);
        0x2::object::delete(v0);
        let v5 = LoyaltyPass{
            id                  : 0x2::object::new(arg1),
            identity_commitment : v1,
            discount_bps        : v3,
            credited_vehicles   : 1,
        };
        0x2::transfer::transfer<LoyaltyPass>(v5, 0x2::tx_context::sender(arg1));
        let v6 = PassRedeemed{
            owner        : 0x2::tx_context::sender(arg1),
            discount_bps : v3,
        };
        0x2::event::emit<PassRedeemed>(v6);
    }

    public entry fun redeem_upgrade(arg0: LoyaltyPass, arg1: LoyaltyAward, arg2: &mut 0x2::tx_context::TxContext) {
        let LoyaltyAward {
            id                  : v0,
            identity_commitment : v1,
            vehicle_commitment  : _,
            target_discount_bps : v3,
            redemption_mode     : v4,
        } = arg1;
        assert!(v4 == 1, 5);
        assert!(arg0.identity_commitment == v1, 1);
        assert!(v3 > arg0.discount_bps, 2);
        assert!(v3 <= 2500, 3);
        0x2::object::delete(v0);
        arg0.discount_bps = v3;
        arg0.credited_vehicles = arg0.credited_vehicles + 1;
        let v5 = 0x2::tx_context::sender(arg2);
        let v6 = PassRedeemed{
            owner        : v5,
            discount_bps : v3,
        };
        0x2::event::emit<PassRedeemed>(v6);
        0x2::transfer::transfer<LoyaltyPass>(arg0, v5);
    }

    // decompiled from Move bytecode v7
}

