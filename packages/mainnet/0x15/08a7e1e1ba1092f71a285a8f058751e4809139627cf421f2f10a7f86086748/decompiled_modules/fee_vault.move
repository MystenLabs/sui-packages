module 0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::fee_vault {
    struct FeeVault has key {
        id: 0x2::object::UID,
        total_ratio: u16,
        participants: 0x2::linked_table::LinkedTable<address, Participant>,
    }

    struct Participant has store {
        address: address,
        share_ratio: u16,
        bag: 0x2::bag::Bag,
    }

    struct AddParticipantEvent has copy, drop {
        address: address,
        share_ratio: u16,
    }

    struct RemoveParticipantEvent has copy, drop {
        address: address,
        share_ratio: u16,
    }

    struct ClaimEarningEvent has copy, drop {
        address: address,
        amount: u64,
        type_name: 0x1::type_name::TypeName,
    }

    struct UpdateShareRatioEvent has copy, drop {
        address: address,
        old_share_ratio: u16,
        new_share_ratio: u16,
    }

    struct DistributeEvent has copy, drop {
        amount: u64,
        type_name: 0x1::type_name::TypeName,
    }

    public entry fun add_participant(arg0: &0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::PumpAdminCap, arg1: &0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::Configs, arg2: &mut FeeVault, arg3: address, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::assert_valid_package(arg1);
        assert!(!0x2::linked_table::contains<address, Participant>(&arg2.participants, arg3), 0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::errors::participant_already_exists());
        let v0 = Participant{
            address     : arg3,
            share_ratio : arg4,
            bag         : 0x2::bag::new(arg5),
        };
        0x2::linked_table::push_back<address, Participant>(&mut arg2.participants, arg3, v0);
        arg2.total_ratio = arg2.total_ratio + arg4;
        valid_participants(arg2);
        let v1 = AddParticipantEvent{
            address     : arg3,
            share_ratio : arg4,
        };
        0x2::event::emit<AddParticipantEvent>(v1);
    }

    public fun claim_earning<T0>(arg0: &0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::Configs, arg1: &mut FeeVault, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::assert_valid_package(arg0);
        assert!(0x2::linked_table::contains<address, Participant>(&arg1.participants, 0x2::tx_context::sender(arg2)), 0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::errors::not_participant());
        let v0 = 0x2::linked_table::borrow_mut<address, Participant>(&mut arg1.participants, 0x2::tx_context::sender(arg2));
        assert!(v0.address == 0x2::tx_context::sender(arg2), 0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::errors::participant_error());
        let v1 = take_earning<T0>(v0);
        let v2 = ClaimEarningEvent{
            address   : v0.address,
            amount    : 0x2::balance::value<T0>(&v1),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ClaimEarningEvent>(v2);
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    public fun distribute_earnings<T0>(arg0: &mut FeeVault, arg1: 0x2::balance::Balance<T0>) {
        assert!(arg0.total_ratio > 0 && 0x2::linked_table::length<address, Participant>(&arg0.participants) > 0, 0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::errors::no_participant_exists());
        let v0 = &mut arg0.participants;
        let v1 = 0x2::balance::value<T0>(&arg1);
        let v2 = *0x2::linked_table::front<address, Participant>(v0);
        while (0x1::option::is_some<address>(&v2)) {
            v2 = *0x2::linked_table::next<address, Participant>(v0, *0x1::option::borrow<address>(&v2));
            let v3 = 0x2::linked_table::borrow_mut<address, Participant>(v0, *0x1::option::borrow<address>(&v2));
            if (0x1::option::is_some<address>(&v2)) {
                let v4 = 0x2::balance::split<T0>(&mut arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(v1, (v3.share_ratio as u64), (arg0.total_ratio as u64)));
                merge_eaning<T0>(v3, v4);
            } else {
                merge_eaning<T0>(v3, 0x2::balance::split<T0>(&mut arg1, 0x2::balance::value<T0>(&arg1)));
                break
            };
        };
        0x2::balance::destroy_zero<T0>(arg1);
        let v5 = DistributeEvent{
            amount    : v1,
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DistributeEvent>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeVault{
            id           : 0x2::object::new(arg0),
            total_ratio  : 0,
            participants : 0x2::linked_table::new<address, Participant>(arg0),
        };
        0x2::transfer::share_object<FeeVault>(v0);
    }

    fun merge_eaning<T0>(arg0: &mut Participant, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<0x1::string::String>(&arg0.bag, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0, arg1);
        };
    }

    public entry fun remove_participant(arg0: &0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::PumpAdminCap, arg1: &0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::Configs, arg2: &mut FeeVault, arg3: address) {
        0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::assert_valid_package(arg1);
        assert!(0x2::linked_table::contains<address, Participant>(&arg2.participants, arg3), 0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::errors::no_participant_exists());
        let v0 = 0x2::linked_table::remove<address, Participant>(&mut arg2.participants, arg3);
        arg2.total_ratio = arg2.total_ratio - v0.share_ratio;
        let Participant {
            address     : v1,
            share_ratio : v2,
            bag         : v3,
        } = v0;
        0x2::bag::destroy_empty(v3);
        valid_participants(arg2);
        let v4 = RemoveParticipantEvent{
            address     : v1,
            share_ratio : v2,
        };
        0x2::event::emit<RemoveParticipantEvent>(v4);
    }

    fun take_earning<T0>(arg0: &mut Participant) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.bag, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0)
    }

    public entry fun update_share_ratio(arg0: &0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::PumpAdminCap, arg1: &0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::Configs, arg2: &mut FeeVault, arg3: address, arg4: u16) {
        0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::config::assert_valid_package(arg1);
        assert!(0x2::linked_table::contains<address, Participant>(&arg2.participants, arg3), 0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::errors::no_participant_exists());
        let v0 = 0x2::linked_table::borrow_mut<address, Participant>(&mut arg2.participants, arg3);
        let v1 = v0.share_ratio;
        v0.share_ratio = arg4;
        let v2 = UpdateShareRatioEvent{
            address         : v0.address,
            old_share_ratio : v1,
            new_share_ratio : arg4,
        };
        0x2::event::emit<UpdateShareRatioEvent>(v2);
        arg2.total_ratio = arg2.total_ratio - v1;
        arg2.total_ratio = arg2.total_ratio + arg4;
        valid_participants(arg2);
    }

    fun valid_participants(arg0: &FeeVault) {
        let v0 = &arg0.participants;
        let v1 = *0x2::linked_table::front<address, Participant>(v0);
        let v2 = 0;
        while (0x1::option::is_some<address>(&v1)) {
            v2 = v2 + 0x2::linked_table::borrow<address, Participant>(v0, *0x1::option::borrow<address>(&v1)).share_ratio;
            let v3 = 0x2::linked_table::next<address, Participant>(v0, *0x1::option::borrow<address>(&v1));
            v1 = *v3;
        };
        assert!(v2 == arg0.total_ratio, 0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::errors::share_error());
    }

    // decompiled from Move bytecode v6
}

