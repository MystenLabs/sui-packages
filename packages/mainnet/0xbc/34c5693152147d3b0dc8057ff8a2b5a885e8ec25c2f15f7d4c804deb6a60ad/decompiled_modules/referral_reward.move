module 0xbc34c5693152147d3b0dc8057ff8a2b5a885e8ec25c2f15f7d4c804deb6a60ad::referral_reward {
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
        operator: address,
        records: 0x2::table::Table<0x1::ascii::String, Record>,
        tracked_request_ids: 0x2::table::Table<0x1::string::String, bool>,
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
        recipient: address,
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

    struct OperatorChangedEvent has copy, drop {
        new_operator: address,
    }

    struct WhitelistTokenAddedEvent has copy, drop {
        currency: 0x1::ascii::String,
    }

    entry fun add_whitelist_token<T0>(arg0: &AdminCap, arg1: &mut Referral, arg2: &0x2::tx_context::TxContext) {
        let v0 = get_currency<T0>();
        assert!(!0x2::dynamic_field::exists_with_type<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg1.id, v0), 1010);
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.id, v0, 0x2::balance::zero<T0>());
        let v1 = WhitelistTokenAddedEvent{currency: v0};
        0x2::event::emit<WhitelistTokenAddedEvent>(v1);
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

    entry fun change_operator(arg0: &AdminCap, arg1: &mut Referral, arg2: address, arg3: &0x2::tx_context::TxContext) {
        arg1.operator = arg2;
        let v0 = OperatorChangedEvent{new_operator: arg2};
        0x2::event::emit<OperatorChangedEvent>(v0);
    }

    entry fun claim<T0>(arg0: &mut Referral, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.operator, 1004);
        assert!(!arg0.is_paused, 1005);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.tracked_request_ids, arg3), 1008);
        let v0 = get_currency<T0>();
        assert!(0x2::dynamic_field::exists_with_type<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.id, v0), 1009);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg5), arg1);
        0x2::table::add<0x1::string::String, bool>(&mut arg0.tracked_request_ids, arg3, true);
        if (!is_existed_record(arg0, arg1, v0)) {
            let v2 = Record{
                claimed_address : arg1,
                claimed_amount  : arg2,
            };
            0x2::table::add<0x1::ascii::String, Record>(&mut arg0.records, get_record_key(arg1, v0), v2);
        } else {
            let v3 = 0x2::table::borrow_mut<0x1::ascii::String, Record>(&mut arg0.records, get_record_key(arg1, v0));
            v3.claimed_amount = v3.claimed_amount + arg2;
        };
        let v4 = ClaimedRewardEvent{
            currency   : v0,
            recipient  : arg1,
            amount     : arg2,
            claimed_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClaimedRewardEvent>(v4);
    }

    entry fun deposit<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut Referral, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg0, 1001);
        let v0 = get_currency<T0>();
        assert!(0x2::dynamic_field::exists_with_type<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg2.id, v0), 1009);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg2.id, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg0, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        let v1 = DepositedEvent{
            currency     : v0,
            amount       : arg0,
            deposited_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepositedEvent>(v1);
    }

    fun get_currency<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
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

    entry fun init_referral<T0>(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.initialized_referral == false, 1000);
        let v0 = Referral{
            id                  : 0x2::object::new(arg1),
            operator            : 0x2::tx_context::sender(arg1),
            records             : 0x2::table::new<0x1::ascii::String, Record>(arg1),
            tracked_request_ids : 0x2::table::new<0x1::string::String, bool>(arg1),
            is_paused           : false,
        };
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.id, get_currency<0x2::sui::SUI>(), 0x2::balance::zero<0x2::sui::SUI>());
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, get_currency<T0>(), 0x2::balance::zero<T0>());
        0x2::transfer::share_object<Referral>(v0);
        arg0.initialized_referral = true;
    }

    fun is_existed_record(arg0: &Referral, arg1: address, arg2: 0x1::ascii::String) : bool {
        0x2::table::contains<0x1::ascii::String, Record>(&arg0.records, get_record_key(arg1, arg2))
    }

    entry fun pause(arg0: &mut Referral, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1006);
        arg0.is_paused = true;
        let v0 = ClaimPausedEvent{paused_at: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<ClaimPausedEvent>(v0);
    }

    entry fun unpause(arg0: &mut Referral, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.is_paused, 1007);
        arg0.is_paused = false;
        let v0 = ClaimUnpausedEvent{unpaused_at: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<ClaimUnpausedEvent>(v0);
    }

    entry fun withdraw<T0>(arg0: &mut Referral, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_currency<T0>();
        assert!(0x2::dynamic_field::exists_with_type<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.id, v0), 1009);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v2 = WithdrawnEvent{
            currency     : v0,
            amount       : arg2,
            withdrawn_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WithdrawnEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

