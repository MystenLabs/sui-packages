module 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminStorage has store, key {
        id: 0x2::object::UID,
        setters: vector<address>,
    }

    public entry fun add(arg0: &mut AdminStorage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg0.setters, arg1);
    }

    public entry fun add_affiliator_list(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<address>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg6);
        assert!(0x1::vector::length<address>(&arg4) > 0, 101);
        assert!(0x1::vector::length<address>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 102);
        let v0 = 0x2::vec_map::empty<address, 0x1::string::String>();
        while (!0x1::vector::is_empty<address>(&arg4)) {
            0x2::vec_map::insert<address, 0x1::string::String>(&mut v0, 0x1::vector::pop_back<address>(&mut arg4), 0x1::vector::pop_back<0x1::string::String>(&mut arg5));
        };
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_affiliate::add_affiliator_list(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), v0);
    }

    public entry fun add_payment<T0>(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg7);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::add_payment<T0>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), arg4, arg5, arg6);
    }

    public entry fun add_rule_purchase(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg6);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy_purchase::add(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_policy(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4, arg5);
    }

    public entry fun add_rule_staking_tier<T0>(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy_staking_tier::add(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_policy(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4, 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_full_type<T0>());
    }

    public entry fun add_rule_whitelist(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy_whitelist::add(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_policy(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun add_rule_yousui_nft(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy_yousui_nft::add(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_policy(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)));
    }

    public entry fun add_service_affiliate(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_affiliate::add(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun add_service_preregister(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_preregister::add(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun add_service_refund(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg6);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_refund::add(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4, arg5, arg6);
    }

    public entry fun add_service_vesting(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg9);
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_vesting::add(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(v0), 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_project(v0), arg4, arg5, arg6, arg7, arg8, 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_token_type(v0), arg9);
    }

    public entry fun airdrop_vesting(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: vector<address>, arg6: vector<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg7);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::airdrop_vesting(arg4, 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), arg5, arg6, arg7);
    }

    fun check_is_setter(arg0: &AdminStorage, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.setters, &v0), 100);
    }

    public entry fun clear_whitelist(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy_whitelist::clear_whitelist(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_policy(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)));
    }

    public entry fun create_project(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg11);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::add_project(arg1, arg2, 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::create_project(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public entry fun deposit_round<T0>(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::vault::deposit<T0>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_vault(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4, arg5);
    }

    public entry fun fix(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::set_push_total_sold(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), arg4);
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

    public entry fun insert_core_vault(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::insert_core_vault(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3));
    }

    public entry fun migrate_vesting_schedule(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::migrate_vesting_schedule(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3));
    }

    public entry fun new_round<T0>(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg9);
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::add_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(v0, arg3, 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::new_round<T0>(arg3, 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::get_project_info(v0), arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun remove_affiliator_list(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<address>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg6);
        assert!(0x1::vector::length<address>(&arg4) > 0, 101);
        assert!(0x1::vector::length<address>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 102);
        let v0 = 0x2::vec_map::empty<address, 0x1::string::String>();
        while (!0x1::vector::is_empty<address>(&arg4)) {
            0x2::vec_map::insert<address, 0x1::string::String>(&mut v0, 0x1::vector::pop_back<address>(&mut arg4), 0x1::vector::pop_back<0x1::string::String>(&mut arg5));
        };
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_affiliate::remove_affiliator_list(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), v0);
    }

    public entry fun remove_core_vault(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::remove_core_vault(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3));
    }

    public entry fun remove_payment<T0>(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::remove_payment<T0>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3));
    }

    public entry fun remove_rule<T0, T1: drop + store>(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::remove_rule<T0, T1>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_policy(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)));
    }

    public entry fun remove_service_affiliate(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_affiliate::remove(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)));
    }

    public entry fun remove_service_preregister(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_preregister::remove(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)));
    }

    public entry fun remove_service_refund(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_refund::remove(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)));
    }

    public entry fun remove_service_vesting(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_vesting::remove(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)));
    }

    public entry fun remove_whitelist(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy_whitelist::remove_whitelist(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_policy(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun set_arr_purchase_type(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        let v0 = 0x2::vec_set::empty<u8>();
        while (!0x1::vector::is_empty<u8>(&arg4)) {
            0x2::vec_set::insert<u8>(&mut v0, 0x1::vector::pop_back<u8>(&mut arg4));
        };
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::set_arr_purchase_type(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), v0);
    }

    public entry fun set_end_at(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::set_end_at(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_is_open_claim_refund(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_preregister::set_is_open_claim_refund(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun set_is_open_claim_vesting(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_vesting::set_is_open_claim_vesting(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun set_is_vesting_info(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg9);
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_vesting::set_is_vesting_info(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(v0), arg4, arg5, arg6, arg7, arg8, 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_token_type(v0));
    }

    public entry fun set_launchpad_image(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg3);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::set_image(arg1, arg2);
    }

    public entry fun set_pause(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::set_pause(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_payment_rate<T0>(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::set_payment_rate<T0>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_push_total_sold(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::set_push_total_sold(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_refund_range_time(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_refund::set_refund_range_time(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun set_start_at(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::set_start_at(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_start_refund_time(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_refund::set_start_refund_time(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun set_total_sold(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::set_total_sold(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_total_supply(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::set_total_supply(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun set_whitelist<T0>(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy_whitelist::set_whitelist(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_policy(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun set_whitelist_plus(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy_whitelist::set_whitelist(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_policy(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4);
    }

    public entry fun set_withdraw_true(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u64>, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg6);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_vesting::update_withdraw_from_index_by_admin(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_service(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4, arg5);
    }

    public entry fun sub(arg0: &mut AdminStorage, arg1: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg1);
        if (0x1::vector::length<address>(&arg0.setters) > 1) {
            0x1::vector::pop_back<address>(&mut arg0.setters);
        };
    }

    public entry fun withdraw_round<T0>(arg0: &AdminStorage, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg5);
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::vault::withdraw<T0>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::get_mut_vault(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::ido::Round>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::launchpad::borrow_mut_dynamic_object_field<0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::Project>(arg1, arg2), arg3)), arg4, 0x2::tx_context::sender(arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

