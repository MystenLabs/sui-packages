module 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::swap {
    public fun borrow_treasury_cap_by_admin<T0>(arg0: &0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::AdminCap, arg1: &mut 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord) : &0x2::coin::TreasuryCap<T0> {
        assert!(0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::exists_in_project<0x1::ascii::String>(arg1, 0x1::ascii::string(b"coin_type")), 103);
        0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::borrow_in_project<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(arg1, 0x1::ascii::string(b"treasury"))
    }

    public fun borrow_treasury_cap_by_project_admin<T0>(arg0: &mut 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord, arg1: &0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectAdminCap) : &0x2::coin::TreasuryCap<T0> {
        0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::check_project_cap(arg0, arg1);
        assert!(0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::exists_in_project<0x1::ascii::String>(arg0, 0x1::ascii::string(b"coin_type")), 103);
        0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::borrow_in_project<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(arg0, 0x1::ascii::string(b"treasury"))
    }

    public fun coin_to_sr<T0>(arg0: &mut 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward {
        assert!(0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::exists_in_project<0x1::ascii::String>(arg0, 0x1::ascii::string(b"coin_type")), 103);
        let v0 = 0x2::coin::burn<T0>(0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::borrow_mut_in_project<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(arg0, 0x1::ascii::string(b"treasury")), arg1);
        assert!(v0 > 0, 105);
        let v1 = 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::borrow_mut_in_project<0x1::ascii::String, vector<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>>(arg0, 0x1::ascii::string(b"storage_sr"));
        if (0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::sr_amount(0x1::vector::borrow<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>(v1, 0)) == v0) {
            0x1::vector::pop_back<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>(v1)
        } else {
            0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::do_split(0x1::vector::borrow_mut<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>(v1, 0), v0, arg2)
        }
    }

    public entry fun coin_to_sr_swap<T0>(arg0: &mut 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = coin_to_sr<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_coin_type(arg0: &0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord) : &0x1::ascii::String {
        0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::borrow_in_project<0x1::ascii::String, 0x1::ascii::String>(arg0, 0x1::ascii::string(b"coin_type"))
    }

    public fun get_total_supply<T0>(arg0: &0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord) : u64 {
        0x2::coin::total_supply<T0>(0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::borrow_in_project<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(arg0, 0x1::ascii::string(b"treasury")))
    }

    fun init_swap<T0>(arg0: &mut 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>) {
        assert!(!0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::exists_in_project<0x1::ascii::String>(arg0, 0x1::ascii::string(b"coin_type")), 100);
        assert!(0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::project_begin_status(arg0), 106);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 102);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 0, 101);
        0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::add_df_in_project<0x1::ascii::String, 0x1::ascii::String>(arg0, 0x1::ascii::string(b"coin_type"), 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()));
        0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::add_df_in_project<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(arg0, 0x1::ascii::string(b"treasury"), arg1);
        0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::add_df_in_project<0x1::ascii::String, vector<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>>(arg0, 0x1::ascii::string(b"storage_sr"), 0x1::vector::empty<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>());
    }

    public entry fun init_swap_by_admin<T0>(arg0: &0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::AdminCap, arg1: &mut 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>) {
        init_swap<T0>(arg1, arg2, arg3);
    }

    public entry fun init_swap_by_project_admin<T0>(arg0: &0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectAdminCap, arg1: &mut 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>) {
        0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::check_project_cap(arg1, arg0);
        init_swap<T0>(arg1, arg2, arg3);
    }

    public fun sr_to_coin<T0>(arg0: &mut 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord, arg1: 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::exists_in_project<0x1::ascii::String>(arg0, 0x1::ascii::string(b"coin_type")), 103);
        assert!(0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::project_name(arg0) == 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::sr_name(&arg1), 104);
        let v0 = 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::borrow_mut_in_project<0x1::ascii::String, vector<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>>(arg0, 0x1::ascii::string(b"storage_sr"));
        if (0x1::vector::is_empty<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>(v0)) {
            0x1::vector::push_back<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>(v0, arg1);
        } else {
            0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::do_merge(0x1::vector::borrow_mut<0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward>(v0, 0), arg1);
        };
        0x2::coin::mint<T0>(0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::borrow_mut_in_project<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(arg0, 0x1::ascii::string(b"treasury")), 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::sr_amount(&arg1), arg2)
    }

    public entry fun sr_to_coin_swap<T0>(arg0: &mut 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::ProjectRecord, arg1: 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::suifund::SupporterReward, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = sr_to_coin<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

