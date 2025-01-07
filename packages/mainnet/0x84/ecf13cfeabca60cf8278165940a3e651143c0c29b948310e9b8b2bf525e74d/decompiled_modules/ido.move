module 0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::ido {
    struct CampaignFundEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        amount: u64,
        wallet: address,
        is_insured: bool,
        is_private_to_public: bool,
    }

    struct CampaignEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        hard_cap: u64,
        only_whitelist: bool,
        change_to_public: bool,
        investors: u64,
        investor_amounts: u64,
        price: u64,
        min_amount: u64,
        max_amount: u64,
        sender: address,
        owner: address,
    }

    struct CampaignClaimEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        member: address,
        claim_amount: u64,
        return_amount: u64,
        valid_amount: u64,
        timestamp_ms: u64,
    }

    struct CampaignRefundClaimEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        wallet: address,
        valid_amount: u64,
        amount: u64,
        timestamp_ms: u64,
    }

    struct Member has store {
        wallet: address,
        total_amount: u64,
        valid_amount: u64,
        refund_amount: u64,
        claimed: u64,
        is_claimed: bool,
        is_refunded: bool,
        is_private: bool,
    }

    struct Campaign<phantom T0> has store, key {
        id: 0x2::object::UID,
        hard_cap: u64,
        private: bool,
        change_to_public: bool,
        investors: u64,
        investor_amounts: u64,
        price: u64,
        decimal: u64,
        min_amount: u64,
        max_amount: u64,
        total_deposit: u256,
        balance: 0x2::balance::Balance<T0>,
        members: 0x2::bag::Bag,
        white_list: 0x2::bag::Bag,
        owner: address,
        funded: bool,
        version: u64,
        enmergency: bool,
        is_open: bool,
        is_end: bool,
        merkle_root: vector<u8>,
    }

    fun caculate_claimable_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u256, arg4: u64, arg5: u64) : u64 {
        (((arg1 as u256) * (arg5 as u256) / (arg2 as u256)) as u64)
    }

    fun caculate_claimable_amount_when_hardcap_is_reached(arg0: u64, arg1: u64, arg2: u256, arg3: u64, arg4: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (arg3 as u256) / arg2 / (arg4 as u256)) as u64)
    }

    public entry fun claim<T0, T1>(arg0: &mut Campaign<T0>, arg1: &mut 0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::vault::Vault<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.members, v0), 1010);
        let v1 = 0x2::object::id<Campaign<T0>>(arg0);
        let v2 = 0x2::bag::borrow_mut<address, Member>(&mut arg0.members, v0);
        assert!(v2.is_claimed == false, 1013);
        assert!(arg0.is_end, 1021);
        let v3 = arg0.total_deposit;
        if (v3 > (arg0.hard_cap as u256)) {
            let v4 = caculate_claimable_amount_when_hardcap_is_reached(arg0.hard_cap, arg0.price, v3, arg0.decimal, v2.total_amount);
            let v5 = claulate_return_amout_when_hardcap_is_reached(arg0.hard_cap, arg0.price, v3, arg0.decimal, v2.total_amount);
            v2.is_claimed = true;
            v2.claimed = v4;
            v2.refund_amount = v5;
            v2.valid_amount = v2.total_amount - v5;
            let v6 = CampaignClaimEvent{
                campaign_id   : v1,
                member        : v0,
                claim_amount  : v4,
                return_amount : v5,
                valid_amount  : v2.valid_amount,
                timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<CampaignClaimEvent>(v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::vault::claim<T1>(arg1, v1, v4, arg3), arg3), v0);
        } else {
            let v7 = caculate_claimable_amount(arg0.hard_cap, arg0.price, arg0.decimal, v3, arg0.investors, v2.total_amount);
            v2.is_claimed = true;
            v2.claimed = v7;
            v2.refund_amount = 0;
            v2.valid_amount = v2.total_amount;
            let v8 = CampaignClaimEvent{
                campaign_id   : v1,
                member        : v0,
                claim_amount  : v7,
                return_amount : v2.refund_amount,
                valid_amount  : v2.valid_amount,
                timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<CampaignClaimEvent>(v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::vault::claim<T1>(arg1, v1, v7, arg3), arg3), v0);
        };
    }

    fun claulate_return_amout_when_hardcap_is_reached(arg0: u64, arg1: u64, arg2: u256, arg3: u64, arg4: u64) : u64 {
        arg4 - (((caculate_claimable_amount_when_hardcap_is_reached(arg0, arg1, arg2, arg3, arg4) as u256) * (arg3 as u256) / (arg1 as u256)) as u64)
    }

    public fun create<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = Campaign<T0>{
            id               : 0x2::object::new(arg9),
            hard_cap         : arg1,
            private          : arg6,
            change_to_public : arg7,
            investors        : 0,
            investor_amounts : 0,
            price            : arg2,
            decimal          : arg5,
            min_amount       : arg3,
            max_amount       : arg4,
            total_deposit    : 0,
            balance          : 0x2::balance::zero<T0>(),
            members          : 0x2::bag::new(arg9),
            white_list       : 0x2::bag::new(arg9),
            owner            : arg8,
            funded           : false,
            version          : 0,
            enmergency       : false,
            is_open          : false,
            is_end           : false,
            merkle_root      : 0x1::vector::empty<u8>(),
        };
        let v1 = CampaignEvent{
            campaign_id      : 0x2::object::id<Campaign<T0>>(&v0),
            hard_cap         : arg1,
            only_whitelist   : arg6,
            change_to_public : arg7,
            investors        : v0.investors,
            investor_amounts : v0.investor_amounts,
            price            : arg2,
            min_amount       : arg3,
            max_amount       : arg4,
            sender           : 0x2::tx_context::sender(arg9),
            owner            : arg8,
        };
        0x2::event::emit<CampaignEvent>(v1);
        0x2::transfer::public_share_object<Campaign<T0>>(v0);
    }

    public fun get_member<T0>(arg0: &mut Campaign<T0>, arg1: address) : &Member {
        assert!(0x2::bag::contains<address>(&arg0.members, arg1), 1010);
        0x2::bag::borrow<address, Member>(&arg0.members, arg1)
    }

    public fun migrate<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.version = 0;
    }

    fun pri_fund<T0>(arg0: &mut Campaign<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg0.min_amount, 1006);
        assert!(v1 <= arg0.max_amount, 1006);
        if (!arg0.change_to_public) {
            if (0x1::vector::length<u8>(&arg0.merkle_root) == 0) {
                assert!(0x1::vector::length<u8>(&arg0.merkle_root) != 0, 1022);
            };
            assert!(0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::merkle_proof::verify(&arg2, arg0.merkle_root, 0x1::hash::sha2_256(0x2::bcs::to_bytes<address>(&v0))), 1018);
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposit = arg0.total_deposit + (v1 as u256);
        assert!(arg0.total_deposit <= (arg0.hard_cap as u256), 1003);
        if (0x2::bag::contains<address>(&mut arg0.members, v0)) {
            let v2 = 0x2::bag::borrow_mut<address, Member>(&mut arg0.members, v0);
            v2.total_amount = v2.total_amount + v1;
            assert!(v2.total_amount <= arg0.max_amount, 1003);
        } else {
            let v3 = Member{
                wallet        : v0,
                total_amount  : v1,
                valid_amount  : 0,
                refund_amount : 0,
                claimed       : 0,
                is_claimed    : false,
                is_refunded   : false,
                is_private    : true,
            };
            arg0.investors = arg0.investors + 1;
            0x2::bag::add<address, Member>(&mut arg0.members, v0, v3);
        };
    }

    public entry fun private_fund<T0>(arg0: &mut Campaign<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 1018);
        assert!(arg0.is_open, 1010);
        assert!(!arg0.enmergency, 1019);
        assert!(!arg0.is_end, 1020);
        assert!(arg0.private, 1001);
        pri_fund<T0>(arg0, arg1, arg2, arg3);
    }

    fun pub_fund<T0>(arg0: &mut Campaign<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg0.min_amount, 1006);
        assert!(v1 <= arg0.max_amount, 1006);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposit = arg0.total_deposit + (v1 as u256);
        if (0x2::bag::contains<address>(&mut arg0.members, v0)) {
            let v2 = 0x2::bag::borrow_mut<address, Member>(&mut arg0.members, v0);
            v2.total_amount = v2.total_amount + v1;
            assert!(v2.total_amount <= arg0.max_amount, 1003);
        } else {
            let v3 = Member{
                wallet        : v0,
                total_amount  : v1,
                valid_amount  : 0,
                refund_amount : 0,
                claimed       : 0,
                is_claimed    : false,
                is_refunded   : false,
                is_private    : false,
            };
            arg0.investors = arg0.investors + 1;
            0x2::bag::add<address, Member>(&mut arg0.members, v0, v3);
        };
    }

    public entry fun public_fund<T0>(arg0: &mut Campaign<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 1018);
        assert!(arg0.is_open, 1010);
        assert!(!arg0.enmergency, 1019);
        assert!(!arg0.is_end, 1020);
        assert!(!arg0.private, 1001);
        pub_fund<T0>(arg0, arg1, arg2);
    }

    public entry fun refund<T0>(arg0: &mut Campaign<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.is_end, 1021);
        assert!(0x2::bag::contains<address>(&arg0.members, v0), 1010);
        let v1 = 0x2::bag::borrow_mut<address, Member>(&mut arg0.members, v0);
        assert!(!v1.is_refunded, 1017);
        let v2 = arg0.total_deposit;
        assert!(v2 > (arg0.hard_cap as u256), 1012);
        let v3 = claulate_return_amout_when_hardcap_is_reached(arg0.hard_cap, arg0.price, v2, arg0.decimal, v1.total_amount);
        assert!(v3 > 0, 1012);
        v1.refund_amount = v3;
        v1.valid_amount = v1.total_amount - v3;
        v1.is_refunded = true;
        let v4 = CampaignRefundClaimEvent{
            campaign_id  : 0x2::object::id<Campaign<T0>>(arg0),
            wallet       : v0,
            valid_amount : v1.valid_amount,
            amount       : v3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CampaignRefundClaimEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v3), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun set_merkle_root<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.merkle_root = arg2;
    }

    public fun switch_end<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.is_end = !arg1.is_end;
    }

    public fun switch_enmergency<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.enmergency = !arg1.enmergency;
    }

    public fun switch_open<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.is_open = !arg1.is_open;
    }

    public fun take_fund<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg2), arg1.owner);
    }

    public fun take_fund_with_amount<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), arg1.owner);
    }

    public fun update<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        arg1.hard_cap = arg2;
        arg1.price = arg3;
        arg1.min_amount = arg4;
        arg1.max_amount = arg5;
        arg1.private = arg7;
        arg1.change_to_public = arg8;
        arg1.decimal = arg6;
        arg1.owner = arg9;
        let v0 = CampaignEvent{
            campaign_id      : 0x2::object::id<Campaign<T0>>(arg1),
            hard_cap         : arg2,
            only_whitelist   : arg7,
            change_to_public : arg8,
            investors        : arg1.investors,
            investor_amounts : arg1.investor_amounts,
            price            : arg3,
            min_amount       : arg4,
            max_amount       : arg5,
            sender           : 0x2::tx_context::sender(arg10),
            owner            : arg9,
        };
        0x2::event::emit<CampaignEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

