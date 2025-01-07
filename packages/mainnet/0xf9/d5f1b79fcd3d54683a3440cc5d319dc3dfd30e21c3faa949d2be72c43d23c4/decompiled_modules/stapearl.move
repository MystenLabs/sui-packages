module 0x6fb4d1ba62abca2b4744dac633066103ec29ebbbd90d1aa79464944183260a7f::stapearl {
    struct STAPEARL has drop {
        dummy_field: bool,
    }

    struct GlobalVault has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<STAPEARL>,
        position: 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position,
        reserve: 0x2::balance::Balance<STAPEARL>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun total_supply(arg0: &GlobalVault) : u64 {
        0x2::coin::total_supply<STAPEARL>(&arg0.treasury_cap)
    }

    public fun add_liquidity(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg2: 0x2::coin::Coin<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>> {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair_and_treasury<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(arg0);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::add_liquidity_direct<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(v0, v1, arg1, arg2, 0, 0, arg3)
    }

    fun align_value(arg0: &mut GlobalVault, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_current_position_mut(arg0);
        let v1 = get_lp_value(arg1, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(v0));
        let v2 = total_supply(arg0);
        if (v1 > v2) {
            0x2::coin::put<STAPEARL>(&mut arg0.reserve, 0x2::coin::mint<STAPEARL>(&mut arg0.treasury_cap, v1 - v2, arg2));
        };
    }

    fun borrow_current_position_mut(arg0: &mut GlobalVault) : &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position {
        let v0 = get_current_pool_idx(arg0);
        if (v0 > 0) {
            0x2::dynamic_field::borrow_mut<u64, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position>(&mut arg0.id, v0)
        } else {
            &mut arg0.position
        }
    }

    public fun claim_reserve(arg0: &AdminCap, arg1: &mut GlobalVault, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STAPEARL> {
        0x2::coin::from_balance<STAPEARL>(0x2::balance::withdraw_all<STAPEARL>(&mut arg1.reserve), arg2)
    }

    public fun claim_reward(arg0: &AdminCap, arg1: &mut GlobalVault, arg2: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>) {
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::harvest_<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, 0x2::sui::SUI>(arg2, borrow_current_position_mut(arg1), arg3, arg4)
    }

    public fun contains_pool_idx(arg0: &GlobalVault, arg1: u64) : bool {
        0x2::dynamic_field::exists_with_type<u64, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position>(&arg0.id, arg1)
    }

    public fun deposit(arg0: &mut GlobalVault, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STAPEARL> {
        align_value(arg0, arg1, arg5);
        let v0 = borrow_current_position_mut(arg0);
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::increase_position<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, 0x2::sui::SUI>(arg2, v0, arg4, arg3, arg5);
        0x2::coin::mint<STAPEARL>(&mut arg0.treasury_cap, get_lp_value(arg1, 0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>>(&arg4)), arg5)
    }

    fun geometric_mean(arg0: u64, arg1: u64) : u64 {
        (0x2::math::sqrt_u128((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun get_amounts_in(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: u64) : (u64, u64) {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(arg0));
        let v2 = v0 + v1;
        (mul_div(arg1, v0, v2), mul_div(arg1, v1, v2))
    }

    public fun get_current_pool_idx(arg0: &GlobalVault) : u64 {
        let v0 = 0x1::string::utf8(b"current_pool_idx");
        if (0x2::dynamic_field::exists_with_type<0x1::string::String, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun get_lp_value(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: u64) : u64 {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(arg0);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(v0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::total_lp_supply<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(v0);
        2 * geometric_mean(mul_div(v1, arg1, v3), mul_div(v2, arg1, v3))
    }

    fun init(arg0: STAPEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAPEARL>(arg0, 6, b"STAPEARL", b"SFLX-STABLE-PEARL-LP", b"Fungible token converted from SuiPearl position of stable pair (USDC/USDT)", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STAPEARL>>(v1, v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, v2);
        let v4 = GlobalVault{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            position     : 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::new(42, arg1),
            reserve      : 0x2::balance::zero<STAPEARL>(),
        };
        0x2::transfer::share_object<GlobalVault>(v4);
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == arg2) {
            arg0
        } else {
            (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
        }
    }

    public fun rotate_pool_idx(arg0: &AdminCap, arg1: &mut GlobalVault, arg2: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_current_position_mut(arg1);
        let v1 = 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::new(arg4, arg5);
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::increase_position<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, 0x2::sui::SUI>(arg2, &mut v1, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::decrease_position_<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, 0x2::sui::SUI>(arg2, v0, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(v0), arg3, arg5), arg3, arg5);
        0x2::dynamic_field::add<u64, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position>(&mut arg1.id, arg4, v1);
        set_current_pool_idx(arg1, arg4);
    }

    fun set_current_pool_idx(arg0: &mut GlobalVault, arg1: u64) {
        let v0 = 0x1::string::utf8(b"current_pool_idx");
        if (0x2::dynamic_field::exists_with_type<0x1::string::String, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v0, arg1);
        };
    }

    public fun withdraw(arg0: &mut GlobalVault, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<STAPEARL>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>> {
        align_value(arg0, arg1, arg5);
        let v0 = total_supply(arg0);
        let v1 = borrow_current_position_mut(arg0);
        0x2::coin::burn<STAPEARL>(&mut arg0.treasury_cap, arg4);
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::decrease_position_<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, 0x2::sui::SUI>(arg2, borrow_current_position_mut(arg0), mul_div(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(v1), 0x2::coin::value<STAPEARL>(&arg4), v0), arg3, arg5)
    }

    // decompiled from Move bytecode v6
}

