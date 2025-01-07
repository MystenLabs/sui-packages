module 0xf22bca2db5158e1fc6fb7c4f71b4a0428c7829c8b4f20790f7a95d4e277bd884::referral_reward {
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
        records: 0x2::table::Table<address, Record>,
    }

    struct Reward has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ClaimedRewardEvent has copy, drop {
        receiver: address,
        request_id: vector<u8>,
        amount: u64,
        claimed_at: u64,
    }

    struct DepositedEvent has copy, drop {
        sender: address,
        amount: u64,
        deposited_at: u64,
    }

    entry fun claim(arg0: &mut Referral, arg1: &mut Reward, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!is_existed_request_id(arg0, arg3), 1004);
        assert!(0x2::clock::timestamp_ms(arg7) <= arg4, 1002);
        verify_claim_signature(arg2, arg0.admin_pub_key, arg3, arg4, arg5, arg6);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg5, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg5), arg8), arg2);
        if (!is_existed_receiver(arg0, arg2)) {
            let v0 = Record{
                claimed_address : arg2,
                claimed_amount  : arg5,
            };
            0x2::table::add<address, Record>(&mut arg0.records, arg2, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, Record>(&mut arg0.records, arg2);
            v1.claimed_amount = v1.claimed_amount + arg5;
        };
        0x2::table::add<vector<u8>, bool>(&mut arg0.tracked_request_ids, arg3, true);
        let v2 = ClaimedRewardEvent{
            receiver   : arg2,
            request_id : arg3,
            amount     : arg5,
            claimed_at : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ClaimedRewardEvent>(v2);
    }

    entry fun deposit(arg0: u64, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Reward, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
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
            records             : 0x2::table::new<address, Record>(arg2),
        };
        0x2::transfer::share_object<Referral>(v0);
        let v1 = Reward{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Reward>(v1);
        arg0.initialized_referral = true;
    }

    fun is_existed_receiver(arg0: &Referral, arg1: address) : bool {
        0x2::table::contains<address, Record>(&arg0.records, arg1)
    }

    fun is_existed_request_id(arg0: &Referral, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.tracked_request_ids, arg1)
    }

    entry fun is_request_claimed(arg0: &Referral, arg1: vector<u8>) : bool {
        is_existed_request_id(arg0, arg1)
    }

    fun verify_claim_signature(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>) {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg1, &v0), 1003);
    }

    // decompiled from Move bytecode v6
}

