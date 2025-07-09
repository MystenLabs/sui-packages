module 0x84f3d8e5c25d2a32dc7d6b1a0b2220d912eee329a86da15a8e9f2de80252ee12::bluefin_perps {
    struct TradeChecks has copy, drop, store {
        minPrice: u128,
        maxPrice: u128,
        tickSize: u128,
        minQty: u128,
        maxQtyLimit: u128,
        maxQtyMarket: u128,
        stepSize: u128,
        mtbLong: u128,
        mtbShort: u128,
        maxAllowedOIOpen: vector<u128>,
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
        startTime: u64,
        maxFunding: u128,
        window: u64,
        rate: Number,
        index: FundingIndex,
    }

    struct UserPosition has copy, drop, store {
        user: address,
        perpID: 0x2::object::ID,
        isPosPositive: bool,
        qPos: u128,
        margin: u128,
        oiOpen: u128,
        mro: u128,
        index: FundingIndex,
    }

    struct SpecialFee has copy, drop, store {
        status: bool,
        makerFee: u128,
        takerFee: u128,
    }

    struct PerpetualV2 has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        imr: u128,
        mmr: u128,
        makerFee: u128,
        takerFee: u128,
        insurancePoolRatio: u128,
        insurancePool: address,
        feePool: address,
        delisted: bool,
        delistingPrice: u128,
        isTradingPermitted: bool,
        startTime: u64,
        checks: TradeChecks,
        positions: 0x2::table::Table<address, UserPosition>,
        specialFee: 0x2::table::Table<address, SpecialFee>,
        priceOracle: u128,
        funding: FundingRate,
        priceIdentifierId: vector<u8>,
    }

    // decompiled from Move bytecode v6
}

