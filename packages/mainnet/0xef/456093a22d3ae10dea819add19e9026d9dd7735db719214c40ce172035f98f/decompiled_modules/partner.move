module 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::partner {
    struct Partners has key {
        id: 0x2::object::UID,
        partners: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
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
        partners_id: 0x2::object::ID,
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

    public fun claim_ref_fee<T0>(arg0: &mut Partner, arg1: &PartnerCap, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg2);
        assert!(arg1.partner_id == 0x2::object::id<Partner>(arg0), 13906835973935202313);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.balances, v0), 13906835995410169867);
        let v1 = 0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        let v2 = ClaimRefFeeEvent{
            partner_id : 0x2::object::id<Partner>(arg0),
            amount     : 0x2::balance::value<T0>(&v1),
            type_name  : v0,
        };
        0x2::event::emit<ClaimRefFeeEvent>(v2);
        0x2::coin::from_balance<T0>(v1, arg3)
    }

    public fun create_partner(arg0: &mut Partners, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg7: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg7);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_partner_manager_role(arg6, 0x2::tx_context::sender(arg9));
        assert!(arg4 > arg3, 13906835205135532033);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg8) / 1000, 13906835209430499329);
        assert!(arg2 <= 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::constants::max_partner_fee_rate(), 13906835213725597699);
        assert!(!0x1::string::is_empty(&arg1), 13906835218020696069);
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&arg0.partners, &arg1), 13906835222315794439);
        let v0 = Partner{
            id           : 0x2::object::new(arg9),
            name         : arg1,
            ref_fee_rate : arg2,
            start_time   : arg3,
            end_time     : arg4,
            balances     : 0x2::bag::new(arg9),
        };
        let v1 = PartnerCap{
            id         : 0x2::object::new(arg9),
            name       : arg1,
            partner_id : 0x2::object::id<Partner>(&v0),
        };
        let v2 = 0x2::object::id<Partner>(&v0);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut arg0.partners, arg1, v2);
        0x2::transfer::share_object<Partner>(v0);
        0x2::transfer::transfer<PartnerCap>(v1, arg5);
        let v3 = CreatePartnerEvent{
            recipient      : arg5,
            partner_id     : v2,
            partner_cap_id : 0x2::object::id<PartnerCap>(&v1),
            ref_fee_rate   : arg2,
            name           : arg1,
            start_time     : arg3,
            end_time       : arg4,
        };
        0x2::event::emit<CreatePartnerEvent>(v3);
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
            partners : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<Partners>(v0);
        let v1 = InitPartnerEvent{partners_id: 0x2::object::id<Partners>(&v0)};
        0x2::event::emit<InitPartnerEvent>(v1);
    }

    public fun name(arg0: &Partner) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun receive_ref_fee<T0>(arg0: &mut Partner, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
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

    public fun update_ref_fee_rate(arg0: &mut Partner, arg1: u64, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg3: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg3);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_partner_manager_role(arg2, 0x2::tx_context::sender(arg4));
        assert!(arg1 <= 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::constants::max_partner_fee_rate(), 13906835475718602755);
        arg0.ref_fee_rate = arg1;
        let v0 = UpdateRefFeeRateEvent{
            partner_id   : 0x2::object::id<Partner>(arg0),
            old_fee_rate : arg0.ref_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateRefFeeRateEvent>(v0);
    }

    public fun update_time_range(arg0: &mut Partner, arg1: u64, arg2: u64, arg3: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg4: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg4);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_partner_manager_role(arg3, 0x2::tx_context::sender(arg6));
        assert!(arg2 > arg1, 13906835664697032705);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg5) / 1000, 13906835668992000001);
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

