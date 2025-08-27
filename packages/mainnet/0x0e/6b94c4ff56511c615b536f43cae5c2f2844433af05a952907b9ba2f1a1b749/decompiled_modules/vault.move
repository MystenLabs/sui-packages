module 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::vault {
    struct Position has copy, drop, store {
        coll_amount: u64,
        debt_amount: u64,
        interest_unit: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::Double,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        security_level: u8,
        access_control: 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::acl::Acl,
        decimal: u8,
        interest_rate: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::Double,
        interest_unit: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::Double,
        timestamp: u64,
        total_pending_interest_amount: u64,
        limited_supply: 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::limited_supply::LimitedSupply,
        total_debt_amount: u64,
        min_collateral_ratio: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float,
        liquidation_rule: 0x1::type_name::TypeName,
        request_checklist: vector<0x1::type_name::TypeName>,
        response_checklist: vector<0x1::type_name::TypeName>,
        position_table: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::LinkedTable<address, Position>,
        balance: 0x2::balance::Balance<T0>,
        position_locker: 0x2::vec_set::VecSet<address>,
    }

    struct PositionData has copy, drop {
        debtor: address,
        coll_amount: u64,
        debt_amount: u64,
    }

    public fun id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        0x2::object::id<Vault<T0>>(arg0)
    }

    public fun new<T0, T1: drop>(arg0: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap, arg2: u8, arg3: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::Double, arg4: u64, arg5: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float, arg6: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::version::assert_valid_package(arg0);
        let v0 = 0x2::object::new(arg6);
        if (0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::gt(arg3, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::from(1))) {
            err_invalid_vault_settings();
        };
        if (0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::lte(arg5, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from(1))) {
            err_invalid_vault_settings();
        };
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::events::emit_vault_created<T0>(0x2::object::uid_to_inner(&v0), arg3, arg4, arg5);
        Vault<T0>{
            id                            : v0,
            security_level                : 0,
            access_control                : 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::acl::new(),
            decimal                       : arg2,
            interest_rate                 : arg3,
            interest_unit                 : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::zero(),
            timestamp                     : 0,
            total_pending_interest_amount : 0,
            limited_supply                : 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::limited_supply::new(arg4),
            total_debt_amount             : 0,
            min_collateral_ratio          : arg5,
            liquidation_rule              : 0x1::type_name::get<T1>(),
            request_checklist             : 0x1::vector::empty<0x1::type_name::TypeName>(),
            response_checklist            : 0x1::vector::empty<0x1::type_name::TypeName>(),
            position_table                : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::new<address, Position>(arg6),
            balance                       : 0x2::balance::zero<T0>(),
            position_locker               : 0x2::vec_set::empty<address>(),
        }
    }

    public fun limited_supply<T0>(arg0: &Vault<T0>) : &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::limited_supply::LimitedSupply {
        &arg0.limited_supply
    }

    public fun decimal<T0>(arg0: &Vault<T0>) : u8 {
        arg0.decimal
    }

    public fun liquidate<T0, T1: drop>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg2: &0x2::clock::Clock, arg3: &0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::result::PriceResult<T0>, arg4: address, arg5: 0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>, arg6: T1, arg7: &mut 0x2::tx_context::TxContext) : 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::UpdateRequest<T0> {
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::version::assert_valid_package(arg1);
        assert_position_is_not_locked<T0>(arg0, arg4);
        0x2::vec_set::insert<address>(&mut arg0.position_locker, arg4);
        if (arg0.liquidation_rule != 0x1::type_name::get<T1>()) {
            err_invalid_liquidation();
        };
        check_secutiry_level<T0>(arg0, 1);
        if (position_is_healthy<T0>(arg0, arg4, arg2, arg3)) {
            err_position_is_healthy();
        };
        let (v0, v1) = get_position_data<T0>(arg0, arg4, arg2);
        if (0x2::coin::value<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&arg5) > v1) {
            err_invalid_liquidation();
        };
        let v2 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::floor(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::div_u64(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::mul_u64(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::from(0x2::coin::value<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&arg5)), v0), v1));
        let v3 = v2;
        if (v2 > v0) {
            v3 = v0;
        };
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::new<T0>(id<T0>(arg0), arg4, 0x2::coin::zero<T0>(arg7), 0, arg5, v3, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::memo::liquidate())
    }

    fun accrue_interest<T0>(arg0: &mut Vault<T0>, arg1: &mut Position, arg2: &mut 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = collect_interest<T0>(arg0, arg2, arg3, arg4);
        let v1 = interest_amount(arg1, v0);
        arg1.debt_amount = arg1.debt_amount + v1;
        arg1.interest_unit = current_vault_interest_unit<T0>(arg0, arg3);
        v1
    }

    public fun add_request_check<T0, T1: drop>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(request_checklist<T0>(arg0), &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.request_checklist, v0);
        };
    }

    public fun add_response_check<T0, T1: drop>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(response_checklist<T0>(arg0), &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.response_checklist, v0);
        };
    }

    fun assert_position_is_not_locked<T0>(arg0: &Vault<T0>, arg1: address) {
        if (0x2::vec_set::contains<address>(&arg0.position_locker, &arg1)) {
            err_position_is_locked();
        };
    }

    fun burn_usdb<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg2: 0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>) {
        0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::limited_supply::decrease(&mut arg0.limited_supply, 0x2::coin::value<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&arg2));
        0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::burn<0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::witness::BucketV2CDP>(arg1, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::witness::witness(), 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::version::package_version(), arg2);
    }

    fun check_secutiry_level<T0>(arg0: &Vault<T0>, arg1: u8) {
        if (arg0.security_level != 0 && arg1 >= arg0.security_level) {
            err_against_security_level();
        };
    }

    public fun collect_interest<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::Double {
        let v0 = current_vault_interest_unit<T0>(arg0, arg2);
        let v1 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::ceil(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::mul_u64(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::sub(v0, arg0.interest_unit), arg0.total_debt_amount));
        if (v1 > 0) {
            let v2 = 0x1::u64::min(v1, 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::limited_supply::increasable_amount(limited_supply<T0>(arg0)));
            let v3 = v1 - v2;
            if (v2 > 0) {
                let v4 = mint_usdb<T0>(arg0, arg1, v2, arg3);
                0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::collect<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::witness::BucketV2CDP>(arg1, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::witness::witness(), 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::memo::interest(), 0x2::coin::into_balance<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(v4));
            };
            if (v3 > 0) {
                arg0.total_pending_interest_amount = arg0.total_pending_interest_amount + v3;
            };
            arg0.total_debt_amount = arg0.total_debt_amount + v1;
        };
        arg0.interest_unit = v0;
        arg0.timestamp = 0x2::clock::timestamp_ms(arg2);
        v0
    }

    entry fun create<T0, T1: drop>(arg0: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Vault<T0>>(new<T0, T1>(arg0, arg1, arg2, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::from_bps(arg3), arg4, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_bps(arg5), arg6));
    }

    fun current_vault_interest_unit<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::Double {
        if (arg0.total_debt_amount > 0) {
            0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::add(arg0.interest_unit, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::mul(arg0.interest_rate, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::from_fraction(0x2::clock::timestamp_ms(arg1) - arg0.timestamp, one_year())))
        } else {
            arg0.interest_unit
        }
    }

    public fun debtor_request<T0>(arg0: &mut Vault<T0>, arg1: &0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::account::AccountRequest, arg2: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>, arg6: u64) : 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::UpdateRequest<T0> {
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::version::assert_valid_package(arg2);
        let v0 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::account::request_address(arg1);
        assert_position_is_not_locked<T0>(arg0, v0);
        0x2::vec_set::insert<address>(&mut arg0.position_locker, v0);
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::new<T0>(id<T0>(arg0), v0, arg3, arg4, arg5, arg6, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::memo::manage())
    }

    public fun destroy_response<T0>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg2: 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::response::UpdateResponse<T0>) {
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::version::assert_valid_package(arg1);
        let v0 = 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::response::account<T0>(&arg2);
        0x2::vec_set::remove<address>(&mut arg0.position_locker, &v0);
        let (v1, _, _, _, _, v6) = 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::response::destroy<T0>(arg2);
        let v7 = v6;
        if (v1 != id<T0>(arg0)) {
            err_wrong_vault_id();
        };
        let v8 = response_checklist<T0>(arg0);
        let v9 = 0;
        let v10;
        while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(v8)) {
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v7, 0x1::vector::borrow<0x1::type_name::TypeName>(v8, v9))) {
                v10 = false;
                /* label 8 */
                if (!v10) {
                    err_missing_response_witness();
                };
                return
            };
            v9 = v9 + 1;
        };
        v10 = true;
        /* goto 8 */
    }

    public fun donor_request<T0>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>) : 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::UpdateRequest<T0> {
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::version::assert_valid_package(arg1);
        assert_position_is_not_locked<T0>(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.position_locker, arg2);
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::new<T0>(id<T0>(arg0), arg2, arg3, 0, arg4, 0, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::memo::donate())
    }

    fun err_against_security_level() {
        abort 412
    }

    fun err_debtor_not_found() {
        abort 407
    }

    fun err_invalid_liquidation() {
        abort 406
    }

    fun err_invalid_vault_settings() {
        abort 411
    }

    fun err_missing_request_witness() {
        abort 401
    }

    fun err_missing_response_witness() {
        abort 402
    }

    fun err_not_manager() {
        abort 413
    }

    fun err_oracle_price_is_required() {
        abort 403
    }

    fun err_position_is_healthy() {
        abort 405
    }

    fun err_position_is_locked() {
        abort 414
    }

    fun err_position_is_not_healthy() {
        abort 404
    }

    fun err_repay_too_much() {
        abort 408
    }

    fun err_withdraw_too_much() {
        abort 409
    }

    fun err_wrong_vault_id() {
        abort 410
    }

    public fun get_position_data<T0>(arg0: &Vault<T0>, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64) {
        if (!0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::contains<address, Position>(&arg0.position_table, arg1)) {
            err_debtor_not_found();
        };
        let v0 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::borrow<address, Position>(&arg0.position_table, arg1);
        (v0.coll_amount, v0.debt_amount + interest_amount(v0, current_vault_interest_unit<T0>(arg0, arg2)))
    }

    public fun get_positions<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<address>, arg3: u64) : (vector<PositionData>, 0x1::option::Option<address>) {
        let v0 = 0x1::vector::empty<PositionData>();
        let v1 = &arg0.position_table;
        if (0x1::option::is_none<address>(&arg2)) {
            arg2 = *0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::front<address, Position>(v1);
        };
        let v2 = 0;
        while (0x1::option::is_some<address>(&arg2) && v2 < arg3) {
            let v3 = *0x1::option::borrow<address>(&arg2);
            let (v4, v5) = get_position_data<T0>(arg0, v3, arg1);
            let v6 = PositionData{
                debtor      : v3,
                coll_amount : v4,
                debt_amount : v5,
            };
            0x1::vector::push_back<PositionData>(&mut v0, v6);
            v2 = v2 + 1;
            arg2 = *0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::next<address, Position>(v1, v3);
        };
        (v0, arg2)
    }

    public fun get_raw_position_data<T0>(arg0: &Vault<T0>, arg1: address) : (u64, u64, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::Double) {
        let v0 = position_table<T0>(arg0);
        if (!0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::contains<address, Position>(v0, arg1)) {
            err_debtor_not_found();
        };
        let v1 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::borrow<address, Position>(v0, arg1);
        (v1.coll_amount, v1.debt_amount, v1.interest_unit)
    }

    fun interest_amount(arg0: &Position, arg1: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::Double) : u64 {
        0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::ceil(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::mul_u64(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::sub(arg1, arg0.interest_unit), arg0.debt_amount))
    }

    public fun interest_rate<T0>(arg0: &Vault<T0>) : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::Double {
        arg0.interest_rate
    }

    public fun liquidation_rule<T0>(arg0: &Vault<T0>) : 0x1::type_name::TypeName {
        arg0.liquidation_rule
    }

    public fun min_collateral_ratio<T0>(arg0: &Vault<T0>) : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float {
        arg0.min_collateral_ratio
    }

    fun mint_usdb<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB> {
        0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::limited_supply::increase(&mut arg0.limited_supply, arg2);
        0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::mint<0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::witness::BucketV2CDP>(arg1, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::witness::witness(), 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::version::package_version(), arg2, arg3)
    }

    fun one_year() : u64 {
        31536000000
    }

    public fun position_data(arg0: &PositionData) : (address, u64, u64) {
        (arg0.debtor, arg0.coll_amount, arg0.debt_amount)
    }

    public fun position_exists<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::contains<address, Position>(position_table<T0>(arg0), arg1)
    }

    public fun position_is_healthy<T0>(arg0: &Vault<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::result::PriceResult<T0>) : bool {
        let (v0, v1) = get_position_data<T0>(arg0, arg1, arg2);
        if (v1 > 0) {
            let v3 = 10;
            0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::gte(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::div(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::mul(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_fraction(v0, 0x1::u64::pow(v3, decimal<T0>(arg0))), 0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::result::aggregated_price<T0>(arg3)), 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_fraction(v1, 0x1::u64::pow(v3, 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::decimal()))), arg0.min_collateral_ratio)
        } else {
            true
        }
    }

    public fun position_table<T0>(arg0: &Vault<T0>) : &0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::LinkedTable<address, Position> {
        &arg0.position_table
    }

    public fun remove_manager_role<T0>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap, arg2: address) {
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::acl::remove_role(&mut arg0.access_control, arg2);
    }

    public fun remove_request_check<T0, T1: drop>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = request_checklist<T0>(arg0);
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v3)) {
                    0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.request_checklist, 0x1::option::destroy_some<u64>(v3));
                } else {
                    0x1::option::destroy_none<u64>(v3);
                };
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun remove_response_check<T0, T1: drop>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = response_checklist<T0>(arg0);
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v3)) {
                    0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.response_checklist, 0x1::option::destroy_some<u64>(v3));
                } else {
                    0x1::option::destroy_none<u64>(v3);
                };
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun request_checklist<T0>(arg0: &Vault<T0>) : &vector<0x1::type_name::TypeName> {
        &arg0.request_checklist
    }

    public fun response_checklist<T0>(arg0: &Vault<T0>) : &vector<0x1::type_name::TypeName> {
        &arg0.response_checklist
    }

    public fun set_interest_rate<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg2: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::version::assert_valid_package(arg1);
        collect_interest<T0>(arg0, arg1, arg3, arg5);
        arg0.interest_rate = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::double::from_bps(arg4);
    }

    public fun set_liquidation_rule<T0, T1: drop>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T1>();
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::events::emit_liquidation_rule_updated<T0>(0x2::object::id<Vault<T0>>(arg0), liquidation_rule<T0>(arg0), v0);
        arg0.liquidation_rule = v0;
    }

    public fun set_manager_role<T0>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap, arg2: address, arg3: u8) {
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::acl::set_role(&mut arg0.access_control, arg2, arg3);
    }

    public fun set_security_by_admin<T0>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap, arg2: u8) {
        arg0.security_level = arg2;
    }

    public fun set_security_by_manager_level<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::acl::exists_role(&arg0.access_control, v0)) {
            err_not_manager();
        };
        arg0.security_level = 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::acl::role_level(&arg0.access_control, v0);
    }

    public fun set_supply_limit<T0>(arg0: &mut Vault<T0>, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap, arg2: u64) {
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::events::emit_supply_limit_updated<T0>(0x2::object::id<Vault<T0>>(arg0), 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::limited_supply::limit(limited_supply<T0>(arg0)), arg2);
        0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::limited_supply::set_limit(&mut arg0.limited_supply, arg2);
    }

    public fun try_get_position_data<T0>(arg0: &Vault<T0>, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64) {
        if (0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::contains<address, Position>(&arg0.position_table, arg1)) {
            let v2 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::borrow<address, Position>(&arg0.position_table, arg1);
            (v2.coll_amount, v2.debt_amount + interest_amount(v2, current_vault_interest_unit<T0>(arg0, arg2)))
        } else {
            (0, 0)
        }
    }

    public fun update_position<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg2: &0x2::clock::Clock, arg3: &0x1::option::Option<0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::result::PriceResult<T0>>, arg4: 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::UpdateRequest<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::response::UpdateResponse<T0>) {
        0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::version::assert_valid_package(arg1);
        let v0 = 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::account<T0>(&arg4);
        if (0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::deposit_amount<T0>(&arg4) > 0) {
            check_secutiry_level<T0>(arg0, 1);
        } else {
            check_secutiry_level<T0>(arg0, 2);
        };
        let v1 = &mut arg0.position_table;
        let (v2, v3, v4) = if (0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::contains<address, Position>(v1, v0)) {
            let v5 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::remove<address, Position>(v1, v0);
            let v6 = &mut v5;
            let v7 = accrue_interest<T0>(arg0, v6, arg1, arg2, arg5);
            (v5, v7, *0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::next<address, Position>(v1, v0))
        } else {
            collect_interest<T0>(arg0, arg1, arg2, arg5);
            let v8 = Position{
                coll_amount   : 0,
                debt_amount   : 0,
                interest_unit : current_vault_interest_unit<T0>(arg0, arg2),
            };
            (v8, 0, 0x1::option::none<address>())
        };
        let v9 = v2;
        v9.coll_amount = v9.coll_amount + 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::deposit_amount<T0>(&arg4);
        v9.debt_amount = v9.debt_amount + 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::borrow_amount<T0>(&arg4);
        if (v9.debt_amount < 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::repay_amount<T0>(&arg4)) {
            err_repay_too_much();
        };
        v9.debt_amount = v9.debt_amount - 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::repay_amount<T0>(&arg4);
        if (v9.coll_amount < 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::withdraw_amount<T0>(&arg4)) {
            err_withdraw_too_much();
        };
        v9.coll_amount = v9.coll_amount - 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::withdraw_amount<T0>(&arg4);
        arg0.total_debt_amount = arg0.total_debt_amount + 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::borrow_amount<T0>(&arg4) - 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::repay_amount<T0>(&arg4);
        let (v10, v11) = if (v9.coll_amount == 0 && v9.debt_amount == 0) {
            let Position {
                coll_amount   : v12,
                debt_amount   : v13,
                interest_unit : _,
            } = v9;
            (v12, v13)
        } else {
            0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::linked_table::insert_front<address, Position>(&mut arg0.position_table, v4, v0, v9);
            get_position_data<T0>(arg0, v0, arg2)
        };
        let (v15, v16, v17, v18, v19, v20, v21, v22) = 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request::destroy<T0>(arg4);
        let v23 = v21;
        let v24 = v19;
        let v25 = v17;
        if (v15 != id<T0>(arg0)) {
            err_wrong_vault_id();
        };
        let v26 = request_checklist<T0>(arg0);
        let v27 = 0;
        let v28;
        while (v27 < 0x1::vector::length<0x1::type_name::TypeName>(v26)) {
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v23, 0x1::vector::borrow<0x1::type_name::TypeName>(v26, v27))) {
                v28 = false;
                /* label 25 */
                if (!v28) {
                    err_missing_request_witness();
                };
                if (v22 == 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::memo::manage() && (v18 > 0 || v20 > 0 && v11 > 0)) {
                    if (0x1::option::is_some<0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::result::PriceResult<T0>>(arg3)) {
                        if (!position_is_healthy<T0>(arg0, v0, arg2, 0x1::option::borrow<0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::result::PriceResult<T0>>(arg3))) {
                            err_position_is_not_healthy();
                        };
                    } else {
                        err_oracle_price_is_required();
                    };
                };
                0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::events::emit_position_updated<T0>(0x2::object::id<Vault<T0>>(arg0), v16, 0x2::coin::value<T0>(&v25), v18, 0x2::coin::value<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&v24), v20, v3, v10, v11, v22);
                0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(v25));
                let v29 = 0x2::coin::take<T0>(&mut arg0.balance, v20, arg5);
                let v30 = if (v18 > 0x2::coin::value<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&v24)) {
                    let v31 = mint_usdb<T0>(arg0, arg1, v18 - 0x2::coin::value<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&v24), arg5);
                    0x2::coin::join<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&mut v31, v24);
                    v31
                } else {
                    if (0x2::coin::value<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&v24) > 0) {
                        let v32 = 0x1::u64::min(0x2::coin::value<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&v24), arg0.total_pending_interest_amount);
                        if (v32 > 0) {
                            arg0.total_pending_interest_amount = arg0.total_pending_interest_amount - v32;
                            0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::collect<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::witness::BucketV2CDP>(arg1, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::witness::witness(), 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::memo::interest(), 0x2::balance::split<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(0x2::coin::balance_mut<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&mut v24), v32));
                        };
                        burn_usdb<T0>(arg0, arg1, v24);
                    } else {
                        0x2::coin::destroy_zero<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(v24);
                    };
                    0x2::coin::split<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&mut v24, v18, arg5)
                };
                return (v29, v30, 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::response::new<T0>(id<T0>(arg0), v0, v10, v11, v3))
            };
            v27 = v27 + 1;
        };
        v28 = true;
        /* goto 25 */
    }

    // decompiled from Move bytecode v6
}

