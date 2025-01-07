module 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_presale {
    struct Round has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        project: 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::ProjectInfo,
        vesting: 0x1::option::Option<0x2::object::ID>,
        token_type: 0x1::string::String,
        token_decimal: u8,
        start_at: u64,
        end_at: u64,
        max_per_user: u64,
        min_purchase: u64,
        total_sold: u64,
        total_supply: u64,
        is_pause: bool,
        use_whitelist: 0x1::option::Option<0x2::vec_set::VecSet<address>>,
        use_ref: 0x1::option::Option<bool>,
        use_tier: 0x1::option::Option<0x2::table::Table<u64, Tier_Setting>>,
        payments: 0x2::vec_map::VecMap<0x1::string::String, Payment>,
        participants: 0x2::vec_set::VecSet<address>,
        balance: 0x2::object_bag::ObjectBag,
    }

    struct Payment has copy, drop, store {
        ratio_per_token: u64,
        method_type: 0x1::string::String,
        payment_decimal: u8,
    }

    struct Tier_Setting has store {
        dummy_field: bool,
    }

    struct InvestmentCertificate has store, key {
        id: 0x2::object::UID,
        project: 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::ProjectInfo,
    }

    struct Invest has store {
        investments: vector<Receipt>,
        accumulate_token: u64,
        is_disbursement: bool,
    }

    struct Receipt has store {
        payment: Payment,
        payment_amount: u64,
        token_amount: u64,
    }

    struct LAUNCHPAD_PRESALE has drop {
        dummy_field: bool,
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

    fun borrow_mut_round(arg0: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg1: 0x1::string::String) : &mut Round {
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::borrow_mut_dynamic_object_field<Round>(arg0, arg1)
    }

    fun buy_validate_amount(arg0: &Round, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        let v0 = arg2 + arg3;
        assert!(0x2::vec_map::contains<0x1::string::String, Payment>(&arg0.payments, &arg1), 107);
        assert!(arg3 >= arg0.min_purchase, 108);
        assert!(v0 <= arg0.max_per_user, 109);
        assert!(v0 <= arg0.total_supply, 110);
    }

    fun buy_validate_time(arg0: &Round, arg1: u64) {
        assert!(arg1 >= arg0.start_at, 113);
        assert!(arg0.end_at >= arg1, 108);
        assert!(!arg0.is_pause, 114);
    }

    fun cal_payment_amount(arg0: &Round, arg1: 0x1::string::String, arg2: u64) : u64 {
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::utils::mul_u64_div_decimal(0x2::vec_map::get<0x1::string::String, Payment>(&arg0.payments, &arg1).ratio_per_token, arg2, arg0.token_decimal)
    }

    public entry fun claim_vesting<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg2: 0x1::string::String, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_vesting::update_withdraw(arg0, arg1, arg2, arg3, arg4);
        let v2 = borrow_mut_round(arg1, arg2);
        assert!(0x2::dynamic_field::exists_<address>(&v2.id, v0), 111);
        0x2::pay::split_and_transfer<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v2.balance, v2.token_type), v1, v0, arg4);
    }

    public entry fun deposit_balance<T0>(arg0: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::utils::get_full_type<T0>();
        let v1 = borrow_mut_round(arg0, arg1);
        if (0x2::object_bag::contains<0x1::string::String>(&v1.balance, v0)) {
            0x2::coin::join<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v1.balance, v0), arg2);
        } else {
            0x2::object_bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v1.balance, v0, arg2);
        };
    }

    fun init(arg0: LAUNCHPAD_PRESALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LAUNCHPAD_PRESALE>(arg0, arg1);
        display<Round>(&v0, 0x1::string::utf8(b"YouSUI x {project.name} <> {name}"), 0x1::string::utf8(b"{project.description}"), arg1);
        display<InvestmentCertificate>(&v0, 0x1::string::utf8(b"YouSUI x {project.name} <> Investment Certificate"), 0x1::string::utf8(b"The investment certificate, published by YouSUI, is a document providing proof of your token investment in a crypto project. It verifies your ownership, including the number of tokens purchased, and grants you certain rights and benefits within the project. The certificate ensures transparency and credibility, protecting your interests and allowing you to participate in project-related decisions. It serves as a valuable record of your investment, issued by YouSUI, in the crypto project."), arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun new_round<T0>(arg0: &0x2::clock::Clock, arg1: &0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : Round {
        assert!(arg3 <= 18, 101);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg0), 102);
        assert!(arg5 >= arg4, 103);
        assert!(arg7 >= 1 * 0x2::math::pow(10, arg3), 105);
        assert!(arg6 >= arg7, 106);
        assert!(arg8 >= arg6, 104);
        Round{
            id            : 0x2::object::new(arg9),
            name          : arg2,
            project       : 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::get_project_info(arg1),
            vesting       : 0x1::option::none<0x2::object::ID>(),
            token_type    : 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::utils::get_full_type<T0>(),
            token_decimal : arg3,
            start_at      : arg4,
            end_at        : arg5,
            max_per_user  : arg6,
            min_purchase  : arg7,
            total_sold    : 0,
            total_supply  : arg8,
            is_pause      : false,
            use_whitelist : 0x1::option::none<0x2::vec_set::VecSet<address>>(),
            use_ref       : 0x1::option::none<bool>(),
            use_tier      : 0x1::option::none<0x2::table::Table<u64, Tier_Setting>>(),
            payments      : 0x2::vec_map::empty<0x1::string::String, Payment>(),
            participants  : 0x2::vec_set::empty<address>(),
            balance       : 0x2::object_bag::new(arg9),
        }
    }

    public entry fun purchase<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg2: 0x1::string::String, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::utils::get_full_type<T1>();
        let v3 = borrow_mut_round(arg1, arg2);
        buy_validate_time(v3, v0);
        let v4 = cal_payment_amount(v3, v2, arg4);
        let v5 = Receipt{
            payment        : *0x2::vec_map::get<0x1::string::String, Payment>(&v3.payments, &v2),
            payment_amount : v4,
            token_amount   : arg4,
        };
        if (!0x2::dynamic_field::exists_<address>(&v3.id, v1)) {
            let v6 = 0x1::vector::empty<Receipt>();
            0x1::vector::push_back<Receipt>(&mut v6, v5);
            buy_validate_amount(v3, v2, 0, arg4);
            let v7 = Invest{
                investments      : v6,
                accumulate_token : arg4,
                is_disbursement  : false,
            };
            0x2::dynamic_field::add<address, Invest>(&mut v3.id, v1, v7);
        } else {
            buy_validate_amount(v3, v2, 0x2::dynamic_field::borrow<address, Invest>(&v3.id, v1).accumulate_token, arg4);
            let v8 = 0x2::dynamic_field::borrow_mut<address, Invest>(&mut v3.id, v1);
            v8.accumulate_token = v8.accumulate_token + arg4;
            0x1::vector::push_back<Receipt>(&mut v8.investments, v5);
        };
        let (v9, v10) = 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::utils::merge_and_split<T1>(arg3, v4, arg5);
        let v11 = v10;
        0x2::coin::put<T1>(0x2::coin::balance_mut<T1>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T1>>(&mut v3.balance, v2)), v9);
        v3.total_sold = v3.total_sold + arg4;
        if (!0x2::vec_set::contains<address>(&v3.participants, &v1)) {
            0x2::vec_set::insert<address>(&mut v3.participants, v1);
            let v12 = InvestmentCertificate{
                id      : 0x2::object::new(arg5),
                project : v3.project,
            };
            0x2::transfer::public_transfer<InvestmentCertificate>(v12, v1);
        };
        if (0x2::coin::value<T1>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, v1);
        } else {
            0x2::coin::destroy_zero<T1>(v11);
        };
        if (0x1::option::is_none<0x2::object::ID>(&v3.vesting)) {
            0x2::pay::split_and_transfer<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v3.balance, v3.token_type), arg4, v1, arg5);
        } else {
            0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_vesting::add_vesting(v0, arg1, arg2, arg4, arg5);
        };
    }

    public(friend) fun set_payment<T0>(arg0: &mut Round, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 18, 101);
        let v0 = 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::utils::get_full_type<T0>();
        if (0x2::vec_map::contains<0x1::string::String, Payment>(&arg0.payments, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, Payment>(&mut arg0.payments, &v0);
        } else {
            0x2::object_bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.balance, v0, 0x2::coin::zero<T0>(arg3));
        };
        let v3 = Payment{
            ratio_per_token : arg1,
            method_type     : 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::utils::get_full_type<T0>(),
            payment_decimal : arg2,
        };
        0x2::vec_map::insert<0x1::string::String, Payment>(&mut arg0.payments, v0, v3);
    }

    public(friend) fun set_ref(arg0: &mut Round, arg1: bool) {
        0x1::option::swap_or_fill<bool>(&mut arg0.use_ref, arg1);
    }

    public(friend) fun set_tier(arg0: &mut Round) {
    }

    public(friend) fun set_vesting(arg0: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        0x1::option::fill<0x2::object::ID>(&mut borrow_mut_round(arg0, arg1).vesting, arg2);
    }

    public(friend) fun set_whitelist(arg0: &mut Round, arg1: vector<address>) {
        let v0 = if (0x1::option::is_some<0x2::vec_set::VecSet<address>>(&arg0.use_whitelist)) {
            0x1::option::extract<0x2::vec_set::VecSet<address>>(&mut arg0.use_whitelist)
        } else {
            0x2::vec_set::empty<address>()
        };
        let v1 = v0;
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x2::vec_set::contains<address>(&v1, &v2)) {
                0x2::vec_set::insert<address>(&mut v1, v2);
            };
        };
        0x1::option::fill<0x2::vec_set::VecSet<address>>(&mut arg0.use_whitelist, v1);
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::coin::balance_mut<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut borrow_mut_round(arg0, arg1).balance, 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::utils::get_full_type<T0>()))), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

