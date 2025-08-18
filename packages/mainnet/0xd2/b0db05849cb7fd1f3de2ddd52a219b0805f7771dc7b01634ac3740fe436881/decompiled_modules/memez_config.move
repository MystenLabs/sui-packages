module 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config {
    struct FeesKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct QuoteListKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MigratorWitnessKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MemeReferrerFeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct QuoteReferrerFeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PublicKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MemezConfig has key {
        id: 0x2::object::UID,
    }

    fun add<T0, T1: drop + store>(arg0: &mut MemezConfig, arg1: T1) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::dynamic_field::remove_if_exists<0x1::type_name::TypeName, T1>(&mut arg0.id, v0);
        0x2::dynamic_field::add<0x1::type_name::TypeName, T1>(&mut arg0.id, v0, arg1);
    }

    public fun remove<T0, T1: drop + store>(arg0: &mut MemezConfig, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_field::remove_if_exists<0x1::type_name::TypeName, T1>(&mut arg0.id, 0x1::type_name::get<T0>());
    }

    public fun add_migrator_witness<T0, T1>(arg0: &mut MemezConfig, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MigratorWitnessKey<T0>{dummy_field: false};
        add_to_set<T1, MigratorWitnessKey<T0>>(arg0, v0);
    }

    public fun add_quote_coin<T0, T1>(arg0: &mut MemezConfig, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = QuoteListKey<T0>{dummy_field: false};
        add_to_set<T1, QuoteListKey<T0>>(arg0, v0);
    }

    fun add_to_set<T0, T1: copy + drop + store>(arg0: &mut MemezConfig, arg1: T1) {
        if (0x2::dynamic_field::exists_<T1>(&arg0.id, arg1)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::dynamic_field::borrow_mut<T1, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, arg1), 0x1::type_name::get<T0>());
        } else {
            0x2::dynamic_field::add<T1, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, arg1, 0x2::vec_set::singleton<0x1::type_name::TypeName>(0x1::type_name::get<T0>()));
        };
    }

    public(friend) fun assert_migrator_witness<T0, T1>(arg0: &MemezConfig) {
        let v0 = MigratorWitnessKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<MigratorWitnessKey<T0>>(&arg0.id, v0), 17);
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::dynamic_field::borrow<MigratorWitnessKey<T0>, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.id, v0), &v1), 26);
    }

    public(friend) fun assert_quote_coin<T0, T1>(arg0: &MemezConfig) {
        let v0 = QuoteListKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<QuoteListKey<T0>>(&arg0.id, v0), 17);
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::dynamic_field::borrow<QuoteListKey<T0>, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.id, v0), &v1), 25);
    }

    public(friend) fun fees<T0>(arg0: &MemezConfig) : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::MemezFees {
        let v0 = 0x1::type_name::get<FeesKey<T0>>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 17);
        *0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::MemezFees>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MemezConfig{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MemezConfig>(v0);
    }

    public(friend) fun meme_referrer_fee<T0>(arg0: &MemezConfig) : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS {
        let v0 = 0x1::type_name::get<MemeReferrerFeeKey<T0>>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            return 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(0)
        };
        *0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS>(&arg0.id, v0)
    }

    public(friend) fun public_key<T0>(arg0: &MemezConfig) : vector<u8> {
        let v0 = 0x1::type_name::get<PublicKey<T0>>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 17);
        *0x2::dynamic_field::borrow<0x1::type_name::TypeName, vector<u8>>(&arg0.id, v0)
    }

    public(friend) fun quote_referrer_fee<T0>(arg0: &MemezConfig) : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS {
        let v0 = 0x1::type_name::get<QuoteReferrerFeeKey<T0>>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            return 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(0)
        };
        *0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS>(&arg0.id, v0)
    }

    fun remove_from_set<T0, T1: copy + drop + store>(arg0: &mut MemezConfig, arg1: T1) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_<T1>(&arg0.id, arg1)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<T1, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, arg1);
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(v1, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(v1, &v0);
        };
    }

    public fun remove_migrator_witness<T0, T1>(arg0: &mut MemezConfig, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MigratorWitnessKey<T0>{dummy_field: false};
        remove_from_set<T1, MigratorWitnessKey<T0>>(arg0, v0);
    }

    public fun remove_quote_coin<T0, T1>(arg0: &mut MemezConfig, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = QuoteListKey<T0>{dummy_field: false};
        remove_from_set<T1, QuoteListKey<T0>>(arg0, v0);
    }

    public fun set_fees<T0>(arg0: &mut MemezConfig, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: vector<vector<u64>>, arg3: vector<vector<address>>, arg4: &mut 0x2::tx_context::TxContext) {
        add<FeesKey<T0>, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::MemezFees>(arg0, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::new(arg2, arg3));
    }

    public fun set_meme_referrer_fee<T0>(arg0: &mut MemezConfig, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        add<MemeReferrerFeeKey<T0>, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS>(arg0, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(arg2));
    }

    public fun set_public_key<T0>(arg0: &mut MemezConfig, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        add<PublicKey<T0>, vector<u8>>(arg0, arg2);
    }

    public fun set_quote_referrer_fee<T0>(arg0: &mut MemezConfig, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        add<QuoteReferrerFeeKey<T0>, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS>(arg0, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(arg2));
    }

    // decompiled from Move bytecode v6
}

