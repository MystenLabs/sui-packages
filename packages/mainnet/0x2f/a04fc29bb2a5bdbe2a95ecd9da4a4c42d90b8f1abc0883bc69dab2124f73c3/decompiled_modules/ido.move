module 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::ido {
    struct Round has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        project: 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::ProjectInfo,
        token_type: 0x1::string::String,
        token_decimal: u8,
        start_at: u64,
        end_at: u64,
        total_sold: u64,
        total_supply: u64,
        payments: 0x2::vec_map::VecMap<0x1::string::String, Payment>,
        participants: 0x2::vec_set::VecSet<address>,
        is_pause: bool,
        purchase_type: 0x2::vec_set::VecSet<u8>,
        core: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
        other: 0x2::object_bag::ObjectBag,
    }

    struct Payment has copy, drop, store {
        ratio_per_token: u64,
        ratio_decimal: u8,
        method_type: 0x1::string::String,
        payment_decimal: u8,
    }

    struct Invest has store {
        investments: vector<Receipt>,
        total_accumulate_token: u64,
        final_accumulate_token: 0x1::option::Option<u64>,
    }

    struct Receipt has store {
        payment: Payment,
        payment_amount: u64,
        token_amount: u64,
    }

    struct IDO has drop {
        dummy_field: bool,
    }

    struct NewRound has copy, drop {
        round_id: 0x2::object::ID,
        round_name: 0x1::string::String,
        project_name: 0x1::string::String,
        token_type: 0x1::string::String,
        token_decimal: u8,
        total_supply: u64,
        sender: address,
    }

    struct Purchase has copy, drop {
        round_id: 0x2::object::ID,
        token_amount: u64,
        payment_amount: u64,
        payment_method_type: 0x1::string::String,
        sender: address,
    }

    struct PurchaseEvent has copy, drop {
        project_name: 0x1::string::String,
        round_name: 0x1::string::String,
        token_amount: u64,
        payment_amount: u64,
        payment_method_type: 0x1::string::String,
        sender: address,
    }

    struct AdminVesting has copy, drop {
        round_id: 0x2::object::ID,
        arr_user_address: vector<address>,
        arr_token_amount: vector<u64>,
        sender: address,
    }

    struct ClaimVesting has copy, drop {
        round_id: 0x2::object::ID,
        period_id_list: vector<u64>,
        total_claim: u64,
        sender: address,
    }

    struct ClaimVestingEvent has copy, drop {
        project_name: 0x1::string::String,
        round_name: 0x1::string::String,
        period_id_list: vector<u64>,
        total_claim: u64,
        sender: address,
    }

    struct ClaimRefundEvent has copy, drop {
        project_name: 0x1::string::String,
        round_name: 0x1::string::String,
        total_refund: u64,
        refund_token_type: 0x1::string::String,
        sender: address,
    }

    fun display<T0: key>(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project.link_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project.image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project.website}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"YouSUI Creator"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg3);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun add_payment<T0>(arg0: &mut Round, arg1: u64, arg2: u8, arg3: u8) {
        assert!(arg3 <= 18, 304);
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T0>();
        if (0x2::vec_map::contains<0x1::string::String, Payment>(&arg0.payments, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, Payment>(&mut arg0.payments, &v0);
        };
        let v3 = Payment{
            ratio_per_token : arg1,
            ratio_decimal   : arg2,
            method_type     : 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T0>(),
            payment_decimal : arg3,
        };
        0x2::vec_map::insert<0x1::string::String, Payment>(&mut arg0.payments, v0, v3);
    }

    public(friend) fun airdrop_vesting(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 316);
        assert!(!arg1.is_pause, 306);
        let v0 = 0;
        assert!(0x2::vec_set::contains<u8>(&arg1.purchase_type, &v0), 314);
        let v1 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        let v2 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::get_id(v1);
        let v3 = AdminVesting{
            round_id         : 0x2::object::uid_to_inner(&arg1.id),
            arr_user_address : arg2,
            arr_token_amount : arg3,
            sender           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<AdminVesting>(v3);
        while (!0x1::vector::is_empty<address>(&arg2) && !0x1::vector::is_empty<u64>(&arg3)) {
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::execute_add_vesting(v1, 0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<address>(&mut arg2));
        };
        while (!0x1::vector::is_empty<address>(&arg2)) {
            handle_cert_with_user(arg1, 0x2::clock::timestamp_ms(arg0), v2, 0x1::vector::pop_back<address>(&mut arg2), arg4);
        };
    }

    fun buy_validate(arg0: &Round, arg1: u64) {
        assert!(arg1 >= arg0.start_at, 305);
        assert!(arg0.end_at >= arg1, 309);
        assert!(!arg0.is_pause, 306);
    }

    fun cal_payment_amount(arg0: &0x2::vec_map::VecMap<0x1::string::String, Payment>, arg1: 0x1::string::String, arg2: u64, arg3: u8) : u64 {
        let v0 = 0x2::vec_map::get<0x1::string::String, Payment>(arg0, &arg1);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::mul_u64_div_decimal(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::mul_u64_div_decimal(v0.ratio_per_token, arg2, v0.ratio_decimal), (0x2::math::pow(10, v0.payment_decimal) as u64), arg3)
    }

    public fun claim_refund<T0>(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T0>();
        assert!(0x2::vec_map::contains<0x1::string::String, Payment>(&arg1.payments, &v1), 310);
        assert!(0x2::dynamic_field::exists_<address>(&arg1.id, v0), 311);
        assert!(0x2::clock::timestamp_ms(arg0) > arg1.end_at, 312);
        let v2 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_refund::check_valid_refund(v2, arg0);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_refund::insert_refund_address(v2, v0);
        let v3 = 0x2::dynamic_field::borrow_mut<address, Invest>(&mut arg1.id, v0);
        assert!(0x1::option::is_none<u64>(&v3.final_accumulate_token), 315);
        let v4 = cal_payment_amount(&arg1.payments, v1, v3.total_accumulate_token, arg1.token_decimal);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::execute_sub_vesting(v2, v3.total_accumulate_token, v0);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::withdraw<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::Vaults>(&mut arg1.other, 0x1::string::utf8(b"VAULT")), v4, v0, arg2);
        0x1::option::fill<u64>(&mut v3.final_accumulate_token, 0);
        let v5 = ClaimRefundEvent{
            project_name      : 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::get_project_name(&arg1.project),
            round_name        : arg1.name,
            total_refund      : v4,
            refund_token_type : v1,
            sender            : v0,
        };
        0x2::event::emit<ClaimRefundEvent>(v5);
    }

    public fun claim_refund_preregister<T0>(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T0>();
        assert!(0x2::vec_map::contains<0x1::string::String, Payment>(&arg1.payments, &v1), 310);
        assert!(0x2::dynamic_field::exists_<address>(&arg1.id, v0), 311);
        assert!(0x2::clock::timestamp_ms(arg0) > arg1.end_at, 312);
        let v2 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_preregister::validate_claim_refund(v2);
        let v3 = 0x2::dynamic_field::borrow_mut<address, Invest>(&mut arg1.id, v0);
        assert!(0x1::option::is_none<u64>(&v3.final_accumulate_token), 315);
        if (arg1.total_sold > arg1.total_supply) {
            let v4 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::mul_u64_div_u64(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::mul_u64_div_u64(v3.total_accumulate_token, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::max_percent(), arg1.total_sold), arg1.total_supply, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::max_percent());
            let v5 = v3.total_accumulate_token - v4;
            0x1::option::fill<u64>(&mut v3.final_accumulate_token, v4);
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::execute_sub_vesting(v2, v5, v0);
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::withdraw<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::Vaults>(&mut arg1.other, 0x1::string::utf8(b"VAULT")), cal_payment_amount(&arg1.payments, v1, v5, arg1.token_decimal), v0, arg2);
        } else {
            0x1::option::fill<u64>(&mut v3.final_accumulate_token, v3.total_accumulate_token);
        };
    }

    public fun claim_vesting<T0>(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        let v2 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::update_withdraw(arg0, v1, arg2, v0);
        let v3 = 0;
        if (!0x2::vec_set::contains<u8>(&arg1.purchase_type, &v3)) {
            let v4 = 0x2::dynamic_field::borrow<address, Invest>(&arg1.id, v0);
            if (0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_preregister::is_use_preregister(v1)) {
                assert!(!0x1::option::is_none<u64>(&v4.final_accumulate_token), 313);
            };
        };
        assert!(v2 > 0, 300);
        assert!(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::check_is_open_claim_vesting(v1), 301);
        assert!(0x2::clock::timestamp_ms(arg0) > arg1.end_at, 312);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_refund::insert_refund_address(v1, v0);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::withdraw<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::Vaults>(&mut arg1.other, 0x1::string::utf8(b"VAULT")), v2, v0, arg3);
        let v5 = ClaimVestingEvent{
            project_name   : 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::get_project_name(&arg1.project),
            round_name     : arg1.name,
            period_id_list : arg2,
            total_claim    : v2,
            sender         : v0,
        };
        0x2::event::emit<ClaimVestingEvent>(v5);
    }

    public(friend) fun get_mut_policy(arg0: &mut Round) : &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy {
        0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy>(&mut arg0.other, 0x1::string::utf8(b"POLICY"))
    }

    public(friend) fun get_mut_service(arg0: &mut Round) : &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service {
        0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg0.other, 0x1::string::utf8(b"SERVICE"))
    }

    public(friend) fun get_mut_vault(arg0: &mut Round) : &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::Vaults {
        0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::Vaults>(&mut arg0.other, 0x1::string::utf8(b"VAULT"))
    }

    public fun get_project(arg0: &Round) : 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::ProjectInfo {
        arg0.project
    }

    public fun get_token_type(arg0: &Round) : 0x1::string::String {
        arg0.token_type
    }

    fun handle_cert(arg0: &mut Round, arg1: u64, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (!0x2::vec_set::contains<address>(&arg0.participants, &v0)) {
            0x2::vec_set::insert<address>(&mut arg0.participants, v0);
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::certificate::issue_investment_certificate(arg1, arg0.project, arg0.name, arg0.token_type, arg2, arg3);
        };
    }

    fun handle_cert_with_user(arg0: &mut Round, arg1: u64, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::vec_set::contains<address>(&arg0.participants, &arg3)) {
            0x2::vec_set::insert<address>(&mut arg0.participants, arg3);
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::certificate::issue_investment_certificate_with_user(arg1, arg0.project, arg0.name, arg0.token_type, arg2, arg3, arg4);
        };
    }

    fun init(arg0: IDO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<IDO>(arg0, arg1);
        display<Round>(&v0, 0x1::string::utf8(b"YouSUI x {project.name} <> {name}"), 0x1::string::utf8(b"{project.description}"), arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun migrate_vesting_schedule(arg0: &mut Round) {
        let v0 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg0.other, 0x1::string::utf8(b"SERVICE"));
        let v1 = 0x2::vec_set::into_keys<address>(arg0.participants);
        while (!0x1::vector::is_empty<address>(&v1)) {
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::execute_migrate_vesting(v0, 0x1::vector::pop_back<address>(&mut v1));
        };
    }

    fun new_policy(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>, arg1: &mut 0x2::object_bag::ObjectBag, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"POLICY");
        let (v1, v2) = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::new(arg2);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(arg0, v0, v2);
        0x2::object_bag::add<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy>(arg1, v0, v1);
    }

    public(friend) fun new_round<T0>(arg0: 0x1::string::String, arg1: 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::ProjectInfo, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : Round {
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T0>();
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>();
        let v3 = 0x2::object_bag::new(arg7);
        let v4 = &mut v2;
        let v5 = &mut v3;
        new_policy(v4, v5, arg7);
        let v6 = &mut v2;
        let v7 = &mut v3;
        new_service(v6, v7, arg7);
        let v8 = &mut v2;
        let v9 = &mut v3;
        new_vault(v8, v9, arg7);
        let v10 = NewRound{
            round_id      : 0x2::object::uid_to_inner(&v0),
            round_name    : arg0,
            project_name  : 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::get_project_name(&arg1),
            token_type    : v1,
            token_decimal : arg2,
            total_supply  : arg5,
            sender        : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<NewRound>(v10);
        let v11 = 0x2::vec_set::empty<u8>();
        while (!0x1::vector::is_empty<u8>(&arg6)) {
            0x2::vec_set::insert<u8>(&mut v11, 0x1::vector::pop_back<u8>(&mut arg6));
        };
        Round{
            id            : v0,
            name          : arg0,
            project       : arg1,
            token_type    : v1,
            token_decimal : arg2,
            start_at      : arg3,
            end_at        : arg4,
            total_sold    : 0,
            total_supply  : arg5,
            payments      : 0x2::vec_map::empty<0x1::string::String, Payment>(),
            participants  : 0x2::vec_set::empty<address>(),
            is_pause      : false,
            purchase_type : v11,
            core          : v2,
            other         : v3,
        }
    }

    fun new_service(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>, arg1: &mut 0x2::object_bag::ObjectBag, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"SERVICE");
        let (v1, v2) = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::new(arg2);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(arg0, v0, v2);
        0x2::object_bag::add<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(arg1, v0, v1);
    }

    fun new_vault(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>, arg1: &mut 0x2::object_bag::ObjectBag, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"VAULT");
        let (v1, v2) = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::new(arg2);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(arg0, v0, v2);
        0x2::object_bag::add<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::Vaults>(arg1, v0, v1);
    }

    public fun purchase_nor<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: u64, arg3: vector<0x2::coin::Coin<T1>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T1>();
        let v3 = cal_payment_amount(&arg1.payments, v2, arg2, arg1.token_decimal);
        buy_validate(arg1, v0);
        let v4 = 1;
        assert!(0x2::vec_set::contains<u8>(&arg1.purchase_type, &v4), 314);
        let v5 = Receipt{
            payment        : *0x2::vec_map::get<0x1::string::String, Payment>(&arg1.payments, &v2),
            payment_amount : v3,
            token_amount   : arg2,
        };
        if (!0x2::dynamic_field::exists_<address>(&arg1.id, v1)) {
            let v6 = 0x1::vector::empty<Receipt>();
            0x1::vector::push_back<Receipt>(&mut v6, v5);
            let v7 = Invest{
                investments            : v6,
                total_accumulate_token : arg2,
                final_accumulate_token : 0x1::option::none<u64>(),
            };
            0x2::dynamic_field::add<address, Invest>(&mut arg1.id, v1, v7);
        } else {
            let v8 = 0x2::dynamic_field::borrow_mut<address, Invest>(&mut arg1.id, v1);
            v8.total_accumulate_token = v8.total_accumulate_token + arg2;
            0x1::vector::push_back<Receipt>(&mut v8.investments, v5);
        };
        let v9 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy>(&mut arg1.other, 0x1::string::utf8(b"POLICY"));
        let v10 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::new_request(0x2::object::uid_to_inner(&arg1.id));
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_purchase::check(v9, &mut v10, arg2);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_whitelist::check(v9, &mut v10, arg4);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_yousui_nft::pass(v9, &mut v10);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_staking_tier::pass(v9, &mut v10);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::confirm_request(v9, v10);
        update_state_purchase<T1>(arg1, arg2, v3, arg3, arg4);
        let v11 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        let v12 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::get_id(v11);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_preregister::validate_purchase(v11, arg1.total_sold, arg1.total_supply);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::execute_add_vesting(v11, arg2, v1);
        let v13 = PurchaseEvent{
            project_name        : 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::get_project_name(&arg1.project),
            round_name          : arg1.name,
            token_amount        : arg2,
            payment_amount      : v3,
            payment_method_type : v2,
            sender              : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PurchaseEvent>(v13);
        handle_cert(arg1, v0, v12, arg4);
    }

    public fun purchase_nor_staking<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: u64, arg3: vector<0x2::coin::Coin<T1>>, arg4: &0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T1>();
        let v3 = cal_payment_amount(&arg1.payments, v2, arg2, arg1.token_decimal);
        buy_validate(arg1, v0);
        let v4 = 5;
        assert!(0x2::vec_set::contains<u8>(&arg1.purchase_type, &v4), 314);
        let v5 = Receipt{
            payment        : *0x2::vec_map::get<0x1::string::String, Payment>(&arg1.payments, &v2),
            payment_amount : v3,
            token_amount   : arg2,
        };
        if (!0x2::dynamic_field::exists_<address>(&arg1.id, v1)) {
            let v6 = 0x1::vector::empty<Receipt>();
            0x1::vector::push_back<Receipt>(&mut v6, v5);
            let v7 = Invest{
                investments            : v6,
                total_accumulate_token : arg2,
                final_accumulate_token : 0x1::option::none<u64>(),
            };
            0x2::dynamic_field::add<address, Invest>(&mut arg1.id, v1, v7);
        } else {
            let v8 = 0x2::dynamic_field::borrow_mut<address, Invest>(&mut arg1.id, v1);
            v8.total_accumulate_token = v8.total_accumulate_token + arg2;
            0x1::vector::push_back<Receipt>(&mut v8.investments, v5);
        };
        let v9 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy>(&mut arg1.other, 0x1::string::utf8(b"POLICY"));
        let v10 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::new_request(0x2::object::uid_to_inner(&arg1.id));
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_purchase::check(v9, &mut v10, arg2);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_whitelist::pass(v9, &mut v10);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_yousui_nft::pass(v9, &mut v10);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_staking_tier::check(v9, &mut v10, arg4, v1);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::confirm_request(v9, v10);
        update_state_purchase<T1>(arg1, arg2, v3, arg3, arg5);
        let v11 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        let v12 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::get_id(v11);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_preregister::validate_purchase(v11, arg1.total_sold, arg1.total_supply);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::execute_add_vesting(v11, arg2, v1);
        let v13 = PurchaseEvent{
            project_name        : 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::get_project_name(&arg1.project),
            round_name          : arg1.name,
            token_amount        : arg2,
            payment_amount      : v3,
            payment_method_type : v2,
            sender              : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PurchaseEvent>(v13);
        handle_cert(arg1, v0, v12, arg5);
    }

    public fun purchase_ref<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: u64, arg3: vector<0x2::coin::Coin<T1>>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T1>();
        let v3 = cal_payment_amount(&arg1.payments, v2, arg2, arg1.token_decimal);
        buy_validate(arg1, v0);
        let v4 = 2;
        assert!(0x2::vec_set::contains<u8>(&arg1.purchase_type, &v4), 314);
        let v5 = Receipt{
            payment        : *0x2::vec_map::get<0x1::string::String, Payment>(&arg1.payments, &v2),
            payment_amount : v3,
            token_amount   : arg2,
        };
        if (!0x2::dynamic_field::exists_<address>(&arg1.id, v1)) {
            let v6 = 0x1::vector::empty<Receipt>();
            0x1::vector::push_back<Receipt>(&mut v6, v5);
            let v7 = Invest{
                investments            : v6,
                total_accumulate_token : arg2,
                final_accumulate_token : 0x1::option::none<u64>(),
            };
            0x2::dynamic_field::add<address, Invest>(&mut arg1.id, v1, v7);
        } else {
            let v8 = 0x2::dynamic_field::borrow_mut<address, Invest>(&mut arg1.id, v1);
            v8.total_accumulate_token = v8.total_accumulate_token + arg2;
            0x1::vector::push_back<Receipt>(&mut v8.investments, v5);
        };
        let v9 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy>(&mut arg1.other, 0x1::string::utf8(b"POLICY"));
        let v10 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::new_request(0x2::object::uid_to_inner(&arg1.id));
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_purchase::check(v9, &mut v10, arg2);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::confirm_request(v9, v10);
        update_state_purchase<T1>(arg1, arg2, v3, arg3, arg5);
        let v11 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        let v12 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::get_id(v11);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_affiliate::add_profit_by_affiliate<T1>(v11, arg4, v3);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_preregister::validate_purchase(v11, arg1.total_sold, arg1.total_supply);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::execute_add_vesting(v11, arg2, v1);
        let v13 = PurchaseEvent{
            project_name        : 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::get_project_name(&arg1.project),
            round_name          : arg1.name,
            token_amount        : arg2,
            payment_amount      : v3,
            payment_method_type : v2,
            sender              : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PurchaseEvent>(v13);
        handle_cert(arg1, v0, v12, arg5);
    }

    public fun purchase_yousui_og_holder<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: u64, arg3: vector<0x2::coin::Coin<T1>>, arg4: &0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::YOUSUINFT, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T1>();
        let v3 = cal_payment_amount(&arg1.payments, v2, arg2, arg1.token_decimal);
        buy_validate(arg1, v0);
        let v4 = 3;
        assert!(0x2::vec_set::contains<u8>(&arg1.purchase_type, &v4), 314);
        let v5 = Receipt{
            payment        : *0x2::vec_map::get<0x1::string::String, Payment>(&arg1.payments, &v2),
            payment_amount : v3,
            token_amount   : arg2,
        };
        if (!0x2::dynamic_field::exists_<address>(&arg1.id, v1)) {
            let v6 = 0x1::vector::empty<Receipt>();
            0x1::vector::push_back<Receipt>(&mut v6, v5);
            let v7 = Invest{
                investments            : v6,
                total_accumulate_token : arg2,
                final_accumulate_token : 0x1::option::none<u64>(),
            };
            0x2::dynamic_field::add<address, Invest>(&mut arg1.id, v1, v7);
        } else {
            let v8 = 0x2::dynamic_field::borrow_mut<address, Invest>(&mut arg1.id, v1);
            v8.total_accumulate_token = v8.total_accumulate_token + arg2;
            0x1::vector::push_back<Receipt>(&mut v8.investments, v5);
        };
        let v9 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy>(&mut arg1.other, 0x1::string::utf8(b"POLICY"));
        let v10 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::new_request(0x2::object::uid_to_inner(&arg1.id));
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_purchase::check(v9, &mut v10, arg2);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_whitelist::check(v9, &mut v10, arg5);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_yousui_nft::check(v9, &mut v10, arg4);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_staking_tier::pass(v9, &mut v10);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::confirm_request(v9, v10);
        update_state_purchase<T1>(arg1, arg2, v3, arg3, arg5);
        let v11 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        let v12 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::get_id(v11);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_preregister::validate_purchase(v11, arg1.total_sold, arg1.total_supply);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::execute_add_vesting(v11, arg2, v1);
        let v13 = PurchaseEvent{
            project_name        : 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::get_project_name(&arg1.project),
            round_name          : arg1.name,
            token_amount        : arg2,
            payment_amount      : v3,
            payment_method_type : v2,
            sender              : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PurchaseEvent>(v13);
        handle_cert(arg1, v0, v12, arg5);
    }

    public fun purchase_yousui_tier45_holder<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: u64, arg3: vector<0x2::coin::Coin<T1>>, arg4: &0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::YOUSUINFT, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T1>();
        let v3 = cal_payment_amount(&arg1.payments, v2, arg2, arg1.token_decimal);
        buy_validate(arg1, v0);
        let v4 = 4;
        assert!(0x2::vec_set::contains<u8>(&arg1.purchase_type, &v4), 314);
        let v5 = Receipt{
            payment        : *0x2::vec_map::get<0x1::string::String, Payment>(&arg1.payments, &v2),
            payment_amount : v3,
            token_amount   : arg2,
        };
        if (!0x2::dynamic_field::exists_<address>(&arg1.id, v1)) {
            let v6 = 0x1::vector::empty<Receipt>();
            0x1::vector::push_back<Receipt>(&mut v6, v5);
            let v7 = Invest{
                investments            : v6,
                total_accumulate_token : arg2,
                final_accumulate_token : 0x1::option::none<u64>(),
            };
            0x2::dynamic_field::add<address, Invest>(&mut arg1.id, v1, v7);
        } else {
            let v8 = 0x2::dynamic_field::borrow_mut<address, Invest>(&mut arg1.id, v1);
            v8.total_accumulate_token = v8.total_accumulate_token + arg2;
            0x1::vector::push_back<Receipt>(&mut v8.investments, v5);
        };
        let v9 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy>(&mut arg1.other, 0x1::string::utf8(b"POLICY"));
        let v10 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::new_request(0x2::object::uid_to_inner(&arg1.id));
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_purchase::check(v9, &mut v10, arg2);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_whitelist::pass(v9, &mut v10);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_yousui_nft::check_tier(v9, &mut v10, arg4);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_staking_tier::pass(v9, &mut v10);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::confirm_request(v9, v10);
        update_state_purchase<T1>(arg1, arg2, v3, arg3, arg5);
        let v11 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        let v12 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::get_id(v11);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_preregister::validate_purchase(v11, arg1.total_sold, arg1.total_supply);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting::execute_add_vesting(v11, arg2, v1);
        let v13 = PurchaseEvent{
            project_name        : 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::get_project_name(&arg1.project),
            round_name          : arg1.name,
            token_amount        : arg2,
            payment_amount      : v3,
            payment_method_type : v2,
            sender              : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PurchaseEvent>(v13);
        handle_cert(arg1, v0, v12, arg5);
    }

    public(friend) fun remove_payment<T0>(arg0: &mut Round) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T0>();
        if (0x2::vec_map::contains<0x1::string::String, Payment>(&arg0.payments, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, Payment>(&mut arg0.payments, &v0);
        };
    }

    public(friend) fun set_arr_purchase_type(arg0: &mut Round, arg1: 0x2::vec_set::VecSet<u8>) {
        arg0.purchase_type = arg1;
    }

    public(friend) fun set_end_at(arg0: &mut Round, arg1: u64) {
        assert!(arg0.start_at < arg1, 302);
        arg0.end_at = arg1;
    }

    public(friend) fun set_pause(arg0: &mut Round, arg1: bool) {
        arg0.is_pause = arg1;
    }

    public(friend) fun set_payment_rate<T0>(arg0: &mut Round, arg1: u64) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_full_type<T0>();
        0x2::vec_map::get_mut<0x1::string::String, Payment>(&mut arg0.payments, &v0).ratio_per_token = arg1;
    }

    public(friend) fun set_push_total_sold(arg0: &mut Round, arg1: u64) {
        arg0.total_sold = arg0.total_sold + arg1;
    }

    public(friend) fun set_start_at(arg0: &mut Round, arg1: u64) {
        assert!(arg0.end_at > arg1, 303);
        arg0.start_at = arg1;
    }

    public(friend) fun set_total_sold(arg0: &mut Round, arg1: u64) {
        arg0.total_sold = arg1;
    }

    public(friend) fun set_total_supply(arg0: &mut Round, arg1: u64) {
        assert!(arg1 >= arg0.total_sold, 307);
        arg0.total_supply = arg1;
    }

    fun update_state_purchase<T0>(arg0: &mut Round, arg1: u64, arg2: u64, arg3: vector<0x2::coin::Coin<T0>>, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.total_sold = arg0.total_sold + arg1;
        let (v0, v1) = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::merge_and_split<T0>(arg3, arg2, arg4);
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::deposit<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::vault::Vaults>(&mut arg0.other, 0x1::string::utf8(b"VAULT")), v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

