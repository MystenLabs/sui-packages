module 0x65695741755bffabbd2491612b07956a6db1e171ada45fa7d4b54b91504c806e::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct QuoteConfig has drop, store {
        quote_type: 0x1::string::String,
        config_id: 0x2::object::ID,
        quote_symbol: 0x1::string::String,
        quote_decimals: u8,
        active: bool,
    }

    struct RegistryInitializedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        admin: address,
    }

    struct QuoteUpsertedEvent has copy, drop {
        quote_type: 0x1::string::String,
        config_id: 0x2::object::ID,
        active: bool,
    }

    struct QuoteRemovedEvent has copy, drop {
        quote_type: 0x1::string::String,
    }

    struct QuoteActivationChangedEvent has copy, drop {
        quote_type: 0x1::string::String,
        active: bool,
    }

    struct AdminTransferredEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public fun admin(arg0: &Registry) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &Registry, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
    }

    public fun has_quote<T0>(arg0: &Registry) : bool {
        0x2::dynamic_field::exists_with_type<0x1::ascii::String, QuoteConfig>(&arg0.id, quote_key<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_registry(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg1),
            admin : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_share_object<Registry>(v0);
        let v1 = RegistryInitializedEvent{
            registry_id : 0x2::object::id<Registry>(&v0),
            admin       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RegistryInitializedEvent>(v1);
    }

    fun quote_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    fun quote_label<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(quote_key<T0>()))
    }

    public fun quote_type_string<T0>() : 0x1::string::String {
        quote_label<T0>()
    }

    public fun remove_quote<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0, arg2);
        assert!(has_quote<T0>(arg1), 1);
        let v0 = 0x2::dynamic_field::remove<0x1::ascii::String, QuoteConfig>(&mut arg1.id, quote_key<T0>());
        let v1 = QuoteRemovedEvent{quote_type: v0.quote_type};
        0x2::event::emit<QuoteRemovedEvent>(v1);
    }

    public fun set_quote_active<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0, arg3);
        assert!(has_quote<T0>(arg1), 1);
        let v0 = 0x2::dynamic_field::remove<0x1::ascii::String, QuoteConfig>(&mut arg1.id, quote_key<T0>());
        v0.active = arg2;
        0x2::dynamic_field::add<0x1::ascii::String, QuoteConfig>(&mut arg1.id, quote_key<T0>(), v0);
        let v1 = QuoteActivationChangedEvent{
            quote_type : quote_label<T0>(),
            active     : arg2,
        };
        0x2::event::emit<QuoteActivationChangedEvent>(v1);
    }

    public fun transfer_admin(arg0: &AdminCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0, arg3);
        arg1.admin = arg2;
        let v0 = AdminTransferredEvent{
            old_admin : arg1.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminTransferredEvent>(v0);
    }

    public fun upsert_quote<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u8, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0, arg6);
        if (has_quote<T0>(arg1)) {
            0x2::dynamic_field::remove<0x1::ascii::String, QuoteConfig>(&mut arg1.id, quote_key<T0>());
        };
        let v0 = QuoteConfig{
            quote_type     : quote_label<T0>(),
            config_id      : arg2,
            quote_symbol   : arg3,
            quote_decimals : arg4,
            active         : arg5,
        };
        0x2::dynamic_field::add<0x1::ascii::String, QuoteConfig>(&mut arg1.id, quote_key<T0>(), v0);
        let v1 = QuoteUpsertedEvent{
            quote_type : quote_label<T0>(),
            config_id  : arg2,
            active     : arg5,
        };
        0x2::event::emit<QuoteUpsertedEvent>(v1);
    }

    // decompiled from Move bytecode v7
}

