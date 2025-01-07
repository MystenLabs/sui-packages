module 0x143c5b42f7d6fcbedef6351b329034533cb165cee0e68ceff252500be45d0636::presale {
    struct Round<phantom T0> has key {
        id: 0x2::object::UID,
        sht_sold: u64,
        ratio: u64,
        is_on: bool,
        presale_start_timestamp: u64,
        presale_end_timestamp: u64,
        beneficiary: address,
        min_buy: u64,
        max_buy: u64,
        referral: 0x2::table::Table<address, vector<ReferralInfo>>,
        fund: 0x2::balance::Balance<T0>,
    }

    struct ReferralInfo has store {
        buyer: address,
        sui_reward: u64,
        sht_amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UpdateRatioEvent has copy, drop {
        new_ratio: u64,
    }

    struct UpdatePresaleTimeEvent has copy, drop {
        is_on: bool,
        trigger_time: u64,
    }

    struct UpdateBeneficiaryEvent has copy, drop {
        beneficiary: address,
    }

    struct AddFundEvent has copy, drop {
        fund_amount: u64,
    }

    struct UpdateMinBuyEvent has copy, drop {
        min_buy: u64,
    }

    struct UpdateMaxBuyEvent has copy, drop {
        max_buy: u64,
    }

    struct CreateNewRoundEvent has copy, drop {
        ratio: u64,
        beneficiary: address,
        min_buy: u64,
        max_buy: u64,
    }

    struct OnOffEvent has copy, drop {
        is_on: bool,
    }

    struct UpdateRoundStartEndTimeEvent has copy, drop {
        presale_start_timestamp: u64,
        presale_end_timestamp: u64,
    }

    public entry fun add_fund<T0>(arg0: &AdminCap, arg1: &mut Round<T0>, arg2: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 6);
        0x2::balance::join<T0>(&mut arg1.fund, v0);
        let v2 = AddFundEvent{fund_amount: v1};
        0x2::event::emit<AddFundEvent>(v2);
    }

    public entry fun buy<T0>(arg0: &mut Round<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg0.min_buy, 0);
        assert!(v1 <= arg0.max_buy, 1);
        assert!(arg0.is_on, 4);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 >= arg0.presale_start_timestamp, 2);
        assert!(v2 <= arg0.presale_end_timestamp, 3);
        let v3 = v1 * arg0.ratio;
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.fund), 7);
        arg0.sht_sold = arg0.sht_sold + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.fund, v3, arg4), 0x2::tx_context::sender(arg4));
        if (0x2::address::to_u256(arg3) != 0x2::address::to_u256(arg0.beneficiary)) {
            let v4 = v1 * 90 / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v0, v4, arg4), arg0.beneficiary);
            let v5 = v1 - v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v0, v5, arg4), arg3);
            let v6 = ReferralInfo{
                buyer      : 0x2::tx_context::sender(arg4),
                sui_reward : v5,
                sht_amount : v3,
            };
            if (0x2::table::contains<address, vector<ReferralInfo>>(&arg0.referral, arg3)) {
                0x1::vector::push_back<ReferralInfo>(0x2::table::borrow_mut<address, vector<ReferralInfo>>(&mut arg0.referral, arg3), v6);
            } else {
                let v7 = 0x1::vector::empty<ReferralInfo>();
                0x1::vector::push_back<ReferralInfo>(&mut v7, v6);
                0x2::table::add<address, vector<ReferralInfo>>(&mut arg0.referral, arg3, v7);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v0, v1, arg4), arg0.beneficiary);
        };
        let v8 = 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4);
        if (0x2::coin::value<0x2::sui::SUI>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
        };
    }

    public entry fun claim_back_fund<T0>(arg0: &AdminCap, arg1: &mut Round<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.fund);
        assert!(v0 > 0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.fund, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_new_round<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Round<T0>{
            id                      : 0x2::object::new(arg5),
            sht_sold                : 0,
            ratio                   : arg1,
            is_on                   : false,
            presale_start_timestamp : 0,
            presale_end_timestamp   : 0,
            beneficiary             : arg4,
            min_buy                 : arg2,
            max_buy                 : arg3,
            referral                : 0x2::table::new<address, vector<ReferralInfo>>(arg5),
            fund                    : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Round<T0>>(v0);
        let v1 = CreateNewRoundEvent{
            ratio       : arg1,
            beneficiary : arg4,
            min_buy     : arg2,
            max_buy     : arg3,
        };
        0x2::event::emit<CreateNewRoundEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun on_off_round<T0>(arg0: &AdminCap, arg1: &mut Round<T0>, arg2: bool) {
        arg1.is_on = arg2;
        let v0 = OnOffEvent{is_on: arg2};
        0x2::event::emit<OnOffEvent>(v0);
    }

    public entry fun update_beneficiary_address<T0>(arg0: &AdminCap, arg1: &mut Round<T0>, arg2: address) {
        arg1.beneficiary = arg2;
        let v0 = UpdateBeneficiaryEvent{beneficiary: arg2};
        0x2::event::emit<UpdateBeneficiaryEvent>(v0);
    }

    public entry fun update_max_buy<T0>(arg0: &AdminCap, arg1: &mut Round<T0>, arg2: u64) {
        arg1.max_buy = arg2;
        let v0 = UpdateMaxBuyEvent{max_buy: arg2};
        0x2::event::emit<UpdateMaxBuyEvent>(v0);
    }

    public entry fun update_min_buy<T0>(arg0: &AdminCap, arg1: &mut Round<T0>, arg2: u64) {
        arg1.min_buy = arg2;
        let v0 = UpdateMinBuyEvent{min_buy: arg2};
        0x2::event::emit<UpdateMinBuyEvent>(v0);
    }

    public entry fun update_ratio<T0>(arg0: &AdminCap, arg1: &mut Round<T0>, arg2: u64) {
        arg1.ratio = arg2;
        let v0 = UpdateRatioEvent{new_ratio: arg2};
        0x2::event::emit<UpdateRatioEvent>(v0);
    }

    public entry fun update_round_start_end_time<T0>(arg0: &AdminCap, arg1: &mut Round<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64) {
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg2), 2);
        assert!(arg4 >= arg3, 3);
        arg1.presale_start_timestamp = arg3;
        arg1.presale_end_timestamp = arg4;
        let v0 = UpdateRoundStartEndTimeEvent{
            presale_start_timestamp : arg3,
            presale_end_timestamp   : arg4,
        };
        0x2::event::emit<UpdateRoundStartEndTimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

