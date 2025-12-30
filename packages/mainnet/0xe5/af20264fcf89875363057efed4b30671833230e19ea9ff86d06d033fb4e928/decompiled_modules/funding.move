module 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::funding {
    struct FundingRecord has store, key {
        id: 0x2::object::UID,
        deal_id: 0x2::object::ID,
        funder: address,
        amount: u64,
        funding_type: u8,
        currency_type: u8,
        timestamp: u64,
    }

    struct FundingRecordUSDC<phantom T0> has store, key {
        id: 0x2::object::UID,
        deal_id: 0x2::object::ID,
        funder: address,
        amount: u64,
        funding_type: u8,
        currency_type: u8,
        timestamp: u64,
    }

    struct DealFunded has copy, drop {
        deal_id: 0x2::object::ID,
        funder: address,
        amount: u64,
        funding_type: u8,
        currency_type: u8,
        timestamp: u64,
    }

    struct DealExtended has copy, drop {
        deal_id: 0x2::object::ID,
        additional_days: u64,
        additional_amount: u64,
        new_end_timestamp: u64,
        currency_type: u8,
    }

    public fun add_extra_funding(arg0: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnit, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(v1 > 0, 300);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::add_funds_to_escrow(arg0, arg1);
        let v3 = FundingRecord{
            id            : 0x2::object::new(arg2),
            deal_id       : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnit>(arg0),
            funder        : v0,
            amount        : v1,
            funding_type  : 1,
            currency_type : 0,
            timestamp     : v2,
        };
        let v4 = DealFunded{
            deal_id       : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnit>(arg0),
            funder        : v0,
            amount        : v1,
            funding_type  : 1,
            currency_type : 0,
            timestamp     : v2,
        };
        0x2::event::emit<DealFunded>(v4);
        0x2::transfer::share_object<FundingRecord>(v3);
    }

    public fun add_extra_funding_usdc<T0>(arg0: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnitUSDC<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(v1 > 0, 300);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::add_funds_to_escrow_usdc<T0>(arg0, arg1);
        let v3 = FundingRecordUSDC<T0>{
            id            : 0x2::object::new(arg2),
            deal_id       : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnitUSDC<T0>>(arg0),
            funder        : v0,
            amount        : v1,
            funding_type  : 1,
            currency_type : 1,
            timestamp     : v2,
        };
        let v4 = DealFunded{
            deal_id       : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnitUSDC<T0>>(arg0),
            funder        : v0,
            amount        : v1,
            funding_type  : 1,
            currency_type : 1,
            timestamp     : v2,
        };
        0x2::event::emit<DealFunded>(v4);
        0x2::transfer::share_object<FundingRecordUSDC<T0>>(v3);
    }

    public fun extend_deal_duration(arg0: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnit, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let (_, _, v5, v6, _) = 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::get_deal_details(arg0);
        assert!(v1 >= v5 * v6 * arg2 / 30, 300);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::add_funds_to_escrow(arg0, arg1);
        let v8 = FundingRecord{
            id            : 0x2::object::new(arg3),
            deal_id       : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnit>(arg0),
            funder        : v0,
            amount        : v1,
            funding_type  : 2,
            currency_type : 0,
            timestamp     : v2,
        };
        let v9 = DealExtended{
            deal_id           : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnit>(arg0),
            additional_days   : arg2,
            additional_amount : v1,
            new_end_timestamp : 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::extend_duration(arg0, arg2),
            currency_type     : 0,
        };
        0x2::event::emit<DealExtended>(v9);
        let v10 = DealFunded{
            deal_id       : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnit>(arg0),
            funder        : v0,
            amount        : v1,
            funding_type  : 2,
            currency_type : 0,
            timestamp     : v2,
        };
        0x2::event::emit<DealFunded>(v10);
        0x2::transfer::share_object<FundingRecord>(v8);
    }

    public fun extend_deal_duration_usdc<T0>(arg0: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnitUSDC<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let (_, _, v5, v6, _) = 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::get_deal_details_usdc<T0>(arg0);
        assert!(v1 >= v5 * v6 * arg2 / 30, 300);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::add_funds_to_escrow_usdc<T0>(arg0, arg1);
        let v8 = FundingRecordUSDC<T0>{
            id            : 0x2::object::new(arg3),
            deal_id       : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnitUSDC<T0>>(arg0),
            funder        : v0,
            amount        : v1,
            funding_type  : 2,
            currency_type : 1,
            timestamp     : v2,
        };
        let v9 = DealExtended{
            deal_id           : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnitUSDC<T0>>(arg0),
            additional_days   : arg2,
            additional_amount : v1,
            new_end_timestamp : 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::extend_duration_usdc<T0>(arg0, arg2),
            currency_type     : 1,
        };
        0x2::event::emit<DealExtended>(v9);
        let v10 = DealFunded{
            deal_id       : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal::DataUnitUSDC<T0>>(arg0),
            funder        : v0,
            amount        : v1,
            funding_type  : 2,
            currency_type : 1,
            timestamp     : v2,
        };
        0x2::event::emit<DealFunded>(v10);
        0x2::transfer::share_object<FundingRecordUSDC<T0>>(v8);
    }

    public fun get_currency_type(arg0: &FundingRecord) : u8 {
        arg0.currency_type
    }

    public fun get_currency_type_usdc<T0>(arg0: &FundingRecordUSDC<T0>) : u8 {
        arg0.currency_type
    }

    public fun get_funding_amount(arg0: &FundingRecord) : u64 {
        arg0.amount
    }

    public fun get_funding_amount_usdc<T0>(arg0: &FundingRecordUSDC<T0>) : u64 {
        arg0.amount
    }

    public fun get_funding_details(arg0: &FundingRecord) : (0x2::object::ID, address, u64, u8, u8) {
        (arg0.deal_id, arg0.funder, arg0.amount, arg0.funding_type, arg0.currency_type)
    }

    public fun get_funding_details_usdc<T0>(arg0: &FundingRecordUSDC<T0>) : (0x2::object::ID, address, u64, u8, u8) {
        (arg0.deal_id, arg0.funder, arg0.amount, arg0.funding_type, arg0.currency_type)
    }

    public fun get_funding_type(arg0: &FundingRecord) : u8 {
        arg0.funding_type
    }

    public fun get_funding_type_usdc<T0>(arg0: &FundingRecordUSDC<T0>) : u8 {
        arg0.funding_type
    }

    // decompiled from Move bytecode v6
}

