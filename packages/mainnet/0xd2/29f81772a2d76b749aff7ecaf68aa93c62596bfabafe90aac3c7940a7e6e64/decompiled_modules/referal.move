module 0xd229f81772a2d76b749aff7ecaf68aa93c62596bfabafe90aac3c7940a7e6e64::referal {
    struct REFERAL has drop {
        dummy_field: bool,
    }

    struct AdminCapability has store, key {
        id: 0x2::object::UID,
    }

    struct ReferalConfig has store, key {
        id: 0x2::object::UID,
        admin_public_key: vector<u8>,
        vault: 0x2::bag::Bag,
        bonus: 0x2::table::Table<address, 0x2::table::Table<u64, u64>>,
        total_bonus_claimed: u64,
    }

    public fun claim_bonus<T0>(arg0: &mut ReferalConfig, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &arg0.admin_public_key, &arg2) == true, 4);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v1, 0x1::u64::to_string(arg1));
        0x1::string::append(&mut v1, 0x2::address::to_string(v0));
        assert!(0x1::string::utf8(arg2) == v1, 6);
        referal_check_exist_address<T0>(arg0, arg4);
        let v2 = 0x2::table::borrow_mut<u64, u64>(0x2::table::borrow_mut<address, 0x2::table::Table<u64, u64>>(&mut arg0.bonus, v0), hash_type_to_u64<T0>());
        assert!(*v2 < arg1, 7);
        *v2 = arg1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T0>>(&mut arg0.vault, hash_type_to_u64<T0>()), arg1 - *v2), arg4)
    }

    public fun deposit<T0>(arg0: &mut ReferalConfig, arg1: 0x2::coin::Coin<T0>) {
        vault_check_exist_coin<T0>(arg0);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T0>>(&mut arg0.vault, hash_type_to_u64<T0>()), 0x2::coin::into_balance<T0>(arg1));
    }

    public fun hash_type_to_u64<T0>() : u64 {
        let v0 = 0x2::bcs::new(0x1::hash::sha3_256(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))));
        0x2::bcs::peel_u64(&mut v0)
    }

    fun init(arg0: REFERAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_referal_config(arg0: &AdminCapability, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferalConfig{
            id                  : 0x2::object::new(arg2),
            admin_public_key    : arg1,
            vault               : 0x2::bag::new(arg2),
            bonus               : 0x2::table::new<address, 0x2::table::Table<u64, u64>>(arg2),
            total_bonus_claimed : 0,
        };
        0x2::transfer::share_object<ReferalConfig>(v0);
    }

    public fun referal_check_exist_address<T0>(arg0: &mut ReferalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = hash_type_to_u64<T0>();
        if (0x2::table::contains<address, 0x2::table::Table<u64, u64>>(&arg0.bonus, v0)) {
            let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, u64>>(&mut arg0.bonus, v0);
            if (0x2::table::contains<u64, u64>(v2, v1)) {
                return
            };
            0x2::table::add<u64, u64>(v2, v1, 0);
        };
        0x2::table::add<address, 0x2::table::Table<u64, u64>>(&mut arg0.bonus, v0, 0x2::table::new<u64, u64>(arg1));
        0x2::table::add<u64, u64>(0x2::table::borrow_mut<address, 0x2::table::Table<u64, u64>>(&mut arg0.bonus, v0), v1, 0);
    }

    public fun vault_check_exist_coin<T0>(arg0: &mut ReferalConfig) {
        if (0x2::bag::contains_with_type<u64, 0x2::balance::Balance<T0>>(&arg0.vault, hash_type_to_u64<T0>())) {
            return
        };
        0x2::bag::add<u64, 0x2::balance::Balance<T0>>(&mut arg0.vault, hash_type_to_u64<T0>(), 0x2::balance::zero<T0>());
    }

    public fun withdraw<T0>(arg0: &AdminCapability, arg1: &mut ReferalConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::bag::remove<u64, 0x2::balance::Balance<T0>>(&mut arg1.vault, hash_type_to_u64<T0>()), arg2)
    }

    // decompiled from Move bytecode v6
}

