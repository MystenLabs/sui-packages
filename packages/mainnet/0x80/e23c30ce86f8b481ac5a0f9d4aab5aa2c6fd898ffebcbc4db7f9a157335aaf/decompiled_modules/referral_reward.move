module 0x80e23c30ce86f8b481ac5a0f9d4aab5aa2c6fd898ffebcbc4db7f9a157335aaf::referral_reward {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        initialized_referral: bool,
    }

    struct Record has drop, store {
        claimed_address: address,
        claimed_amount: u64,
    }

    struct Referral has key {
        id: 0x2::object::UID,
        admin_pub_key: vector<u8>,
        tracked_request_ids: 0x2::table::Table<vector<u8>, bool>,
        records: 0x2::table::Table<vector<u8>, Record>,
    }

    struct Reward has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ClaimedRewardEvent has copy, drop {
        sender: address,
        user_id: vector<u8>,
        request_id: vector<u8>,
        amount: u64,
        claimed_at: u64,
    }

    struct DepositedEvent has copy, drop {
        sender: address,
        amount: u64,
        deposited_at: u64,
    }

    fun assert_deadline(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0, 1002);
    }

    entry fun claim(arg0: &mut Referral, arg1: &mut Reward, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!is_existed_request_id(arg0, arg3), 1004);
        let v0 = 0x2::tx_context::sender(arg8);
        verify_claim_signature(v0, arg0.admin_pub_key, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = get_claimed_amount(arg2, arg0);
        assert!(arg5 > v1, 1002);
        let v2 = arg5 - v1;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= v2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v2), arg8), 0x2::tx_context::sender(arg8));
        if (!is_existed_user_id(arg0, arg2)) {
            let v3 = Record{
                claimed_address : 0x2::tx_context::sender(arg8),
                claimed_amount  : v2,
            };
            0x2::table::add<vector<u8>, Record>(&mut arg0.records, arg2, v3);
        } else {
            let v4 = 0x2::table::borrow_mut<vector<u8>, Record>(&mut arg0.records, arg2);
            v4.claimed_amount = v4.claimed_amount + v2;
        };
        let v5 = ClaimedRewardEvent{
            sender     : 0x2::tx_context::sender(arg8),
            user_id    : arg2,
            request_id : arg3,
            amount     : v2,
            claimed_at : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ClaimedRewardEvent>(v5);
    }

    public entry fun deposit(arg0: u64, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Reward, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0, 1001);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = DepositedEvent{
            sender       : 0x2::tx_context::sender(arg4),
            amount       : arg0,
            deposited_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepositedEvent>(v0);
    }

    fun get_claimed_amount(arg0: vector<u8>, arg1: &Referral) : u64 {
        let v0 = 0;
        if (is_existed_user_id(arg1, arg0)) {
            v0 = 0x2::table::borrow<vector<u8>, Record>(&arg1.records, arg0).claimed_amount;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id                   : 0x2::object::new(arg0),
            initialized_referral : false,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun init_referral(arg0: &mut AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.initialized_referral == false, 1000);
        let v0 = Referral{
            id                  : 0x2::object::new(arg2),
            admin_pub_key       : arg1,
            tracked_request_ids : 0x2::table::new<vector<u8>, bool>(arg2),
            records             : 0x2::table::new<vector<u8>, Record>(arg2),
        };
        0x2::transfer::share_object<Referral>(v0);
        let v1 = Reward{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Reward>(v1);
        arg0.initialized_referral = true;
    }

    fun is_existed_request_id(arg0: &Referral, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.tracked_request_ids, arg1)
    }

    fun is_existed_user_id(arg0: &Referral, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, Record>(&arg0.records, arg1)
    }

    fun verify_claim_signature(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_deadline(arg3, arg6, arg7);
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg1, &v0), 1003);
    }

    // decompiled from Move bytecode v6
}

