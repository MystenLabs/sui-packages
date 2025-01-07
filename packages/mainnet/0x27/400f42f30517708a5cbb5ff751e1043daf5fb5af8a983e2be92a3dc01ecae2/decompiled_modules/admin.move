module 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminStorage has store, key {
        id: 0x2::object::UID,
        setters: vector<address>,
    }

    public entry fun add_setter(arg0: &mut AdminCap, arg1: &mut AdminStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&arg1.setters, &arg2), 301);
        0x1::vector::push_back<address>(&mut arg1.setters, arg2);
    }

    fun check_is_setter(arg0: &AdminStorage, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.setters, &v0), 302);
    }

    public entry fun create_presale<T0>(arg0: &AdminStorage, arg1: &0x2::clock::Clock, arg2: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg10);
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::add_dynamic_object_field<0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_presale::Round>(arg2, arg3, 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_presale::new_round<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public entry fun create_project(arg0: &AdminStorage, arg1: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::ProjectStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg11);
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::create_project(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun create_vesting(arg0: &AdminStorage, arg1: &0x2::clock::Clock, arg2: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg8);
        let (v0, v1, v2) = 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_vesting::new_vesting(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::add_dynamic_object_field<0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_vesting::Vesting>(arg2, v1, v0);
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_presale::set_vesting(arg2, arg3, v2);
    }

    public entry fun harvest<T0>(arg0: &AdminStorage, arg1: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg3);
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_presale::withdraw_balance<T0>(arg1, arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, v0);
        let v3 = AdminStorage{
            id      : 0x2::object::new(arg0),
            setters : v2,
        };
        0x2::transfer::share_object<AdminStorage>(v3);
    }

    public entry fun remove_setter(arg0: &mut AdminCap, arg1: &mut AdminStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.setters, &arg2);
        assert!(v0, 302);
        0x1::vector::remove<address>(&mut arg1.setters, v1);
    }

    public entry fun set_payment_presale<T0>(arg0: &AdminStorage, arg1: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg2: 0x1::string::String, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_presale::set_payment<T0>(0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::borrow_mut_dynamic_object_field<0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_presale::Round>(arg1, arg2), arg3, arg4, arg5);
    }

    public entry fun set_total_supply(arg0: &AdminStorage, arg1: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_presale::set_total_supply(0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::borrow_mut_dynamic_object_field<0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_presale::Round>(arg1, arg2), arg3);
    }

    // decompiled from Move bytecode v6
}

