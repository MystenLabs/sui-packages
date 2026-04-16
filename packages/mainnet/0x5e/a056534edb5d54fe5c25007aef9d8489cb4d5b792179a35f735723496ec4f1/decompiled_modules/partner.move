module 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner {
    struct Partners has key {
        id: 0x2::object::UID,
        partners: 0x2::vec_map::VecMap<0x1::string::String, PartnerInfo>,
    }

    struct PartnerInfo has copy, drop, store {
        partner_id: 0x2::object::ID,
        partner_cap_id: 0x2::object::ID,
    }

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        partner_id: 0x2::object::ID,
    }

    struct Partner has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        ref_fee_rate: u64,
        start_time: u64,
        end_time: u64,
        balances: 0x2::bag::Bag,
    }

    struct InitPartnerEvent has copy, drop {
        partners: 0x2::object::ID,
    }

    struct CreatePartnerEvent has copy, drop {
        recipient: address,
        partner_id: 0x2::object::ID,
        partner_cap_id: 0x2::object::ID,
        ref_fee_rate: u64,
        name: 0x1::string::String,
        start_time: u64,
        end_time: u64,
    }

    struct UpdateRefFeeRateEvent has copy, drop {
        partner_id: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct UpdateTimeRangeEvent has copy, drop {
        partner_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
    }

    struct ReceiveRefFeeEvent has copy, drop {
        partner_id: 0x2::object::ID,
        amount: u64,
        type_name: 0x1::string::String,
    }

    struct ClaimRefFeeEvent has copy, drop {
        partner_id: 0x2::object::ID,
        amount: u64,
        type_name: 0x1::string::String,
    }

    public fun balances(arg0: &Partner) : &0x2::bag::Bag {
        &arg0.balances
    }

    public fun claim_ref_fee<T0>(arg0: &mut Partner, arg1: &PartnerCap, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg2);
        assert!(arg1.partner_id == 0x2::object::id<Partner>(arg0), 13906836077014417417);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.balances, v0), 13906836098489384971);
        let v1 = 0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        let v2 = ClaimRefFeeEvent{
            partner_id : 0x2::object::id<Partner>(arg0),
            amount     : 0x2::balance::value<T0>(&v1),
            type_name  : v0,
        };
        0x2::event::emit<ClaimRefFeeEvent>(v2);
        0x2::coin::from_balance<T0>(v1, arg3)
    }

    public fun create_partner(arg0: &mut Partners, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg7: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg7);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_partner_manager(arg6, 0x2::tx_context::sender(arg9));
        let v0 = 0x2::clock::timestamp_ms(arg8) / 1000;
        assert!(arg4 > arg3, 13906835252380172289);
        assert!(arg4 > v0, 13906835256675139585);
        assert!(arg2 <= 1000000000, 13906835260970237955);
        assert!(!0x1::string::is_empty(&arg1), 13906835265265336325);
        assert!(!0x2::vec_map::contains<0x1::string::String, PartnerInfo>(&arg0.partners, &arg1), 13906835269560434695);
        assert!(arg5 != @0x0, 13906835273855795213);
        let v1 = if (arg3 < v0) {
            v0
        } else {
            arg3
        };
        let v2 = Partner{
            id           : 0x2::object::new(arg9),
            name         : arg1,
            ref_fee_rate : arg2,
            start_time   : v1,
            end_time     : arg4,
            balances     : 0x2::bag::new(arg9),
        };
        let v3 = PartnerCap{
            id         : 0x2::object::new(arg9),
            name       : arg1,
            partner_id : 0x2::object::id<Partner>(&v2),
        };
        let v4 = 0x2::object::id<Partner>(&v2);
        let v5 = 0x2::object::id<PartnerCap>(&v3);
        let v6 = PartnerInfo{
            partner_id     : v4,
            partner_cap_id : v5,
        };
        0x2::vec_map::insert<0x1::string::String, PartnerInfo>(&mut arg0.partners, arg1, v6);
        0x2::transfer::share_object<Partner>(v2);
        0x2::transfer::transfer<PartnerCap>(v3, arg5);
        let v7 = CreatePartnerEvent{
            recipient      : arg5,
            partner_id     : v4,
            partner_cap_id : v5,
            ref_fee_rate   : arg2,
            name           : arg1,
            start_time     : v1,
            end_time       : arg4,
        };
        0x2::event::emit<CreatePartnerEvent>(v7);
    }

    public fun current_ref_fee_rate(arg0: &Partner, arg1: u64) : u64 {
        if (arg0.start_time > arg1 || arg0.end_time <= arg1) {
            return 0
        };
        arg0.ref_fee_rate
    }

    public fun end_time(arg0: &Partner) : u64 {
        arg0.end_time
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Partners{
            id       : 0x2::object::new(arg0),
            partners : 0x2::vec_map::empty<0x1::string::String, PartnerInfo>(),
        };
        0x2::transfer::share_object<Partners>(v0);
        let v1 = InitPartnerEvent{partners: 0x2::object::id<Partners>(&v0)};
        0x2::event::emit<InitPartnerEvent>(v1);
    }

    public fun name(arg0: &Partner) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun receive_ref_fee<T0>(arg0: &mut Partner, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (0x2::bag::contains<0x1::string::String>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
        let v1 = ReceiveRefFeeEvent{
            partner_id : 0x2::object::id<Partner>(arg0),
            amount     : 0x2::balance::value<T0>(&arg1),
            type_name  : v0,
        };
        0x2::event::emit<ReceiveRefFeeEvent>(v1);
    }

    public fun ref_fee_rate(arg0: &Partner) : u64 {
        arg0.ref_fee_rate
    }

    public fun start_time(arg0: &Partner) : u64 {
        arg0.start_time
    }

    public fun update_ref_fee_rate(arg0: &mut Partner, arg1: u64, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg3: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg3);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_partner_manager(arg2, 0x2::tx_context::sender(arg4));
        assert!(arg1 != arg0.ref_fee_rate, 13906835583092785155);
        assert!(arg1 <= 1000000000, 13906835587387752451);
        arg0.ref_fee_rate = arg1;
        let v0 = UpdateRefFeeRateEvent{
            partner_id   : 0x2::object::id<Partner>(arg0),
            old_fee_rate : arg0.ref_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateRefFeeRateEvent>(v0);
    }

    public fun update_time_range(arg0: &mut Partner, arg1: u64, arg2: u64, arg3: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg4: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg4);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_partner_manager(arg3, 0x2::tx_context::sender(arg6));
        assert!(arg2 > arg1, 13906835772071215105);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg5) / 1000, 13906835776366182401);
        assert!(arg1 != arg0.start_time || arg2 != arg0.end_time, 13906835780661149697);
        arg0.start_time = arg1;
        arg0.end_time = arg2;
        let v0 = UpdateTimeRangeEvent{
            partner_id : 0x2::object::id<Partner>(arg0),
            start_time : arg1,
            end_time   : arg2,
        };
        0x2::event::emit<UpdateTimeRangeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

