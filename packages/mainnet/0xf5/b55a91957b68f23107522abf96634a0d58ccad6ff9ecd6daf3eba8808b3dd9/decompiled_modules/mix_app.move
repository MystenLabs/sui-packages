module 0xf5b55a91957b68f23107522abf96634a0d58ccad6ff9ecd6daf3eba8808b3dd9::mix_app {
    struct MixApp has key {
        id: 0x2::object::UID,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
        inner_hash: vector<u8>,
    }

    struct ConfigKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MixAppConfig has copy, drop, store {
        name: 0x1::string::String,
        mixing_limit: u8,
        cool_down_period: u64,
        mixing_price: u64,
        parents_selector_threshold: vector<u8>,
    }

    public fun mixing_limit<T0>(arg0: &MixApp) : u8 {
        get_config<T0>(&arg0.id).mixing_limit
    }

    public fun add_country_code<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut MixApp, arg2: 0x1::string::String) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::add_country_code<T0>(arg0, &mut arg1.id, arg2);
    }

    public fun remove_country_code<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut MixApp, arg2: 0x1::string::String) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::remove_country_code<T0>(arg0, &mut arg1.id, arg2);
    }

    fun assert_fren_can_be_mixed<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg1: u64, arg2: u64) {
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs::last_epoch_mixed<T0>(arg0);
        if (0x1::option::is_some<u64>(&v0)) {
            assert!(arg1 - *0x1::option::borrow<u64>(&v0) >= arg2, 2);
        };
    }

    fun assert_selector_thresholds_validity(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 2, 6);
        let v0 = 1;
        let v1 = *0x1::vector::borrow<u8>(arg0, 0);
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            v1 = *0x1::vector::borrow<u8>(arg0, v0);
            assert!(v0 > 0 && v1 > v1, 6);
            assert!(v1 <= 255, 6);
            v0 = v0 + 1;
        };
    }

    fun assert_valid_config_exists<T0>(arg0: &0x2::object::UID) {
        let v0 = ConfigKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<ConfigKey<T0>>(arg0, v0), 7);
    }

    public fun attach_mix_app_config<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut MixApp, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: vector<u8>) {
        assert_selector_thresholds_validity(&arg6);
        assert!(arg3 > 0, 8);
        let v0 = ConfigKey<T0>{dummy_field: false};
        let v1 = MixAppConfig{
            name                       : arg2,
            mixing_limit               : arg3,
            cool_down_period           : arg4,
            mixing_price               : arg5,
            parents_selector_threshold : arg6,
        };
        0x2::dynamic_field::add<ConfigKey<T0>, MixAppConfig>(&mut arg1.id, v0, v1);
    }

    public fun authorize<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut MixApp, arg2: u32, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: vector<0x1::string::String>, arg7: vector<u8>) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::authorize_app<T0>(arg0, &mut arg1.id, 0x1::string::utf8(b"mix_app"), arg2, arg3, arg4, arg5, arg6);
        0xf5b55a91957b68f23107522abf96634a0d58ccad6ff9ecd6daf3eba8808b3dd9::genes_v2::add_gene_definitions<T0>(&mut arg1.id, arg7);
    }

    fun compute_genes(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: u64) : vector<u8> {
        assert!(0 < arg4 && arg4 <= 32, 5);
        let v0 = 0;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs::derive(arg1, 1);
        let v3 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs::derive(arg1, 2);
        while (v0 + 1 < arg4) {
            0x1::vector::append<u8>(&mut v1, get_inherited_or_random_genes(arg0, *0x1::vector::borrow<u8>(&v2, v0), arg2, arg3, &v3, v0));
            v0 = v0 + 2;
        };
        v1
    }

    public fun cooldown_period<T0>(arg0: &MixApp) : u64 {
        get_config<T0>(&arg0.id).cool_down_period
    }

    public fun deauthorize<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut MixApp) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::revoke_auth<T0>(arg0, &mut arg1.id);
    }

    fun get_config<T0>(arg0: &0x2::object::UID) : &MixAppConfig {
        assert_valid_config_exists<T0>(arg0);
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<ConfigKey<T0>, MixAppConfig>(arg0, v0)
    }

    fun get_config_mut<T0>(arg0: &mut 0x2::object::UID) : &mut MixAppConfig {
        assert_valid_config_exists<T0>(arg0);
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ConfigKey<T0>, MixAppConfig>(arg0, v0)
    }

    public fun get_inherited_or_random_genes(arg0: &vector<u8>, arg1: u8, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: u64) : vector<u8> {
        assert_selector_thresholds_validity(arg0);
        let v0 = 0x1::vector::empty<u8>();
        if (arg1 <= *0x1::vector::borrow<u8>(arg0, 0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg2, arg5));
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg2, arg5 + 1));
        } else if (arg1 <= *0x1::vector::borrow<u8>(arg0, 1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg3, arg5));
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg3, arg5 + 1));
        } else {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg4, arg5));
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg4, arg5 + 1));
        };
        v0
    }

    fun handle_payment(arg0: &mut MixApp, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg1, 3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.profits, 0x2::coin::split<0x2::sui::SUI>(arg2, arg1, arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = MixApp{
            id         : v0,
            profits    : 0x2::balance::zero<0x2::sui::SUI>(),
            inner_hash : 0x2::hash::blake2b256(&v1),
        };
        0x2::transfer::share_object<MixApp>(v2);
    }

    public fun mix<T0>(arg0: &mut MixApp, arg1: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::transfer_policy::TransferPolicy<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::is_authorized<T0>(&arg0.id), 0);
        let v0 = *get_config<T0>(&arg0.id);
        handle_payment(arg0, v0.mixing_price, arg4, arg8);
        let v1 = 0x2::tx_context::epoch(arg8);
        assert_fren_can_be_mixed<T0>(arg1, v1, v0.cool_down_period);
        assert_fren_can_be_mixed<T0>(arg2, v1, v0.cool_down_period);
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs::app_set_last_epoch_mixed<T0>(&mut arg0.id, arg1, v1);
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs::app_set_last_epoch_mixed<T0>(&mut arg0.id, arg2, v1);
        set_fren_mixing_limit_internal<T0>(arg0, arg1, v0.mixing_limit);
        set_fren_mixing_limit_internal<T0>(arg0, arg2, v0.mixing_limit);
        let v2 = 0x2::tx_context::fresh_object_address(arg8);
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = &mut v3;
        0x1::vector::push_back<vector<u8>>(v4, arg0.inner_hash);
        0x1::vector::push_back<vector<u8>>(v4, 0x2::bcs::to_bytes<address>(&v2));
        0x1::vector::push_back<vector<u8>>(v4, 0x2::bcs::to_bytes<0x2::clock::Clock>(arg3));
        let v5 = 0x2::bcs::to_bytes<vector<vector<u8>>>(&v3);
        let v6 = 0x2::hash::blake2b256(&v5);
        let v7 = compute_genes(&v0.parents_selector_threshold, &v6, 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::genes<T0>(arg1), 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::genes<T0>(arg2), 32);
        let v8 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::mint<T0>(&mut arg0.id, 1 + 0x2::math::max(0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::generation<T0>(arg1), 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::generation<T0>(arg2)), v7, 0xf5b55a91957b68f23107522abf96634a0d58ccad6ff9ecd6daf3eba8808b3dd9::genes_v2::get_attributes<T0>(&arg0.id, &v7), arg3, arg8);
        let v9 = 0x1::vector::empty<0x2::object::ID>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x2::object::ID>(v10, 0x2::object::id<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>>(arg1));
        0x1::vector::push_back<0x2::object::ID>(v10, 0x2::object::id<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>>(arg2));
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs::app_set_parents<T0>(&mut arg0.id, &mut v8, v9);
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs::app_set_last_epoch_mixed<T0>(&mut arg0.id, &mut v8, v1);
        arg0.inner_hash = v6;
        0x2::kiosk::lock<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>>(arg5, arg6, arg7, v8);
    }

    public fun mixing_price<T0>(arg0: &MixApp) : u64 {
        get_config<T0>(&arg0.id).mixing_price
    }

    public fun parents_selector_threshold<T0>(arg0: &MixApp) : vector<u8> {
        get_config<T0>(&arg0.id).parents_selector_threshold
    }

    public fun set_cooldown_period<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut MixApp, arg2: u64) {
        let v0 = &mut arg1.id;
        get_config_mut<T0>(v0).cool_down_period = arg2;
    }

    fun set_fren_mixing_limit_internal<T0>(arg0: &mut MixApp, arg1: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: u8) {
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs::mixing_limit<T0>(arg1);
        if (0x1::option::is_none<u8>(&v0)) {
            0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs::app_set_mixing_limit<T0>(&mut arg0.id, arg1, arg2 - 1);
        } else {
            let v1 = *0x1::option::borrow<u8>(&v0);
            assert!(v1 > 0, 1);
            0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs::app_set_mixing_limit<T0>(&mut arg0.id, arg1, v1 - 1);
        };
    }

    public fun set_mixing_limit<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut MixApp, arg2: u8) {
        let v0 = &mut arg1.id;
        get_config_mut<T0>(v0).mixing_limit = arg2;
    }

    public fun set_mixing_price<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut MixApp, arg2: u64) {
        let v0 = &mut arg1.id;
        get_config_mut<T0>(v0).mixing_price = arg2;
    }

    public fun set_parents_selector_threshold<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut MixApp, arg2: vector<u8>) {
        assert_selector_thresholds_validity(&arg2);
        let v0 = &mut arg1.id;
        get_config_mut<T0>(v0).parents_selector_threshold = arg2;
    }

    public fun take_profits(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut MixApp, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.profits, 0x2::balance::value<0x2::sui::SUI>(&arg1.profits), arg2)
    }

    // decompiled from Move bytecode v6
}

