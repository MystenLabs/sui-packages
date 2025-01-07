module 0x733c9438a12138da3e0b2eed8cba26c0c27bc78f3fe57e060882a75755f73c9d::referral_reward {
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
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        is_paused: bool,
    }

    struct ClaimPausedEvent has copy, drop {
        sender: address,
        paused_at: u64,
    }

    struct ClaimUnpausedEvent has copy, drop {
        sender: address,
        unpaused_at: u64,
    }

    struct ClaimedRewardEvent has copy, drop {
        receiver: address,
        request_id: 0x1::string::String,
        amount: u64,
        claimed_at: u64,
    }

    struct WithdrawnEvent has copy, drop {
        withdrawer: address,
        amount: u64,
        withdrawn_at: u64,
    }

    struct DepositedEvent has copy, drop {
        sender: address,
        amount: u64,
        deposited_at: u64,
    }

    entry fun claim(arg0: &mut Referral, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1005);
        assert!(!is_existed_request_id(arg0, arg2), 1004);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg3, 1002);
        verify_claim_signature(arg1, arg0.admin_pub_key, arg2, arg3, arg4, arg5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg4, 1001);
        if (!is_existed_receiver(arg0, arg1)) {
            let v0 = Record{
                claimed_address : arg1,
                claimed_amount  : arg4,
            };
            0x2::table::add<address, Record>(&mut arg0.records, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, Record>(&mut arg0.records, arg1);
            v1.claimed_amount = v1.claimed_amount + arg4;
        };
        0x2::table::add<vector<u8>, bool>(&mut arg0.tracked_request_ids, arg2, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg4), arg7), arg1);
        let v2 = ClaimedRewardEvent{
            receiver   : arg1,
            request_id : 0x1::string::utf8(arg2),
            amount     : arg4,
            claimed_at : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ClaimedRewardEvent>(v2);
    }

    entry fun deposit(arg0: u64, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Referral, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
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
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            is_paused           : false,
        };
        0x2::transfer::share_object<Referral>(v0);
        arg0.initialized_referral = true;
    }

    fun is_existed_receiver(arg0: &Referral, arg1: address) : bool {
        0x2::table::contains<address, Record>(&arg0.records, arg1)
    }

    fun is_existed_request_id(arg0: &Referral, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.tracked_request_ids, arg1)
    }

    entry fun pause(arg0: &mut Referral, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1006);
        arg0.is_paused = true;
        let v0 = ClaimPausedEvent{
            sender    : 0x2::tx_context::sender(arg3),
            paused_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ClaimPausedEvent>(v0);
    }

    entry fun unpause(arg0: &mut Referral, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.is_paused, 1007);
        arg0.is_paused = false;
        let v0 = ClaimUnpausedEvent{
            sender      : 0x2::tx_context::sender(arg3),
            unpaused_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ClaimUnpausedEvent>(v0);
    }

    fun verify_claim_signature(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>) {
        let v0 = b"SUI_REFERRAL";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg1, &v0), 1003);
    }

    entry fun withdraw(arg0: &mut Referral, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v0 = WithdrawnEvent{
            withdrawer   : 0x2::tx_context::sender(arg4),
            amount       : arg2,
            withdrawn_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WithdrawnEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

