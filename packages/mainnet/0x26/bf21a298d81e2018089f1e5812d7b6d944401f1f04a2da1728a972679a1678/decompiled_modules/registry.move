module 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProxyCap has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        allowed_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        keepers: 0x2::vec_set::VecSet<address>,
        max_price_delta_pips: u64,
        max_output_delta_pips: u64,
        fee_configs: vector<FeeConfig>,
        fee_wallet: address,
        lp_registries: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct FeeConfig has drop, store {
        fees_pips: vector<u64>,
        max_pool_fee_pips: u64,
    }

    fun type_name<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_original_ids<T0>()
    }

    public fun add_keeper(arg0: &mut Registry, arg1: address, arg2: &AdminCap) {
        0x2::vec_set::insert<address>(&mut arg0.keepers, arg1);
    }

    public fun assert_fee_wallet(arg0: &Registry, arg1: address) {
        assert!(arg0.fee_wallet == arg1, 5);
    }

    public fun assert_keeper(arg0: &Registry, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.keepers, &arg1), 6);
    }

    public fun assert_output(arg0: &Registry, arg1: u64, arg2: u64) {
        let v0 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        assert!(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::safe_math::mul_div_u64(v0, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips(), arg1) <= arg0.max_output_delta_pips, 4);
    }

    public fun assert_price(arg0: &Registry, arg1: u128, arg2: u128) {
        let v0 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        assert!((0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::safe_math::mul_div_u128(v0, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips_u128(), arg1) as u64) <= arg0.max_price_delta_pips, 3);
    }

    public(friend) fun assert_witness<T0>(arg0: &Registry) {
        assert!(arg0.version <= 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::current_version(), 0);
        let v0 = type_name<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_witnesses, &v0), 1);
    }

    public fun contains_keeper(arg0: &Registry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.keepers, &arg1)
    }

    public fun fee_pips(arg0: &Registry, arg1: u64, arg2: u64) : u64 {
        *0x1::vector::borrow<u64>(&find_fee_config(arg0, arg1).fees_pips, arg2)
    }

    fun find_fee_config(arg0: &Registry, arg1: u64) : &FeeConfig {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeConfig>(&arg0.fee_configs)) {
            let v1 = 0x1::vector::borrow<FeeConfig>(&arg0.fee_configs, v0);
            if (arg1 <= v1.max_pool_fee_pips) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id                    : 0x2::object::new(arg0),
            version               : 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::current_version(),
            allowed_witnesses     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            keepers               : 0x2::vec_set::empty<address>(),
            max_price_delta_pips  : 25000,
            max_output_delta_pips : 500,
            fee_configs           : 0x1::vector::empty<FeeConfig>(),
            fee_wallet            : 0x2::tx_context::sender(arg0),
            lp_registries         : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun insert_witness<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_witnesses, type_name<T0>());
    }

    public fun max_output_delta_pips(arg0: &Registry) : u64 {
        arg0.max_output_delta_pips
    }

    public fun max_price_delta_pips(arg0: &Registry) : u64 {
        arg0.max_price_delta_pips
    }

    public fun mint_proxy_cap<T0: drop>(arg0: &Registry, arg1: T0) : ProxyCap {
        assert_witness<T0>(arg0);
        ProxyCap{dummy_field: false}
    }

    public(friend) fun register_lp<T0: store + key>(arg0: &mut Registry, arg1: 0x2::object::ID) {
        let v0 = type_name<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.lp_registries, &v0), 7);
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.lp_registries, type_name<T0>(), arg1);
    }

    public fun remove_keeper(arg0: &mut Registry, arg1: address, arg2: &AdminCap) {
        0x2::vec_set::remove<address>(&mut arg0.keepers, &arg1);
    }

    public fun remove_witness<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        let v0 = type_name<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_witnesses, &v0);
    }

    public fun update_fee_configs(arg0: &mut Registry, arg1: vector<vector<u64>>, arg2: vector<u64>, arg3: &AdminCap) {
        let v0 = 0;
        let v1 = 0;
        arg0.fee_configs = 0x1::vector::empty<FeeConfig>();
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = 0x1::vector::borrow<vector<u64>>(&arg1, v1);
            let v3 = 0;
            let v4;
            while (v3 < 0x1::vector::length<u64>(v2)) {
                if (!(*0x1::vector::borrow<u64>(v2, v3) < 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips())) {
                    v4 = false;
                    /* label 9 */
                    assert!(v4, 2);
                    assert!(v0 < *0x1::vector::borrow<u64>(&arg2, v1) && *0x1::vector::borrow<u64>(&arg2, v1) < 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips(), 2);
                    v0 = *0x1::vector::borrow<u64>(&arg2, v1);
                    let v5 = FeeConfig{
                        fees_pips         : *0x1::vector::borrow<vector<u64>>(&arg1, v1),
                        max_pool_fee_pips : *0x1::vector::borrow<u64>(&arg2, v1),
                    };
                    0x1::vector::push_back<FeeConfig>(&mut arg0.fee_configs, v5);
                    v1 = v1 + 1;
                    /* goto 1 */
                    continue
                };
                v3 = v3 + 1;
            };
            v4 = true;
            /* goto 9 */
        };
    }

    public fun update_fee_wallet(arg0: &mut Registry, arg1: address, arg2: &AdminCap) {
        arg0.fee_wallet = arg1;
    }

    public fun update_max_output_delta_pips(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 < 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips(), 2);
        arg0.max_output_delta_pips = arg1;
    }

    public fun update_max_price_delta_pips(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 < 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips(), 2);
        arg0.max_price_delta_pips = arg1;
    }

    public fun update_version(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

