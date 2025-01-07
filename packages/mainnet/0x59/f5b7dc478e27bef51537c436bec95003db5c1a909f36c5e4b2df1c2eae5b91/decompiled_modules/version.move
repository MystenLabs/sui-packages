module 0x59f5b7dc478e27bef51537c436bec95003db5c1a909f36c5e4b2df1c2eae5b91::version {
    struct Version has key {
        id: 0x2::object::UID,
        value: u64,
        fee_pool: FeePool,
        authority: 0x2::vec_set::VecSet<address>,
        witness: 0x1::type_name::TypeName,
        u64_padding: vector<u64>,
    }

    struct FeePool has store, key {
        id: 0x2::object::UID,
        fee_infos: vector<FeeInfo>,
    }

    struct FeeInfo has copy, drop, store {
        token: 0x1::type_name::TypeName,
        value: u64,
    }

    entry fun add_authorized_user(arg0: &mut Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_authority(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.authority, &arg1), 5);
        0x2::vec_set::insert<address>(&mut arg0.authority, arg1);
    }

    public fun charge_fee<T0>(arg0: &mut Version, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeInfo>(&arg0.fee_pool.fee_infos)) {
            let v1 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.fee_pool.fee_infos, v0);
            if (v1.token == 0x1::type_name::get<T0>()) {
                v1.value = v1.value + 0x2::balance::value<T0>(&arg1);
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::get<T0>()), arg1);
                return
            };
            v0 = v0 + 1;
        };
        let v2 = FeeInfo{
            token : 0x1::type_name::get<T0>(),
            value : 0x2::balance::value<T0>(&arg1),
        };
        0x1::vector::push_back<FeeInfo>(&mut arg0.fee_pool.fee_infos, v2);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::get<T0>(), arg1);
    }

    public fun issue_version<T0: drop, T1: drop>(arg0: &T0, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = FeePool{
            id        : 0x2::object::new(arg2),
            fee_infos : 0x1::vector::empty<FeeInfo>(),
        };
        let v1 = Version{
            id          : 0x2::object::new(arg2),
            value       : 1,
            fee_pool    : v0,
            authority   : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg2)),
            witness     : 0x1::type_name::get<T1>(),
            u64_padding : vector[],
        };
        0x2::transfer::share_object<Version>(v1);
    }

    entry fun remove_authorized_user(arg0: &mut Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_authority(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &arg1), 6);
        0x2::vec_set::remove<address>(&mut arg0.authority, &arg1);
        assert!(0x2::vec_set::size<address>(&arg0.authority) > 0, 4);
    }

    entry fun send_fee<T0>(arg0: &mut Version, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        verify_authority(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeInfo>(&arg0.fee_pool.fee_infos)) {
            let v1 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.fee_pool.fee_infos, v0);
            if (v1.token == 0x1::type_name::get<T0>()) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::get<T0>())), arg2), arg1);
                v1.value = 0;
                return
            };
            v0 = v0 + 1;
        };
    }

    entry fun upgrade(arg0: &mut Version, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0, arg1);
        verify_authority(arg0, arg2);
        arg0.value = arg1;
    }

    public fun verify_authority(arg0: &Version, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 3);
    }

    public fun verify_version(arg0: &Version, arg1: u64) {
        assert!(arg1 >= arg0.value, 1);
    }

    public fun verify_witness<T0: drop>(arg0: &Version, arg1: T0) {
        assert!(0x1::type_name::get<T0>() == arg0.witness, 2);
    }

    // decompiled from Move bytecode v6
}

