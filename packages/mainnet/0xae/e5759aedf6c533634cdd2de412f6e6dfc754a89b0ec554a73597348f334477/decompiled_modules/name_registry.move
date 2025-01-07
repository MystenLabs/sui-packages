module 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name_registry {
    struct AuthorizedApp<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct NameRegistry has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        version: u16,
        registry: 0x2::table::Table<0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::Name, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::DotMoveRecord>,
    }

    struct NameRegistryCap has store, key {
        id: 0x2::object::UID,
    }

    struct FinancialCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn<T0: drop>(arg0: &mut NameRegistry, arg1: T0, arg2: 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::DotMove, arg3: &0x2::clock::Clock) {
        assert!(is_app_authorized<T0>(arg0), 3);
        assert!(is_valid_version(arg0), 2);
        assert!(0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::has_expired(&arg2, arg3), 1);
        let v0 = 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::name(&arg2);
        if (0x2::table::contains<0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::Name, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::DotMoveRecord>(&arg0.registry, v0)) {
            if (0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::is_valid_for(0x2::table::borrow<0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::Name, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::DotMoveRecord>(&arg0.registry, v0), &arg2)) {
                0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::burn(0x2::table::remove<0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::Name, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::DotMoveRecord>(&mut arg0.registry, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::name(&arg2)));
            };
        };
        0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::burn(arg2);
    }

    public fun add_record<T0: drop>(arg0: &mut NameRegistry, arg1: T0, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::DotMove {
        assert!(is_app_authorized<T0>(arg0), 3);
        assert!(is_valid_version(arg0), 2);
        let v0 = 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::new(arg2);
        assert!(0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::is_org(&v0), 6);
        remove_record_if_exists_and_expired(arg0, arg2, arg4);
        let v1 = 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::new(v0, arg3, arg4, arg5);
        0x2::table::add<0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::Name, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::DotMoveRecord>(&mut arg0.registry, v0, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::new(arg3, arg4, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::id(&v1), arg5));
        v1
    }

    public fun authorize_app<T0: drop>(arg0: &mut NameRegistry, arg1: &NameRegistryCap) {
        let v0 = AuthorizedApp<T0>{dummy_field: false};
        0x2::dynamic_field::add<AuthorizedApp<T0>, bool>(&mut arg0.id, v0, true);
    }

    public fun deauthorize_app<T0: drop>(arg0: &mut NameRegistry, arg1: &NameRegistryCap) {
        let v0 = AuthorizedApp<T0>{dummy_field: false};
        0x2::dynamic_field::remove<AuthorizedApp<T0>, bool>(&mut arg0.id, v0);
    }

    public fun deposit<T0: drop>(arg0: &mut NameRegistry, arg1: T0, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(is_app_authorized<T0>(arg0), 3);
        assert!(is_valid_version(arg0), 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun extend_expiration<T0: drop>(arg0: &mut NameRegistry, arg1: T0, arg2: &mut 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::DotMove, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(is_app_authorized<T0>(arg0), 3);
        assert!(is_valid_version(arg0), 2);
        assert!(0x2::table::contains<0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::Name, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::DotMoveRecord>(&arg0.registry, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::name(arg2)), 4);
        let v0 = 0x2::table::borrow_mut<0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::Name, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::DotMoveRecord>(&mut arg0.registry, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::name(arg2));
        assert!(0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::is_valid_for(v0, arg2), 5);
        0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::set_expiration_timestamp_ms(v0, arg3, arg4);
        0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::set_expiration_timestamp_ms(arg2, arg3, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NameRegistry{
            id       : 0x2::object::new(arg0),
            balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            version  : 1,
            registry : 0x2::table::new<0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::Name, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::DotMoveRecord>(arg0),
        };
        let v1 = NameRegistryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<NameRegistryCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = FinancialCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FinancialCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<NameRegistry>(v0);
    }

    public fun is_app_authorized<T0: drop>(arg0: &NameRegistry) : bool {
        let v0 = AuthorizedApp<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AuthorizedApp<T0>>(&arg0.id, v0)
    }

    fun is_valid_version(arg0: &NameRegistry) : bool {
        arg0.version == 1
    }

    fun remove_record_if_exists_and_expired(arg0: &mut NameRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        let v0 = 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::new(arg1);
        if (!0x2::table::contains<0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::Name, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::DotMoveRecord>(&arg0.registry, v0)) {
            return
        };
        let v1 = 0x2::table::remove<0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name::Name, 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::DotMoveRecord>(&mut arg0.registry, v0);
        assert!(0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::has_expired(&v1, arg2), 1);
        0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move_record::burn(v1);
    }

    public fun withdraw(arg0: &mut NameRegistry, arg1: &FinancialCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2)
    }

    // decompiled from Move bytecode v6
}

