module 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::ido {
    struct Round has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        project: 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::ProjectInfo,
        token_type: 0x1::string::String,
        token_decimal: u8,
        start_at: u64,
        end_at: u64,
        total_sold: u64,
        total_supply: u64,
        payments: 0x2::vec_map::VecMap<0x1::string::String, Payment>,
        participants: 0x2::vec_set::VecSet<address>,
        is_pause: bool,
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

    struct ClaimVesting has copy, drop {
        round_id: 0x2::object::ID,
        period_id_list: vector<u64>,
        total_claim: u64,
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
        let v0 = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::utils::get_full_type<T0>();
        if (0x2::vec_map::contains<0x1::string::String, Payment>(&arg0.payments, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, Payment>(&mut arg0.payments, &v0);
        };
        let v3 = Payment{
            ratio_per_token : arg1,
            ratio_decimal   : arg2,
            method_type     : 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::utils::get_full_type<T0>(),
            payment_decimal : arg3,
        };
        0x2::vec_map::insert<0x1::string::String, Payment>(&mut arg0.payments, v0, v3);
    }

    fun buy_validate(arg0: &Round, arg1: u64, arg2: u64) {
        assert!(arg2 >= arg0.start_at, 305);
        assert!(arg0.end_at >= arg2, 309);
        assert!(!arg0.is_pause, 306);
        assert!(arg0.total_sold + arg1 <= arg0.total_supply, 308);
    }

    fun cal_payment_amount(arg0: &0x2::vec_map::VecMap<0x1::string::String, Payment>, arg1: 0x1::string::String, arg2: u64, arg3: u8) : u64 {
        let v0 = 0x2::vec_map::get<0x1::string::String, Payment>(arg0, &arg1);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::utils::mul_u64_div_decimal(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::utils::mul_u64_div_decimal(v0.ratio_per_token, arg2, v0.ratio_decimal), (0x2::math::pow(10, v0.payment_decimal) as u64), arg3)
    }

    public fun claim_vesting<T0>(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object_bag::borrow_mut<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        let v2 = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_vesting::update_withdraw(arg0, v1, arg2, v0);
        assert!(v2 > 0, 300);
        assert!(0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_vesting::check_is_open_claim_vesting(v1), 301);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::vault::withdraw<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::vault::Vaults>(&mut arg1.other, 0x1::string::utf8(b"VAULT")), v2, v0, arg3);
        let v3 = ClaimVesting{
            round_id       : 0x2::object::uid_to_inner(&arg1.id),
            period_id_list : arg2,
            total_claim    : v2,
            sender         : v0,
        };
        0x2::event::emit<ClaimVesting>(v3);
    }

    public(friend) fun get_mut_policy(arg0: &mut Round) : &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::policy::Policy {
        0x2::object_bag::borrow_mut<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::policy::Policy>(&mut arg0.other, 0x1::string::utf8(b"POLICY"))
    }

    public(friend) fun get_mut_service(arg0: &mut Round) : &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service::Service {
        0x2::object_bag::borrow_mut<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service::Service>(&mut arg0.other, 0x1::string::utf8(b"SERVICE"))
    }

    public(friend) fun get_mut_vault(arg0: &mut Round) : &mut 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::vault::Vaults {
        0x2::object_bag::borrow_mut<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::vault::Vaults>(&mut arg0.other, 0x1::string::utf8(b"VAULT"))
    }

    public fun get_project(arg0: &Round) : 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::ProjectInfo {
        arg0.project
    }

    public fun get_token_type(arg0: &Round) : 0x1::string::String {
        arg0.token_type
    }

    fun init(arg0: IDO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<IDO>(arg0, arg1);
        display<Round>(&v0, 0x1::string::utf8(b"YouSUI x {project.name} <> {name}"), 0x1::string::utf8(b"{project.description}"), arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    fun new_policy(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>, arg1: &mut 0x2::object_bag::ObjectBag, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"POLICY");
        let (v1, v2) = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::policy::new(arg2);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(arg0, v0, v2);
        0x2::object_bag::add<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::policy::Policy>(arg1, v0, v1);
    }

    public(friend) fun new_round<T0>(arg0: 0x1::string::String, arg1: 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::ProjectInfo, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Round {
        let v0 = 0x2::object::new(arg6);
        let v1 = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::utils::get_full_type<T0>();
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>();
        let v3 = 0x2::object_bag::new(arg6);
        let v4 = &mut v2;
        let v5 = &mut v3;
        new_policy(v4, v5, arg6);
        let v6 = &mut v2;
        let v7 = &mut v3;
        new_service(v6, v7, arg6);
        let v8 = &mut v2;
        let v9 = &mut v3;
        new_vault(v8, v9, arg6);
        let v10 = NewRound{
            round_id      : 0x2::object::uid_to_inner(&v0),
            round_name    : arg0,
            project_name  : 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::project::get_project_name(&arg1),
            token_type    : v1,
            token_decimal : arg2,
            total_supply  : arg5,
            sender        : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<NewRound>(v10);
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
            core          : v2,
            other         : v3,
        }
    }

    fun new_service(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>, arg1: &mut 0x2::object_bag::ObjectBag, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"SERVICE");
        let (v1, v2) = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service::new(arg2);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(arg0, v0, v2);
        0x2::object_bag::add<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service::Service>(arg1, v0, v1);
    }

    fun new_vault(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>, arg1: &mut 0x2::object_bag::ObjectBag, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"VAULT");
        let (v1, v2) = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::vault::new(arg2);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(arg0, v0, v2);
        0x2::object_bag::add<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::vault::Vaults>(arg1, v0, v1);
    }

    public fun purchase<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Round, arg2: u64, arg3: vector<0x2::coin::Coin<T1>>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::utils::get_full_type<T1>();
        let v3 = cal_payment_amount(&arg1.payments, v2, arg2, arg1.token_decimal);
        buy_validate(arg1, arg2, v0);
        let v4 = Receipt{
            payment        : *0x2::vec_map::get<0x1::string::String, Payment>(&arg1.payments, &v2),
            payment_amount : v3,
            token_amount   : arg2,
        };
        if (!0x2::dynamic_field::exists_<address>(&arg1.id, v1)) {
            let v5 = 0x1::vector::empty<Receipt>();
            0x1::vector::push_back<Receipt>(&mut v5, v4);
            let v6 = Invest{
                investments            : v5,
                total_accumulate_token : arg2,
            };
            0x2::dynamic_field::add<address, Invest>(&mut arg1.id, v1, v6);
        } else {
            let v7 = 0x2::dynamic_field::borrow_mut<address, Invest>(&mut arg1.id, v1);
            v7.total_accumulate_token = v7.total_accumulate_token + arg2;
            0x1::vector::push_back<Receipt>(&mut v7.investments, v4);
        };
        let v8 = 0x2::object_bag::borrow_mut<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::policy::Policy>(&mut arg1.other, 0x1::string::utf8(b"POLICY"));
        let v9 = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::policy::new_request(0x2::object::uid_to_inner(&arg1.id));
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::policy_purchase::check(v8, &mut v9, arg2);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::policy::confirm_request(v8, v9);
        update_state_purchase<T1>(arg1, v0, arg2, v3, arg3, arg5);
        let v10 = 0x2::object_bag::borrow_mut<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service::Service>(&mut arg1.other, 0x1::string::utf8(b"SERVICE"));
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_affiliate::add_profit_by_affiliate<T1>(v10, arg4, v3);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::service_vesting::execute_add_vesting(v10, arg2, v1);
        let v11 = Purchase{
            round_id            : 0x2::object::uid_to_inner(&arg1.id),
            token_amount        : arg2,
            payment_amount      : v3,
            payment_method_type : v2,
            sender              : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<Purchase>(v11);
    }

    public(friend) fun remove_payment<T0>(arg0: &mut Round) {
        let v0 = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::utils::get_full_type<T0>();
        if (0x2::vec_map::contains<0x1::string::String, Payment>(&arg0.payments, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, Payment>(&mut arg0.payments, &v0);
        };
    }

    public(friend) fun set_end_at(arg0: &mut Round, arg1: u64) {
        assert!(arg0.start_at < arg1, 302);
        arg0.end_at = arg1;
    }

    public(friend) fun set_pause(arg0: &mut Round, arg1: bool) {
        arg0.is_pause = arg1;
    }

    public(friend) fun set_payment_rate<T0>(arg0: &mut Round, arg1: u64) {
        let v0 = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::utils::get_full_type<T0>();
        0x2::vec_map::get_mut<0x1::string::String, Payment>(&mut arg0.payments, &v0).ratio_per_token = arg1;
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

    fun update_state_purchase<T0>(arg0: &mut Round, arg1: u64, arg2: u64, arg3: u64, arg4: vector<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.total_sold = arg0.total_sold + arg2;
        let v0 = 0x2::tx_context::sender(arg5);
        if (!0x2::vec_set::contains<address>(&arg0.participants, &v0)) {
            0x2::vec_set::insert<address>(&mut arg0.participants, v0);
            0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::certificate::issue_investment_certificate(arg1, arg0.project, arg0.name, arg0.token_type, arg5);
        };
        let (v1, v2) = 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::utils::merge_and_split<T0>(arg4, arg3, arg5);
        0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::vault::deposit<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0xe6ac959aa48e3505b5c96cb75273533c3101421503ff4f8fbe5a90407ac6022a::vault::Vaults>(&mut arg0.other, 0x1::string::utf8(b"VAULT")), v1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

