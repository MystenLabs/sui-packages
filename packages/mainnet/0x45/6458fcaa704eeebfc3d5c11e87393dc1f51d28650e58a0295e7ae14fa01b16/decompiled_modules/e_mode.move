module 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode {
    struct EModeCategoryKey has copy, drop, store {
        id: u8,
    }

    struct EModeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct EModeCategory has copy, drop, store {
        collateral_factor: 0x1::fixed_point32::FixedPoint32,
        liquidation_factor: 0x1::fixed_point32::FixedPoint32,
        liquidation_penalty: 0x1::fixed_point32::FixedPoint32,
        liquidation_discount: 0x1::fixed_point32::FixedPoint32,
        liquidation_revenue_factor: 0x1::fixed_point32::FixedPoint32,
        collateral_assets: vector<0x1::type_name::TypeName>,
        borrow_assets: vector<0x1::type_name::TypeName>,
    }

    public(friend) fun add_borrow_asset(arg0: &mut EModeCategory, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.borrow_assets, &arg1), arg2);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.borrow_assets) < 20, arg3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.borrow_assets, arg1);
    }

    public(friend) fun add_collateral_asset(arg0: &mut EModeCategory, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.collateral_assets, &arg1), arg2);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.collateral_assets) < 20, arg3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.collateral_assets, arg1);
    }

    public fun borrow_assets(arg0: &EModeCategory) : &vector<0x1::type_name::TypeName> {
        &arg0.borrow_assets
    }

    public fun category_key(arg0: u8) : EModeCategoryKey {
        EModeCategoryKey{id: arg0}
    }

    public fun collateral_assets(arg0: &EModeCategory) : &vector<0x1::type_name::TypeName> {
        &arg0.collateral_assets
    }

    public fun collateral_factor(arg0: &EModeCategory) : 0x1::fixed_point32::FixedPoint32 {
        arg0.collateral_factor
    }

    public fun e_mode_key() : EModeKey {
        EModeKey{dummy_field: false}
    }

    public fun get_category(arg0: &0x2::object::UID, arg1: u8) : &EModeCategory {
        let v0 = EModeCategoryKey{id: arg1};
        0x2::dynamic_field::borrow<EModeCategoryKey, EModeCategory>(arg0, v0)
    }

    public fun has_category(arg0: &0x2::object::UID, arg1: u8) : bool {
        let v0 = EModeCategoryKey{id: arg1};
        0x2::dynamic_field::exists_with_type<EModeCategoryKey, EModeCategory>(arg0, v0)
    }

    public fun is_borrow_in_category(arg0: &EModeCategory, arg1: 0x1::type_name::TypeName) : bool {
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.borrow_assets, &arg1)
    }

    public fun is_collateral_in_category(arg0: &EModeCategory, arg1: 0x1::type_name::TypeName) : bool {
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.collateral_assets, &arg1)
    }

    public fun liq_discount(arg0: &EModeCategory) : 0x1::fixed_point32::FixedPoint32 {
        arg0.liquidation_discount
    }

    public fun liq_penalty(arg0: &EModeCategory) : 0x1::fixed_point32::FixedPoint32 {
        arg0.liquidation_penalty
    }

    public fun liq_revenue_factor(arg0: &EModeCategory) : 0x1::fixed_point32::FixedPoint32 {
        arg0.liquidation_revenue_factor
    }

    public fun liquidation_factor(arg0: &EModeCategory) : 0x1::fixed_point32::FixedPoint32 {
        arg0.liquidation_factor
    }

    public fun max_assets_per_list() : u64 {
        20
    }

    public fun new_category(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32, arg2: 0x1::fixed_point32::FixedPoint32, arg3: 0x1::fixed_point32::FixedPoint32, arg4: 0x1::fixed_point32::FixedPoint32) : EModeCategory {
        EModeCategory{
            collateral_factor          : arg0,
            liquidation_factor         : arg1,
            liquidation_penalty        : arg2,
            liquidation_discount       : arg3,
            liquidation_revenue_factor : arg4,
            collateral_assets          : 0x1::vector::empty<0x1::type_name::TypeName>(),
            borrow_assets              : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun remove_borrow_asset(arg0: &mut EModeCategory, arg1: 0x1::type_name::TypeName) : bool {
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.borrow_assets, &arg1);
        if (v0) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.borrow_assets, v1);
        };
        v0
    }

    public(friend) fun remove_collateral_asset(arg0: &mut EModeCategory, arg1: 0x1::type_name::TypeName) : bool {
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.collateral_assets, &arg1);
        if (v0) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.collateral_assets, v1);
        };
        v0
    }

    public fun reserved_category_id() : u8 {
        0
    }

    public(friend) fun update_risk_params(arg0: &mut EModeCategory, arg1: 0x1::fixed_point32::FixedPoint32, arg2: 0x1::fixed_point32::FixedPoint32, arg3: 0x1::fixed_point32::FixedPoint32, arg4: 0x1::fixed_point32::FixedPoint32, arg5: 0x1::fixed_point32::FixedPoint32) {
        arg0.collateral_factor = arg1;
        arg0.liquidation_factor = arg2;
        arg0.liquidation_penalty = arg3;
        arg0.liquidation_discount = arg4;
        arg0.liquidation_revenue_factor = arg5;
    }

    // decompiled from Move bytecode v7
}

