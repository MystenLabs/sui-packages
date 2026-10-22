module 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position {
    struct Position has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        position_mint: 0x2::object::ID,
        is_supply_only_position: bool,
        tick: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::Tick,
        tick_id: u32,
        supply_amount: u64,
        dust_debt_amount: u64,
    }

    struct PositionOwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: u64,
    }

    struct VaultExchangePrices has drop {
        supply_ex_price: u128,
        borrow_ex_price: u128,
        borrow_fee: u8,
    }

    struct AmountInfo has drop {
        new_col: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::ScaledAmount,
        new_debt: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::ScaledAmount,
        col_raw: u128,
        debt_raw: u128,
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (Position, PositionOwnerCap) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Position{
            id                      : 0x2::derived_object::claim<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::keys::PositionKey>(arg0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::keys::position_key(v1)),
            vault_id                : 0x2::object::uid_to_inner(arg0),
            position_mint           : v1,
            is_supply_only_position : true,
            tick                    : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::cold_tick(),
            tick_id                 : 0,
            supply_amount           : 0,
            dust_debt_amount        : 0,
        };
        let v3 = PositionOwnerCap{
            id       : v0,
            vault_id : arg1,
        };
        (v2, v3)
    }

    public fun share(arg0: Position) {
        0x2::transfer::share_object<Position>(arg0);
    }

    public(friend) fun delete(arg0: Position, arg1: PositionOwnerCap) : (0x2::object::ID, 0x2::object::ID) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.position_mint, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_invalid_position_mint());
        assert!(arg0.is_supply_only_position && arg0.supply_amount == 0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_position_not_empty());
        let Position {
            id                      : v0,
            vault_id                : _,
            position_mint           : _,
            is_supply_only_position : _,
            tick                    : _,
            tick_id                 : _,
            supply_amount           : _,
            dust_debt_amount        : _,
        } = arg0;
        let v8 = v0;
        0x2::object::delete(v8);
        let PositionOwnerCap {
            id       : v9,
            vault_id : _,
        } = arg1;
        let v11 = v9;
        0x2::object::delete(v11);
        (0x2::object::uid_to_inner(&v8), 0x2::object::uid_to_inner(&v11))
    }

    public(friend) fun assert_authorized(arg0: &Position, arg1: &0x1::option::Option<PositionOwnerCap>) {
        assert!(0x1::option::is_some<PositionOwnerCap>(arg1), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_invalid_position_authority());
        assert!(0x2::object::uid_to_inner(&0x1::option::borrow<PositionOwnerCap>(arg1).id) == arg0.position_mint, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_invalid_position_mint());
    }

    public(friend) fun assert_belongs_to(arg0: &Position, arg1: 0x2::object::ID) {
        assert!(arg0.vault_id == arg1, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_invalid_vault_id());
    }

    public fun cap_id(arg0: &PositionOwnerCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun cap_vault_id(arg0: &PositionOwnerCap) : u64 {
        arg0.vault_id
    }

    public fun create_display(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg2: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg3: &mut 0x2::display_registry::DisplayRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_authority(arg0, arg1, arg2, arg4);
        let (v0, v1) = 0x2::display_registry::new<PositionOwnerCap>(arg3, 0x1::internal::permit<PositionOwnerCap>(), arg4);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<PositionOwnerCap>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Fluid vault {vault_id}"));
        0x2::display_registry::set<PositionOwnerCap>(&mut v3, &v2, 0x1::string::utf8(b"symbol"), 0x1::string::utf8(b"f{vault_id}"));
        0x2::display_registry::set<PositionOwnerCap>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Ownership NFT for a Fluid vault position"));
        0x2::display_registry::set<PositionOwnerCap>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://cdn.instadapp.io/sui/vaults/{vault_id}.png"));
        0x2::display_registry::share<PositionOwnerCap>(v3);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::store_display_cap<PositionOwnerCap>(arg1, v2);
    }

    public fun get_dust_debt_amount(arg0: &Position) : u128 {
        (arg0.dust_debt_amount as u128)
    }

    public(friend) fun get_new_position_info(arg0: AmountInfo, arg1: VaultExchangePrices) : (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::ScaledAmount, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::ScaledAmount, u128, u128) {
        let v0 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::exchange_prices_precision();
        let v1 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::max_u64();
        let v2 = if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_scaled_is_positive(&arg0.new_col)) {
            arg0.col_raw = arg0.col_raw + 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_value(&arg0.new_col), v0, arg1.supply_ex_price);
            assert!(arg0.col_raw <= v1, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_user_collateral_debt_exceed());
            arg0.new_col
        } else if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_scaled_is_max(&arg0.new_col)) {
            let v3 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(arg0.col_raw, arg1.supply_ex_price, v0);
            arg0.col_raw = 0;
            if (v3 <= 1) {
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_none()
            } else {
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_negative(v3 - 1)
            }
        } else if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_scaled_is_negative(&arg0.new_col)) {
            let v4 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil_u128(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_value(&arg0.new_col), v0, arg1.supply_ex_price);
            assert!(v4 <= arg0.col_raw, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_excess_collateral_withdrawal());
            arg0.col_raw = arg0.col_raw - v4;
            arg0.new_col
        } else {
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_none()
        };
        let v5 = if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_scaled_is_positive(&arg0.new_debt)) {
            let v6 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil_u128(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_value(&arg0.new_debt), v0, arg1.borrow_ex_price);
            arg0.debt_raw = arg0.debt_raw + v6 + 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil_u128(v6, (arg1.borrow_fee as u128), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::borrow_fee_precision());
            assert!(arg0.debt_raw <= v1, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_user_collateral_debt_exceed());
            arg0.new_debt
        } else if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_scaled_is_max(&arg0.new_debt)) {
            arg0.debt_raw = 0;
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_negative(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil_u128(arg0.debt_raw, arg1.borrow_ex_price, v0))
        } else if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_scaled_is_negative(&arg0.new_debt)) {
            let v7 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_value(&arg0.new_debt), v0, arg1.borrow_ex_price);
            assert!(v7 >= 1, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::overflow());
            let v8 = v7 - 1;
            assert!(v8 <= arg0.debt_raw, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_excess_debt_payback());
            arg0.debt_raw = arg0.debt_raw - v8;
            arg0.new_debt
        } else {
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_none()
        };
        (v2, v5, arg0.col_raw, arg0.debt_raw)
    }

    public fun get_position_info(arg0: &Position) : (u128, u128, u128, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::Tick, u32) {
        let v0 = get_supply_amount(arg0);
        let (v1, v2) = if (arg0.is_supply_only_position) {
            (0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::cold_tick(), 0)
        } else {
            (arg0.tick, arg0.tick_id)
        };
        let v3 = if (0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::gt(v1, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::cold_tick())) {
            (0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::get_ratio_at_tick(v1) * (v0 + 1) >> 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::shift()) + 1
        } else {
            0
        };
        (v0, get_dust_debt_amount(arg0), v3, v1, v2)
    }

    public fun get_supply_amount(arg0: &Position) : u128 {
        (arg0.supply_amount as u128)
    }

    public fun is_supply_only_position(arg0: &Position) : bool {
        arg0.is_supply_only_position
    }

    public(friend) fun new_amount_info(arg0: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::ScaledAmount, arg1: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::ScaledAmount, arg2: u128, arg3: u128) : AmountInfo {
        AmountInfo{
            new_col  : arg0,
            new_debt : arg1,
            col_raw  : arg2,
            debt_raw : arg3,
        }
    }

    public fun new_vault_exchange_prices(arg0: u128, arg1: u128, arg2: u8) : VaultExchangePrices {
        VaultExchangePrices{
            supply_ex_price : arg0,
            borrow_ex_price : arg1,
            borrow_fee      : arg2,
        }
    }

    public fun nft_id(arg0: &Position) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun position_mint(arg0: &Position) : 0x2::object::ID {
        arg0.position_mint
    }

    public(friend) fun set_dust_debt_amount(arg0: &mut Position, arg1: u128) {
        assert!(arg1 <= 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::max_u64(), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::overflow());
        arg0.dust_debt_amount = (arg1 as u64);
    }

    public(friend) fun set_is_supply_only_position(arg0: &mut Position, arg1: bool) {
        arg0.is_supply_only_position = arg1;
    }

    public(friend) fun set_supply_amount(arg0: &mut Position, arg1: u128) {
        assert!(arg1 <= 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::max_u64(), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::overflow());
        arg0.supply_amount = (arg1 as u64);
    }

    public fun tick(arg0: &Position) : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::Tick {
        arg0.tick
    }

    public fun tick_id(arg0: &Position) : u32 {
        arg0.tick_id
    }

    public(friend) fun update_position_after_operate(arg0: &mut Position, arg1: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::Tick, arg2: u32, arg3: u128, arg4: u128) {
        if (arg1 == 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::cold_tick()) {
            set_is_supply_only_position(arg0, true);
        } else {
            set_is_supply_only_position(arg0, false);
        };
        arg0.tick = arg1;
        arg0.tick_id = arg2;
        set_supply_amount(arg0, arg3);
        set_dust_debt_amount(arg0, arg4);
    }

    public fun vault_id(arg0: &Position) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

