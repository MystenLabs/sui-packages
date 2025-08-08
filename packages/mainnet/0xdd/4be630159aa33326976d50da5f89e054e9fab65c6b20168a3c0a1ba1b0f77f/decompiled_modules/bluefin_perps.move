module 0xdd4be630159aa33326976d50da5f89e054e9fab65c6b20168a3c0a1ba1b0f77f::bluefin_perps {
    struct TradeChecks has copy, drop, store {
        min_price: u128,
        max_price: u128,
        tick_size: u128,
        min_qty: u128,
        max_qty_limit: u128,
        max_qty_market: u128,
        step_size: u128,
        mtb_long: u128,
        mtb_short: u128,
        max_allowed_oi_open: vector<u128>,
    }

    struct Number has copy, drop, store {
        value: u128,
        sign: bool,
    }

    struct FundingIndex has copy, drop, store {
        value: Number,
        timestamp: u64,
    }

    struct FundingRate has copy, drop, store {
        start_time: u64,
        max_funding: u128,
        window: u64,
        rate: Number,
        index: FundingIndex,
    }

    struct UserPosition has copy, drop, store {
        user: address,
        perp_uid: 0x2::object::ID,
        is_pos_positive: bool,
        q_pos: u128,
        margin: u128,
        oi_open: u128,
        mro: u128,
        index: FundingIndex,
    }

    struct SpecialFee has copy, drop, store {
        status: bool,
        maker_fee: u128,
        taker_fee: u128,
    }

    struct PerpetualV2 has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        imr: u128,
        mmr: u128,
        maker_fee: u128,
        taker_fee: u128,
        insurance_pool_ratio: u128,
        insurance_pool: address,
        fee_pool: address,
        delisted: bool,
        delisting_price: u128,
        is_trading_permitted: bool,
        start_time: u64,
        checks: TradeChecks,
        positions: 0x2::table::Table<address, UserPosition>,
        special_fee: 0x2::table::Table<address, SpecialFee>,
        price_oracle: u128,
        funding: FundingRate,
        price_identifier_id: vector<u8>,
    }

    // decompiled from Move bytecode v6
}

