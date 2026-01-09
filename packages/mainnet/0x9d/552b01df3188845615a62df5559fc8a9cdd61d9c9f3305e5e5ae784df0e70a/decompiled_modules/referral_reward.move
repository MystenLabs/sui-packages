module 0x9d552b01df3188845615a62df5559fc8a9cdd61d9c9f3305e5e5ae784df0e70a::referral_reward {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        initialized_referral: bool,
    }

    struct Record has drop, store {
        claimed_address: address,
        claimed_amount: u64,
    }

    struct Referral<phantom T0> has key {
        id: 0x2::object::UID,
        verifier_pub_key: vector<u8>,
        tracked_request_ids: 0x2::table::Table<vector<u8>, bool>,
        records: 0x2::table::Table<0x1::ascii::String, Record>,
        balance_native: 0x2::balance::Balance<0x2::sui::SUI>,
        balance_token: 0x2::balance::Balance<T0>,
        is_paused: bool,
    }

    struct ClaimPausedEvent has copy, drop {
        paused_at: u64,
    }

    struct ClaimUnpausedEvent has copy, drop {
        unpaused_at: u64,
    }

    struct ClaimedRewardEvent has copy, drop {
        currency: 0x1::ascii::String,
        request_id: 0x1::string::String,
        amount: u64,
        claimed_at: u64,
    }

    struct WithdrawnEvent has copy, drop {
        currency: 0x1::ascii::String,
        amount: u64,
        withdrawn_at: u64,
    }

    struct DepositedEvent has copy, drop {
        currency: 0x1::ascii::String,
        amount: u64,
        deposited_at: u64,
    }

    fun address_to_hex_string(arg0: address) : 0x1::ascii::String {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = b"0123456789abcdef";
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v0)) {
            let v4 = *0x1::vector::borrow<u8>(&v0, v3);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, (((v4 >> 4) as u8) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, (((v4 & 15) as u8) as u64)));
            v3 = v3 + 1;
        };
        0x1::ascii::string(v2)
    }

    entry fun change_verifier_pub_key<T0>(arg0: &AdminCap, arg1: &mut Referral<T0>, arg2: vector<u8>) {
        arg1.verifier_pub_key = arg2;
    }

    entry fun claim<T0>(arg0: &mut Referral<T0>, arg1: address, arg2: vector<u8>, arg3: bool, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1005);
        assert!(!is_existed_request_id<T0>(arg0, arg2), 1004);
        assert!(0x2::clock::timestamp_ms(arg7) <= arg4, 1002);
        verify_claim_signature(arg1, arg0.verifier_pub_key, arg2, arg3, arg4, arg5, arg6);
        let v0 = if (arg3) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.balance_native)
        } else {
            0x2::balance::value<T0>(&arg0.balance_token)
        };
        assert!(v0 >= arg5, 1001);
        let v1 = get_currency<T0>(arg3);
        if (!is_existed_receiver<T0>(arg0, arg1, v1)) {
            let v2 = Record{
                claimed_address : arg1,
                claimed_amount  : arg5,
            };
            0x2::table::add<0x1::ascii::String, Record>(&mut arg0.records, get_record_key(arg1, v1), v2);
        } else {
            let v3 = 0x2::table::borrow_mut<0x1::ascii::String, Record>(&mut arg0.records, get_record_key(arg1, v1));
            v3.claimed_amount = v3.claimed_amount + arg5;
        };
        0x2::table::add<vector<u8>, bool>(&mut arg0.tracked_request_ids, arg2, true);
        if (arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_native, arg5), arg8), arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_token, arg5), arg8), arg1);
        };
        let v4 = ClaimedRewardEvent{
            currency   : v1,
            request_id : 0x1::string::utf8(arg2),
            amount     : arg5,
            claimed_at : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ClaimedRewardEvent>(v4);
    }

    entry fun deposit_native<T0>(arg0: u64, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Referral<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0, 1001);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance_native, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = DepositedEvent{
            currency     : get_currency<T0>(true),
            amount       : arg0,
            deposited_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepositedEvent>(v0);
    }

    entry fun deposit_token<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut Referral<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg0, 1001);
        0x2::balance::join<T0>(&mut arg2.balance_token, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg0, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = DepositedEvent{
            currency     : get_currency<T0>(false),
            amount       : arg0,
            deposited_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepositedEvent>(v0);
    }

    fun get_currency<T0>(arg0: bool) : 0x1::ascii::String {
        if (arg0) {
            0x1::type_name::into_string(0x1::type_name::with_original_ids<0x2::sui::SUI>())
        } else {
            0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
        }
    }

    fun get_record_key(arg0: address, arg1: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = address_to_hex_string(arg0);
        0x1::ascii::append(&mut v0, 0x1::ascii::string(b"::"));
        0x1::ascii::append(&mut v0, arg1);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id                   : 0x2::object::new(arg0),
            initialized_referral : false,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun init_referral<T0>(arg0: &mut AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.initialized_referral == false, 1000);
        let v0 = Referral<T0>{
            id                  : 0x2::object::new(arg2),
            verifier_pub_key    : arg1,
            tracked_request_ids : 0x2::table::new<vector<u8>, bool>(arg2),
            records             : 0x2::table::new<0x1::ascii::String, Record>(arg2),
            balance_native      : 0x2::balance::zero<0x2::sui::SUI>(),
            balance_token       : 0x2::balance::zero<T0>(),
            is_paused           : false,
        };
        0x2::transfer::share_object<Referral<T0>>(v0);
        arg0.initialized_referral = true;
    }

    fun is_existed_receiver<T0>(arg0: &Referral<T0>, arg1: address, arg2: 0x1::ascii::String) : bool {
        0x2::table::contains<0x1::ascii::String, Record>(&arg0.records, get_record_key(arg1, arg2))
    }

    fun is_existed_request_id<T0>(arg0: &Referral<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.tracked_request_ids, arg1)
    }

    entry fun pause<T0>(arg0: &mut Referral<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1006);
        arg0.is_paused = true;
        let v0 = ClaimPausedEvent{paused_at: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<ClaimPausedEvent>(v0);
    }

    entry fun unpause<T0>(arg0: &mut Referral<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.is_paused, 1007);
        arg0.is_paused = false;
        let v0 = ClaimUnpausedEvent{unpaused_at: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<ClaimUnpausedEvent>(v0);
    }

    fun verify_claim_signature(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: bool, arg4: u64, arg5: u64, arg6: vector<u8>) {
        let v0 = b"SUI_REFERRAL";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg1, &v0), 1003);
    }

    entry fun withdraw<T0>(arg0: &mut Referral<T0>, arg1: &AdminCap, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.balance_native)
        } else {
            0x2::balance::value<T0>(&arg0.balance_token)
        };
        assert!(v0 >= arg3, 1001);
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_native, arg3), arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_token, arg3), arg5), 0x2::tx_context::sender(arg5));
        };
        let v1 = WithdrawnEvent{
            currency     : get_currency<T0>(arg2),
            amount       : arg3,
            withdrawn_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<WithdrawnEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

