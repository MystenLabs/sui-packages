module 0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::partner {
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

    public fun claim_ref_fee<T0>(arg0: &0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::GlobalConfig, arg1: &PartnerCap, arg2: &mut Partner, arg3: &mut 0x2::tx_context::TxContext) {
        0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::checked_package_version(arg0);
        assert!(arg1.partner_id == 0x2::object::id<Partner>(arg2), 4);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::bag::contains<0x1::string::String>(&arg2.balances, v0), 5);
        let v1 = 0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg2.balances, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), 0x2::tx_context::sender(arg3));
        let v2 = ClaimRefFeeEvent{
            partner_id : 0x2::object::id<Partner>(arg2),
            amount     : 0x2::balance::value<T0>(&v1),
            type_name  : v0,
        };
        0x2::event::emit<ClaimRefFeeEvent>(v2);
    }

    public fun create_partner(arg0: &0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::GlobalConfig, arg1: &mut Partners, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > arg4, 2);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg7) / 1000, 2);
        assert!(arg3 < 10000, 3);
        assert!(!0x1::string::is_empty(&arg2), 6);
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&arg1.partners, &arg2), 1);
        0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::checked_package_version(arg0);
        0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::check_partner_manager_role(arg0, 0x2::tx_context::sender(arg8));
        let v0 = Partner{
            id           : 0x2::object::new(arg8),
            name         : arg2,
            ref_fee_rate : arg3,
            start_time   : arg4,
            end_time     : arg5,
            balances     : 0x2::bag::new(arg8),
        };
        let v1 = PartnerCap{
            id         : 0x2::object::new(arg8),
            name       : arg2,
            partner_id : 0x2::object::id<Partner>(&v0),
        };
        let v2 = 0x2::object::id<Partner>(&v0);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut arg1.partners, arg2, v2);
        0x2::transfer::share_object<Partner>(v0);
        0x2::transfer::transfer<PartnerCap>(v1, arg6);
        let v3 = CreatePartnerEvent{
            recipient      : arg6,
            partner_id     : v2,
            partner_cap_id : 0x2::object::id<PartnerCap>(&v1),
            ref_fee_rate   : arg3,
            name           : arg2,
            start_time     : arg4,
            end_time       : arg5,
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

    public fun receive_ref_fee<T0>(arg0: &mut Partner, arg1: 0x2::balance::Balance<T0>) {
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

    public fun update_ref_fee_rate(arg0: &0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::GlobalConfig, arg1: &mut Partner, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 < 10000, 3);
        0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::checked_package_version(arg0);
        0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::check_partner_manager_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.ref_fee_rate = arg2;
        let v0 = UpdateRefFeeRateEvent{
            partner_id   : 0x2::object::id<Partner>(arg1),
            old_fee_rate : arg1.ref_fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateRefFeeRateEvent>(v0);
    }

    public fun update_time_range(arg0: &0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::GlobalConfig, arg1: &mut Partner, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > arg2, 2);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4) / 1000, 2);
        0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::checked_package_version(arg0);
        0x7f73ade65d315457ac2374f1711e4c68c7003675403c0bf19d753f069143959c::config::check_partner_manager_role(arg0, 0x2::tx_context::sender(arg5));
        arg1.start_time = arg2;
        arg1.end_time = arg3;
        let v0 = UpdateTimeRangeEvent{
            partner_id : 0x2::object::id<Partner>(arg1),
            start_time : arg2,
            end_time   : arg3,
        };
        0x2::event::emit<UpdateTimeRangeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

