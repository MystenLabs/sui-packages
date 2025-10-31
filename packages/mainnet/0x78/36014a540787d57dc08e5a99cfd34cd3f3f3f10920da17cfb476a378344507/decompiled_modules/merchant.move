module 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant {
    struct Merchant has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        receiving_addresses: 0x2::vec_map::VecMap<0x1::type_name::TypeName, address>,
        fee_config: FeeConfig,
        settings: MerchantSettings,
        created_at: u64,
        is_active: bool,
        supported_currencies: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct MerchantCap has key {
        id: 0x2::object::UID,
        merchant_id: 0x2::object::ID,
    }

    struct FeeConfig has copy, drop, store {
        platform_fee_bps: u64,
    }

    struct MerchantSettings has store {
        auto_settlement: bool,
        settlement_threshold: u64,
        webhook_url: 0x1::string::String,
        api_keys: vector<0x1::string::String>,
        require_confirmation: bool,
        default_refund_policy: RefundPolicy,
    }

    struct RefundPolicy has copy, drop, store {
        enabled: bool,
        window_days: u64,
        require_approval: bool,
        auto_approve_threshold: u64,
    }

    public entry fun add_supported_currency<T0>(arg0: &mut Merchant, arg1: &MerchantCap, arg2: address) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.merchant_id, 1);
        assert!(arg2 != @0x0, 207);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.supported_currencies, &v0), 205);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.supported_currencies, v0);
        0x2::vec_map::insert<0x1::type_name::TypeName, address>(&mut arg0.receiving_addresses, v0, arg2);
    }

    public(friend) fun admin_set_active_status(arg0: &mut Merchant, arg1: bool) {
        arg0.is_active = arg1;
    }

    public(friend) fun admin_set_platform_fee(arg0: &mut Merchant, arg1: u64) {
        arg0.fee_config.platform_fee_bps = arg1;
    }

    fun calculate_platform_fee(arg0: &Merchant, arg1: u64) : u64 {
        arg1 * arg0.fee_config.platform_fee_bps / 10000
    }

    public fun get_created_at(arg0: &Merchant) : u64 {
        arg0.created_at
    }

    public fun get_description(arg0: &Merchant) : 0x1::string::String {
        arg0.description
    }

    public fun get_fee_config(arg0: &Merchant) : &FeeConfig {
        &arg0.fee_config
    }

    public fun get_merchant_id(arg0: &Merchant) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_name(arg0: &Merchant) : 0x1::string::String {
        arg0.name
    }

    public fun get_owner(arg0: &Merchant) : address {
        arg0.owner
    }

    public fun get_platform_fee_bps(arg0: &Merchant) : u64 {
        arg0.fee_config.platform_fee_bps
    }

    public fun get_receiving_address<T0>(arg0: &Merchant) : address {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.supported_currencies, &v0), 206);
        *0x2::vec_map::get<0x1::type_name::TypeName, address>(&arg0.receiving_addresses, &v0)
    }

    public fun is_currency_supported<T0>(arg0: &Merchant) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.supported_currencies, &v0)
    }

    public fun is_merchant_active(arg0: &Merchant) : bool {
        arg0.is_active
    }

    public entry fun register_merchant(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) > 0, 203);
        assert!(0x1::string::length(&arg0) <= 100, 203);
        assert!(0x1::string::length(&arg1) <= 500, 203);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v2 = 0x2::object::new(arg2);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = MerchantCap{
            id          : 0x2::object::new(arg2),
            merchant_id : v3,
        };
        0x2::transfer::transfer<MerchantCap>(v4, v0);
        let v5 = RefundPolicy{
            enabled                : true,
            window_days            : 7,
            require_approval       : false,
            auto_approve_threshold : 0,
        };
        let v6 = MerchantSettings{
            auto_settlement       : false,
            settlement_threshold  : 0,
            webhook_url           : 0x1::string::utf8(b""),
            api_keys              : 0x1::vector::empty<0x1::string::String>(),
            require_confirmation  : false,
            default_refund_policy : v5,
        };
        let v7 = FeeConfig{platform_fee_bps: 30};
        let v8 = Merchant{
            id                   : v2,
            owner                : v0,
            name                 : arg0,
            description          : arg1,
            receiving_addresses  : 0x2::vec_map::empty<0x1::type_name::TypeName, address>(),
            fee_config           : v7,
            settings             : v6,
            created_at           : v1,
            is_active            : true,
            supported_currencies : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events::emit_merchant_registered(v3, v0, arg0, v1);
        0x2::transfer::public_share_object<Merchant>(v8);
    }

    public entry fun remove_supported_currency<T0>(arg0: &mut Merchant, arg1: &MerchantCap) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.merchant_id, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.supported_currencies, &v0), 206);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.supported_currencies, &v0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, address>(&arg0.receiving_addresses, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, address>(&mut arg0.receiving_addresses, &v0);
        };
    }

    public entry fun set_receiving_address<T0>(arg0: &mut Merchant, arg1: &MerchantCap, arg2: address) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.merchant_id, 1);
        assert!(arg2 != @0x0, 207);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.supported_currencies, &v0), 206);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, address>(&arg0.receiving_addresses, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, address>(&mut arg0.receiving_addresses, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, address>(&mut arg0.receiving_addresses, v0, arg2);
        };
    }

    public entry fun toggle_merchant_status(arg0: &mut Merchant, arg1: &MerchantCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.merchant_id, 1);
        arg0.is_active = arg2;
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events::emit_merchant_status_changed(0x2::object::uid_to_inner(&arg0.id), arg2, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public entry fun update_merchant_info(arg0: &mut Merchant, arg1: &MerchantCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.merchant_id, 1);
        if (0x1::string::length(&arg2) > 0) {
            assert!(0x1::string::length(&arg2) <= 100, 203);
            arg0.name = arg2;
        };
        if (0x1::string::length(&arg3) > 0) {
            assert!(0x1::string::length(&arg3) <= 500, 203);
            arg0.description = arg3;
        };
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events::emit_merchant_settings_updated(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg4), 0x2::tx_context::epoch_timestamp_ms(arg4));
    }

    public fun verify_merchant_cap(arg0: &MerchantCap, arg1: &Merchant) : bool {
        0x2::object::uid_to_inner(&arg1.id) == arg0.merchant_id
    }

    // decompiled from Move bytecode v6
}

