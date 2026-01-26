module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account {
    struct TradeFee has copy, drop, store {
        maker: u64,
        taker: u64,
        applied: bool,
    }

    struct Account has store {
        address: address,
        authorized: vector<address>,
        assets: vector<DepositedAsset>,
        cross_positions: vector<Position>,
        isolated_positions: vector<Position>,
        trading_fees: TradeFee,
        is_institution: bool,
        fee_asset: 0x1::string::String,
    }

    struct Position has copy, drop, store {
        perpetual: 0x1::string::String,
        size: u64,
        average_entry_price: u64,
        is_long: bool,
        leverage: u64,
        margin: u64,
        is_isolated: bool,
        funding: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::FundingRate,
        pending_funding_payment: u64,
    }

    struct DepositedAsset has copy, drop, store {
        name: 0x1::string::String,
        quantity: u64,
    }

    struct FundingApplied has copy, drop, store {
        position: Position,
        assets: vector<DepositedAsset>,
        funding_rate: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::FundingRate,
        funding_amount: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number,
    }

    public(friend) fun add_margin(arg0: &mut Account, arg1: 0x1::string::String, arg2: u64) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<DepositedAsset>(&arg0.assets) && !v1) {
            let v2 = 0x1::vector::borrow_mut<DepositedAsset>(&mut arg0.assets, v0);
            if (v2.name == arg1) {
                v2.quantity = v2.quantity + arg2;
                v1 = true;
            };
            v0 = v0 + 1;
        };
        if (!v1) {
            let v3 = DepositedAsset{
                name     : arg1,
                quantity : arg2,
            };
            0x1::vector::push_back<DepositedAsset>(&mut arg0.assets, v3);
        };
    }

    public(friend) fun add_margin_to_asset_vector(arg0: &mut vector<DepositedAsset>, arg1: u64, arg2: 0x1::string::String) {
        if (!0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::is_empty_string(arg2)) {
            let v0 = 0;
            let v1 = false;
            while (v0 < 0x1::vector::length<DepositedAsset>(arg0) && !v1) {
                let v2 = 0x1::vector::borrow_mut<DepositedAsset>(arg0, v0);
                if (v2.name == arg2) {
                    v2.quantity = v2.quantity + arg1;
                    v1 = true;
                };
                v0 = v0 + 1;
            };
            if (!v1) {
                let v3 = DepositedAsset{
                    name     : arg2,
                    quantity : arg1,
                };
                0x1::vector::push_back<DepositedAsset>(arg0, v3);
            };
        } else {
            let v4 = 0x1::vector::borrow_mut<DepositedAsset>(arg0, 0);
            v4.quantity = v4.quantity + arg1;
        };
    }

    public(friend) fun apply_funding_rate(arg0: &mut Account, arg1: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg2: 0x1::option::Option<0x1::string::String>) : vector<FundingApplied> {
        let v0 = apply_funding_rate_to_positions(arg0, arg1, arg2, true);
        0x1::vector::append<FundingApplied>(&mut v0, apply_funding_rate_to_positions(arg0, arg1, arg2, false));
        v0
    }

    fun apply_funding_rate_to_positions(arg0: &mut Account, arg1: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg2: 0x1::option::Option<0x1::string::String>, arg3: bool) : vector<FundingApplied> {
        let v0 = 0x1::vector::empty<FundingApplied>();
        let v1 = if (arg3) {
            &mut arg0.isolated_positions
        } else {
            &mut arg0.cross_positions
        };
        let v2 = v1;
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            let (v3, v4) = has_open_position(v1, *0x1::option::borrow<0x1::string::String>(&arg2));
            if (!v3) {
                return v0
            };
            let v5 = 0x1::vector::empty<Position>();
            let v6 = &mut v5;
            v2 = v6;
            0x1::vector::push_back<Position>(v6, 0x1::vector::remove<Position>(v1, v4));
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<Position>(v2)) {
            let v8 = 0x1::vector::borrow_mut<Position>(v2, v7);
            v7 = v7 + 1;
            let v9 = 0x2::table::borrow<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>(arg1, v8.perpetual);
            let v10 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_current_funding(v9);
            if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_funding_timestamp(&v8.funding) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_funding_timestamp(&v10)) {
                continue
            };
            let v11 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_funding_rate(&v10);
            let v12 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v8.size, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(v9)), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::value(v11));
            let v13 = if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sign(v11) == v8.is_long) {
                if (v12 > 0) {
                    0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(v12, false)
                } else {
                    0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(0, true)
                }
            } else {
                0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(v12, true)
            };
            if (arg3) {
                if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sign(v13)) {
                    v8.margin = v8.margin + v12;
                } else if (v12 <= v8.margin) {
                    v8.margin = v8.margin - v12;
                } else {
                    v8.margin = 0;
                    v8.pending_funding_payment = v8.pending_funding_payment + v12 - v8.margin;
                };
            } else if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sign(v13)) {
                let v14 = &mut arg0.assets;
                add_margin_to_asset_vector(v14, v12, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::usdc_token_symbol());
            } else {
                let v15 = &mut arg0.assets;
                let (v16, v17) = try_sub_margin(v15, v12);
                if (v16) {
                    v8.pending_funding_payment = v8.pending_funding_payment + v17;
                };
            };
            v8.funding = v10;
            let v18 = FundingApplied{
                position       : *v8,
                assets         : arg0.assets,
                funding_rate   : v10,
                funding_amount : v13,
            };
            0x1::vector::push_back<FundingApplied>(&mut v0, v18);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            let v19 = if (arg3) {
                &mut arg0.isolated_positions
            } else {
                &mut arg0.cross_positions
            };
            0x1::vector::push_back<Position>(v19, 0x1::vector::pop_back<Position>(v2));
        };
        v0
    }

    fun asset_to_usd(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(arg0, arg1), arg2)
    }

    public fun calculate_effective_leverage(arg0: &Position, arg1: 0x1::option::Option<u64>) : u64 {
        if (arg0.is_isolated) {
            if (arg0.size > 0 && arg0.margin > 0) {
                0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::mul_div_uint(arg0.average_entry_price, arg0.size, arg0.margin - arg0.pending_funding_payment)
            } else if (0x1::option::is_some<u64>(&arg1)) {
                *0x1::option::borrow<u64>(&arg1)
            } else {
                arg0.leverage
            }
        } else {
            0
        }
    }

    public fun compute_position_pnl(arg0: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg1: &Position) : 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number {
        if (arg1.is_long) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::mul_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from_subtraction(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(0x2::table::borrow<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>(arg0, arg1.perpetual)), arg1.average_entry_price), arg1.size)
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::negate(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::mul_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from_subtraction(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(0x2::table::borrow<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>(arg0, arg1.perpetual)), arg1.average_entry_price), arg1.size))
        }
    }

    public fun create_deposited_asset(arg0: 0x1::string::String, arg1: u64) : DepositedAsset {
        DepositedAsset{
            name     : arg0,
            quantity : arg1,
        }
    }

    public(friend) fun create_empty_position(arg0: 0x1::string::String, arg1: bool) : Position {
        create_position(arg0, 0, 0, 0, 0, true, arg1)
    }

    public(friend) fun create_position(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool) : Position {
        Position{
            perpetual               : arg0,
            size                    : arg1,
            average_entry_price     : arg2,
            is_long                 : arg5,
            leverage                : arg3,
            margin                  : arg4,
            is_isolated             : arg6,
            funding                 : 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::create_funding_rate(0, 0, true),
            pending_funding_payment : 0,
        }
    }

    public fun dec_funding_applied(arg0: &FundingApplied) : (Position, vector<DepositedAsset>, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::FundingRate, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number) {
        (arg0.position, arg0.assets, arg0.funding_rate, arg0.funding_amount)
    }

    public fun get_account_position(arg0: &Account, arg1: 0x1::string::String, arg2: bool) : Position {
        let v0 = if (arg2) {
            arg0.isolated_positions
        } else {
            arg0.cross_positions
        };
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Position>(&v1)) {
            let v3 = 0x1::vector::borrow<Position>(&v1, v2);
            if (v3.perpetual == arg1) {
                return *v3
            };
            v2 = v2 + 1;
        };
        abort 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::position_does_not_exist()
    }

    public fun get_account_type(arg0: &Account) : bool {
        arg0.is_institution
    }

    public(friend) fun get_account_value(arg0: &vector<DepositedAsset>, arg1: &vector<Position>, arg2: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg3: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset>) : 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number {
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::add_uint(get_unrealized_pnl(arg1, arg2), get_total_effective_balance(arg0, arg3)), get_pending_funding_payment(arg1))
    }

    public fun get_account_value_and_health(arg0: &Account, arg1: 0x1::string::String, arg2: bool, arg3: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg4: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset>, arg5: u8) : (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number) {
        let v0 = if (arg2) {
            arg1
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string()
        };
        let v1 = get_positions_vector(arg0, v0);
        let v2 = get_assets_vector(arg0, v0);
        let v3 = get_account_value(&v2, &v1, arg3, arg4);
        (v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub_uint(v3, get_total_margin_required(&v1, arg3, arg5)))
    }

    public(friend) fun get_asset_quantity(arg0: &vector<DepositedAsset>, arg1: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<DepositedAsset>(arg0)) {
            let v2 = 0x1::vector::borrow<DepositedAsset>(arg0, v0);
            if (v2.name == 0x1::string::utf8(arg1)) {
                v1 = v2.quantity;
                break
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_assets(arg0: &Account) : vector<DepositedAsset> {
        arg0.assets
    }

    public(friend) fun get_assets_vector(arg0: &Account, arg1: 0x1::string::String) : vector<DepositedAsset> {
        if (arg1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string()) {
            return arg0.assets
        };
        let v0 = 0x1::vector::empty<DepositedAsset>();
        let v1 = 0;
        let (v2, v3) = has_open_position(&arg0.isolated_positions, arg1);
        if (v2) {
            v1 = 0x1::vector::borrow<Position>(&arg0.isolated_positions, v3).margin;
        };
        let v4 = DepositedAsset{
            name     : 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::usdc_token_symbol(),
            quantity : v1,
        };
        0x1::vector::push_back<DepositedAsset>(&mut v0, v4);
        v0
    }

    public fun get_authorized_accounts(arg0: &Account) : vector<address> {
        arg0.authorized
    }

    public fun get_cross_positions(arg0: &Account) : vector<Position> {
        arg0.cross_positions
    }

    public fun get_fee_asset(arg0: &Account) : 0x1::string::String {
        arg0.fee_asset
    }

    public fun get_fees(arg0: &Account) : (u64, u64, bool) {
        (arg0.trading_fees.maker, arg0.trading_fees.taker, arg0.trading_fees.applied)
    }

    public fun get_immutable_position_for_perpetual(arg0: &vector<Position>, arg1: 0x1::string::String) : &Position {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Position>(arg0)) {
            let v1 = 0x1::vector::borrow<Position>(arg0, v0);
            if (v1.perpetual == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::position_does_not_exist()
    }

    public fun get_isolated_positions(arg0: &Account) : vector<Position> {
        arg0.isolated_positions
    }

    public(friend) fun get_max_withdrawable_amount(arg0: &vector<DepositedAsset>, arg1: &vector<Position>, arg2: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg3: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset>) : u64 {
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::positive_value(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(get_total_effective_balance(arg0, arg3), true), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::negative_value(get_unrealized_pnl(arg1, arg2))), get_pending_funding_payment(arg1)), get_total_margin_required(arg1, arg2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::imr_threshold())))
    }

    public(friend) fun get_mutable_position_for_perpetual(arg0: &mut vector<Position>, arg1: 0x1::string::String, arg2: bool) : (&mut Position, u64) {
        let v0 = 0x1::vector::length<Position>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow_mut<Position>(arg0, v1);
            if (v2.perpetual == arg1) {
                return (v2, v1)
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<Position>(arg0, create_empty_position(arg1, arg2));
        (0x1::vector::borrow_mut<Position>(arg0, v0), v0)
    }

    public(friend) fun get_pending_funding_payment(arg0: &vector<Position>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<Position>(arg0)) {
            v1 = v1 + 0x1::vector::borrow<Position>(arg0, v0).pending_funding_payment;
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun get_position(arg0: &Account, arg1: 0x1::string::String, arg2: bool) : Position {
        let v0 = if (arg2) {
            arg0.isolated_positions
        } else {
            arg0.cross_positions
        };
        let v1 = v0;
        let (v2, v3) = has_open_position(&v1, arg1);
        if (v2) {
            *0x1::vector::borrow<Position>(&v1, v3)
        } else {
            create_empty_position(arg1, arg2)
        }
    }

    public fun get_position_bankruptcy_and_purchase_price(arg0: &Account, arg1: 0x1::string::String, arg2: bool, arg3: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg4: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset>) : (u64, u64, u64, bool, bool) {
        let v0 = if (arg2) {
            arg1
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string()
        };
        let v1 = get_positions_vector(arg0, v0);
        let v2 = get_assets_vector(arg0, v0);
        let v3 = get_account_value(&v2, &v1, arg3, arg4);
        let v4 = 0x2::table::borrow<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>(arg3, arg1);
        let v5 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(v4);
        let v6 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_tick_size(v4);
        let (_, v8, _, v10, _, _, _, _) = get_position_values(get_immutable_position_for_perpetual(&v1, arg1));
        let v15 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::div_uint(v3, v8);
        let v16 = v15;
        if (!v10) {
            v16 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::negate(v15);
        };
        let v17 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(v5, true), v16);
        let v18 = if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::gte_uint(v17, 0)) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::value(v17)
        } else {
            0
        };
        let v19 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::round_to_tick_size_based_on_direction(v18, v6, v10);
        let (v20, v21) = if (v10 && v19 > v5 || !v10 && v19 < v5) {
            (v5, true)
        } else {
            let v22 = if (v10) {
                0x1::u64::max(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint() - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_mmr(v4) / 2), v19)
            } else {
                0x1::u64::min(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint() + 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_mmr(v4) / 2), v19)
            };
            (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::round_to_tick_size_based_on_direction(v22, v6, v10), false)
        };
        (v19, v20, v5, v21, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::lt_uint(v3, 0))
    }

    public fun get_position_values(arg0: &Position) : (0x1::string::String, u64, u64, bool, u64, u64, bool, u64) {
        (arg0.perpetual, arg0.size, arg0.average_entry_price, arg0.is_long, arg0.leverage, arg0.margin, arg0.is_isolated, arg0.pending_funding_payment)
    }

    public fun get_position_values_including_funding(arg0: &Position) : (0x1::string::String, u64, u64, bool, u64, u64, bool, u64, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::FundingRate) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = get_position_values(arg0);
        (v0, v1, v2, v3, v4, v5, v6, v7, arg0.funding)
    }

    public(friend) fun get_positions_vector(arg0: &Account, arg1: 0x1::string::String) : vector<Position> {
        if (arg1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string()) {
            arg0.cross_positions
        } else {
            let v1 = create_empty_position(arg1, true);
            let (v2, v3) = has_open_position(&arg0.isolated_positions, arg1);
            if (v2) {
                v1 = *0x1::vector::borrow<Position>(&arg0.isolated_positions, v3);
            };
            let v4 = 0x1::vector::empty<Position>();
            0x1::vector::push_back<Position>(&mut v4, v1);
            v4
        }
    }

    public(friend) fun get_total_effective_balance(arg0: &vector<DepositedAsset>, arg1: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<DepositedAsset>(arg0)) {
            let v2 = 0x1::vector::borrow<DepositedAsset>(arg0, v0);
            let (_, _, _, v6, v7, v8) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::asset_values(*0x2::table::borrow<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset>(arg1, v2.name));
            if (v8) {
                v1 = v1 + asset_to_usd(v2.quantity, v7, v6);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun get_total_margin_required(arg0: &vector<Position>, arg1: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg2: u8) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<Position>(arg0)) {
            let v2 = 0x1::vector::borrow<Position>(arg0, v0);
            let v3 = 0x2::table::borrow<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>(arg1, v2.perpetual);
            let v4 = if (v2.is_isolated) {
                v2.average_entry_price
            } else {
                0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(v3)
            };
            let v5 = if (arg2 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::mmr_threshold()) {
                0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_mmr(v3)
            } else {
                0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_imr(v3)
            };
            v1 = v1 + 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v2.size, v4), v5);
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_trading_fee(arg0: &Account) : TradeFee {
        arg0.trading_fees
    }

    public(friend) fun get_unrealized_pnl(arg0: &vector<Position>, arg1: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>) : 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number {
        let v0 = 0;
        let v1 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::new();
        while (v0 < 0x1::vector::length<Position>(arg0)) {
            v1 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::add(v1, compute_position_pnl(arg1, 0x1::vector::borrow<Position>(arg0, v0)));
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_usdc_amount(arg0: &Account) : u64 {
        if (0x1::vector::length<DepositedAsset>(&arg0.assets) > 0) {
            0x1::vector::borrow<DepositedAsset>(&arg0.assets, 0).quantity
        } else {
            0
        }
    }

    public fun has_most_negative_pnl(arg0: &vector<Position>, arg1: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg2: 0x1::string::String) : bool {
        let v0 = 0;
        let v1 = arg2;
        let v2 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::max_value_u64(), true);
        let v3 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::new();
        while (v0 < 0x1::vector::length<Position>(arg0)) {
            let v4 = 0x1::vector::borrow<Position>(arg0, v0);
            let v5 = compute_position_pnl(arg1, v4);
            if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::lt(v5, v2)) {
                v1 = v4.perpetual;
                v2 = v5;
            };
            if (v4.perpetual == arg2) {
                v3 = v5;
            };
            v0 = v0 + 1;
        };
        v1 == arg2 || 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::eq(v3, v2)
    }

    public fun has_most_positive_pnl(arg0: &vector<Position>, arg1: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg2: 0x1::string::String) : bool {
        if (0x1::vector::is_empty<Position>(arg0)) {
            return false
        };
        let v0 = 0;
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::max_value_u64(), false);
        let v3 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::new();
        while (v0 < 0x1::vector::length<Position>(arg0)) {
            let v4 = 0x1::vector::borrow<Position>(arg0, v0);
            let v5 = compute_position_pnl(arg1, v4);
            if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::gt(v5, v2)) {
                v1 = v4.perpetual;
                v2 = v5;
            };
            if (v4.perpetual == arg2) {
                v3 = v5;
            };
            v0 = v0 + 1;
        };
        v1 == arg2 || 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::eq(v3, v2)
    }

    public fun has_open_position(arg0: &vector<Position>, arg1: 0x1::string::String) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Position>(arg0)) {
            if (0x1::vector::borrow<Position>(arg0, v0).perpetual == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun has_permission(arg0: &Account, arg1: address) : bool {
        arg1 == arg0.address || 0x1::vector::contains<address>(&arg0.authorized, &arg1)
    }

    public(friend) fun initialize(arg0: address) : Account {
        let v0 = TradeFee{
            maker   : 0,
            taker   : 0,
            applied : false,
        };
        Account{
            address            : arg0,
            authorized         : 0x1::vector::empty<address>(),
            assets             : 0x1::vector::empty<DepositedAsset>(),
            cross_positions    : 0x1::vector::empty<Position>(),
            isolated_positions : 0x1::vector::empty<Position>(),
            trading_fees       : v0,
            is_institution     : false,
            fee_asset          : 0x1::string::utf8(b""),
        }
    }

    public fun is_bankrupt(arg0: &Account, arg1: 0x1::string::String, arg2: bool, arg3: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg4: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset>) : bool {
        let v0 = if (arg2) {
            arg1
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string()
        };
        let v1 = get_positions_vector(arg0, v0);
        let v2 = get_assets_vector(arg0, v0);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::lt_uint(get_account_value(&v2, &v1, arg3, arg4), 0)
    }

    public fun is_institution(arg0: &Account) : bool {
        arg0.is_institution
    }

    public fun is_liquidateable(arg0: &Account, arg1: 0x1::string::String, arg2: bool, arg3: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg4: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset>) : bool {
        let (_, v1) = get_account_value_and_health(arg0, arg1, arg2, arg3, arg4, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::mmr_threshold());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::lt_uint(v1, 0)
    }

    public(friend) fun set_account_type(arg0: &mut Account, arg1: bool) {
        arg0.is_institution = arg1;
    }

    public(friend) fun set_authorized_user(arg0: &mut Account, arg1: address, arg2: bool) {
        if (arg2) {
            let (v0, _) = 0x1::vector::index_of<address>(&arg0.authorized, &arg1);
            if (v0 == false) {
                0x1::vector::push_back<address>(&mut arg0.authorized, arg1);
            };
        } else {
            let (v2, v3) = 0x1::vector::index_of<address>(&arg0.authorized, &arg1);
            if (v2) {
                0x1::vector::remove<address>(&mut arg0.authorized, v3);
            };
        };
    }

    public(friend) fun set_fee_tier(arg0: &mut Account, arg1: u64, arg2: u64, arg3: bool) {
        let v0 = TradeFee{
            maker   : arg1,
            taker   : arg2,
            applied : arg3,
        };
        arg0.trading_fees = v0;
    }

    public(friend) fun set_isolated_position_assets(arg0: &mut vector<DepositedAsset>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(0x1::vector::length<DepositedAsset>(arg0) > 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::insufficient_margin());
        0x1::vector::borrow_mut<DepositedAsset>(arg0, 0).quantity = arg1;
    }

    public(friend) fun sub_margin_from_asset_vector(arg0: &mut vector<DepositedAsset>, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x1::vector::length<DepositedAsset>(arg0) > 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::insufficient_margin());
        if (!0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::is_empty_string(arg2)) {
            let v0 = 0;
            let v1 = false;
            while (v0 < 0x1::vector::length<DepositedAsset>(arg0)) {
                let v2 = 0x1::vector::borrow_mut<DepositedAsset>(arg0, v0);
                if (v2.name == arg2) {
                    assert!(v2.quantity >= arg1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::insufficient_margin());
                    v2.quantity = v2.quantity - arg1;
                    v1 = true;
                    break
                };
                v0 = v0 + 1;
            };
            assert!(v1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::insufficient_margin());
        } else {
            let v3 = 0x1::vector::borrow_mut<DepositedAsset>(arg0, 0);
            assert!(v3.quantity >= arg1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::insufficient_margin());
            v3.quantity = v3.quantity - arg1;
        };
    }

    fun try_sub_margin(arg0: &mut vector<DepositedAsset>, arg1: u64) : (bool, u64) {
        if (0x1::vector::length<DepositedAsset>(arg0) == 0) {
            return (true, arg1)
        };
        let v0 = 0x1::vector::borrow_mut<DepositedAsset>(arg0, 0);
        if (v0.quantity >= arg1) {
            v0.quantity = v0.quantity - arg1;
            return (false, 0)
        };
        v0.quantity = 0;
        (true, arg1 - v0.quantity)
    }

    public(friend) fun update_account(arg0: &mut Account, arg1: &vector<DepositedAsset>, arg2: &vector<Position>, arg3: u64, arg4: bool) {
        let v0 = *0x1::vector::borrow<Position>(arg2, arg3);
        if (arg4) {
            let (v1, v2) = has_open_position(&arg0.isolated_positions, v0.perpetual);
            if (!v1) {
                if (v0.size > 0) {
                    0x1::vector::push_back<Position>(&mut arg0.isolated_positions, v0);
                };
            } else if (v0.size == 0) {
                0x1::vector::remove<Position>(&mut arg0.isolated_positions, v2);
            } else {
                let v3 = 0x1::vector::borrow_mut<Position>(&mut arg0.isolated_positions, v2);
                v3.is_long = v0.is_long;
                v3.size = v0.size;
                v3.average_entry_price = v0.average_entry_price;
                v3.margin = v0.margin;
                v3.leverage = v0.leverage;
                v3.pending_funding_payment = v0.pending_funding_payment;
                v3.funding = v0.funding;
            };
        } else {
            arg0.cross_positions = *arg2;
            if (v0.size == 0) {
                0x1::vector::remove<Position>(&mut arg0.cross_positions, arg3);
            };
        };
        arg0.assets = *arg1;
    }

    public(friend) fun update_account_cross_assets(arg0: &mut Account, arg1: vector<DepositedAsset>) {
        arg0.assets = arg1;
    }

    public(friend) fun update_account_cross_positions(arg0: &mut Account, arg1: vector<Position>) {
        arg0.cross_positions = arg1;
    }

    public(friend) fun update_position_values(arg0: &mut Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        if (!arg0.is_isolated) {
            arg4 = 0;
            arg3 = 0;
        };
        arg0.size = arg1;
        arg0.average_entry_price = arg2;
        arg0.margin = arg3;
        arg0.is_long = arg5;
        arg0.leverage = arg4;
        arg0.pending_funding_payment = arg6;
    }

    public(friend) fun update_position_values_including_funding_rate(arg0: &mut Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::FundingRate) {
        update_position_values(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        arg0.funding = arg7;
    }

    // decompiled from Move bytecode v6
}

