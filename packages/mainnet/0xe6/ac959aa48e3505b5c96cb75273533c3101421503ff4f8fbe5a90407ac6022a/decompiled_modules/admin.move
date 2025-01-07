module 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminStorage has store, key {
        id: 0x2::object::UID,
        setters: vector<address>,
    }

    public entry fun add_affiliator_list(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<address>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg6);
        assert!(0x1::vector::length<address>(&arg4) > 0, 101);
        assert!(0x1::vector::length<address>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 102);
        let v0 = 0x2::vec_map::empty<address, 0x1::string::String>();
        while (!0x1::vector::is_empty<address>(&arg4)) {
            0x2::vec_map::insert<address, 0x1::string::String>(&mut v0, 0x1::vector::pop_back<address>(&mut arg4), 0x1::vector::pop_back<0x1::string::String>(&mut arg5));
        };
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_affiliate::add_affiliator_list(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_service(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3)), v0);
    }

    public entry fun add_payment<T0>(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg7);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::add_payment<T0>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3), arg4, arg5, arg6);
    }

    public entry fun add_rule_purchase(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg6);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::policy_purchase::add(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_policy(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3)), arg4, arg5);
    }

    public entry fun add_service_affiliate(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_affiliate::add(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_service(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun add_service_vesting(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg9);
        let v0 = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_vesting::add(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_service(v0), 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_project(v0), arg4, arg5, arg6, arg7, arg8, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_token_type(v0), arg9);
    }

    fun check_is_setter(arg0: &AdminStorage, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.setters, &v0), 100);
    }

    public entry fun create_project(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg11);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::add_project(arg1, arg2, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::create_project(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public entry fun deposit_round<T0>(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::vault::deposit<T0>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_vault(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3)), arg4, arg5);
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

    public entry fun new_round<T0>(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg8);
        let v0 = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::add_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(v0, arg3, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::new_round<T0>(arg3, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::get_project_info(v0), arg4, arg5, arg6, arg7, arg8));
    }

    public entry fun remove_affiliator_list(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<address>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg6);
        assert!(0x1::vector::length<address>(&arg4) > 0, 101);
        assert!(0x1::vector::length<address>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 102);
        let v0 = 0x2::vec_map::empty<address, 0x1::string::String>();
        while (!0x1::vector::is_empty<address>(&arg4)) {
            0x2::vec_map::insert<address, 0x1::string::String>(&mut v0, 0x1::vector::pop_back<address>(&mut arg4), 0x1::vector::pop_back<0x1::string::String>(&mut arg5));
        };
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_affiliate::remove_affiliator_list(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_service(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3)), v0);
    }

    public entry fun remove_payment<T0>(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::remove_payment<T0>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3));
    }

    public entry fun remove_rule<T0, T1: drop + store>(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::policy::remove_rule<T0, T1>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_policy(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3)));
    }

    public entry fun remove_service_affiliate(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_affiliate::remove(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_service(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3)));
    }

    public entry fun remove_service_vesting(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_vesting::remove(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_service(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3)));
    }

    public entry fun set_end_at(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::set_end_at(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_is_open_claim_vesting(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_vesting::set_is_open_claim_vesting(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_service(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun set_is_vesting_info(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg9);
        let v0 = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_vesting::set_is_vesting_info(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_service(v0), arg4, arg5, arg6, arg7, arg8, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_token_type(v0));
    }

    public entry fun set_pause(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::set_pause(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_payment_rate<T0>(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::set_payment_rate<T0>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_start_at(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::set_start_at(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_total_sold(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::set_total_sold(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_total_supply(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::set_total_supply(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun withdraw_round<T0>(arg0: &AdminStorage, arg1: &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::vault::withdraw<T0>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::get_mut_vault(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido::Round>(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::launchpad::borrow_mut_dynamic_object_field<0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::Project>(arg1, arg2), arg3)), arg4, 0x2::tx_context::sender(arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

