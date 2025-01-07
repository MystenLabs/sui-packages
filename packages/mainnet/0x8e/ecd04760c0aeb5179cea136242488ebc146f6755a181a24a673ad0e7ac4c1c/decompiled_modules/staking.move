module 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::staking {
    struct StartRequest has store {
        dummy_field: bool,
    }

    struct PoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Staking has key {
        id: 0x2::object::UID,
        version: u64,
        start: u64,
        active: bool,
    }

    struct Pool has store {
        total_value: u64,
        total_staked: u64,
        emissions: vector<u64>,
        reward_index: u128,
        last_updated: u64,
    }

    struct Staked<phantom T0> has store, key {
        id: 0x2::object::UID,
        end: u64,
        value: u64,
        reward_index: u128,
        balance: 0x2::balance::Balance<T0>,
    }

    fun assert_active(arg0: &Staking) {
        assert!(arg0.active, 2);
    }

    fun assert_last_version(arg0: &Staking) {
        assert!(arg0.version == 1, 5);
    }

    public fun calculate_rewards<T0: drop>(arg0: &mut Staking, arg1: &mut Staked<T0>, arg2: &0x2::clock::Clock) : u64 {
        assert_last_version(arg0);
        let v0 = PoolKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<PoolKey<T0>, Pool>(&mut arg0.id, v0);
        update_rewards(v1, 0x2::clock::timestamp_ms(arg2), arg0.start);
        0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::mul_div_down((0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::sub_u128(v1.reward_index, arg1.reward_index) as u64), arg1.value, 1000000000)
    }

    public fun claim<T0: drop>(arg0: &mut 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::Vault, arg1: &mut Staking, arg2: &mut Staked<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU> {
        assert_active(arg1);
        assert_last_version(arg1);
        let v0 = PoolKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<PoolKey<T0>, Pool>(&mut arg1.id, v0);
        update_rewards(v1, 0x2::clock::timestamp_ms(arg3), arg1.start);
        arg2.reward_index = v1.reward_index;
        0x2::coin::mint<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU>(0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::cap_mut(arg0), ((0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::sub_u128(v1.reward_index, arg2.reward_index) * (arg2.value as u128) / (1000000000 as u128)) as u64), arg4)
    }

    public fun complete_start(arg0: &0x2::clock::Clock, arg1: &mut Staking, arg2: StartRequest) {
        let StartRequest {  } = arg2;
        arg1.active = true;
        let v0 = 0x2::clock::timestamp_ms(arg0);
        arg1.start = v0;
        let v1 = PoolKey<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PoolKey<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU>, Pool>(&mut arg1.id, v1).last_updated = v0;
        let v2 = PoolKey<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU, 0x2::sui::SUI>>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PoolKey<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU, 0x2::sui::SUI>>, Pool>(&mut arg1.id, v2).last_updated = v0;
    }

    fun get_boost(arg0: u64) : u64 {
        if (arg0 == 0) {
            1000000000
        } else if (arg0 <= 8) {
            1000000000 + arg0 * 1000000000 / 8
        } else if (arg0 <= 12) {
            2 * 1000000000 + (arg0 - 8) * 1000000000 / 4
        } else if (arg0 <= 16) {
            3 * 1000000000 + (arg0 - 12) * 1000000000 / 2
        } else {
            assert!(arg0 <= 20, 4);
            5 * 1000000000 + (arg0 - 16) * 1000000000
        }
    }

    fun get_emitted(arg0: &Pool, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::min((arg0.last_updated - arg1) / 604800000, 71);
        let v1 = 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::min((arg2 - arg1) / 604800000, 71);
        let v2 = 0;
        while (v0 < v1 + 1) {
            let v3 = *0x1::vector::borrow<u64>(&arg0.emissions, v0);
            if (v0 != v1) {
                v2 = v2 + v3;
            };
            if (v0 == v1) {
                v2 = v2 + 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::mul_div_down(v3, 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::min(arg2 - arg1 - v1 * 604800000, 604800000), 604800000);
            };
            if (v0 == v0) {
                v2 = v2 - 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::mul_div_down(v3, 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::min(arg0.last_updated - arg1 - v0 * 604800000, 604800000), 604800000);
            };
            v0 = v0 + 1;
        };
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Staking{
            id      : 0x2::object::new(arg0),
            version : 1,
            start   : 0,
            active  : false,
        };
        let v1 = PoolKey<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU>{dummy_field: false};
        let v2 = Pool{
            total_value  : 0,
            total_staked : 0,
            emissions    : init_mazu_emissions(),
            reward_index : 0,
            last_updated : 0,
        };
        0x2::dynamic_field::add<PoolKey<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU>, Pool>(&mut v0.id, v1, v2);
        let v3 = PoolKey<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU, 0x2::sui::SUI>>{dummy_field: false};
        let v4 = Pool{
            total_value  : 0,
            total_staked : 0,
            emissions    : init_lp_emissions(),
            reward_index : 0,
            last_updated : 0,
        };
        0x2::dynamic_field::add<PoolKey<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU, 0x2::sui::SUI>>, Pool>(&mut v0.id, v3, v4);
        0x2::transfer::share_object<Staking>(v0);
    }

    fun init_lp_emissions() : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 12800000000000000);
        0x1::vector::push_back<u64>(&mut v0, 8533333330000000);
        0x1::vector::push_back<u64>(&mut v0, 8106666670000000);
        0x1::vector::push_back<u64>(&mut v0, 7466666670000000);
        0x1::vector::push_back<u64>(&mut v0, 6933333330000000);
        0x1::vector::push_back<u64>(&mut v0, 6400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 5866666670000000);
        0x1::vector::push_back<u64>(&mut v0, 5333333330000000);
        0x1::vector::push_back<u64>(&mut v0, 4800000000000000);
        0x1::vector::push_back<u64>(&mut v0, 4266666670000000);
        0x1::vector::push_back<u64>(&mut v0, 4266666670000000);
        0x1::vector::push_back<u64>(&mut v0, 4266666670000000);
        0x1::vector::push_back<u64>(&mut v0, 3733333330000000);
        0x1::vector::push_back<u64>(&mut v0, 3733333330000000);
        0x1::vector::push_back<u64>(&mut v0, 3733333330000000);
        0x1::vector::push_back<u64>(&mut v0, 3733333330000000);
        0x1::vector::push_back<u64>(&mut v0, 3733333330000000);
        0x1::vector::push_back<u64>(&mut v0, 3200000000000000);
        0x1::vector::push_back<u64>(&mut v0, 3200000000000000);
        0x1::vector::push_back<u64>(&mut v0, 3200000000000000);
        0x1::vector::push_back<u64>(&mut v0, 3200000000000000);
        0x1::vector::push_back<u64>(&mut v0, 3200000000000000);
        0x1::vector::push_back<u64>(&mut v0, 3200000000000000);
        0x1::vector::push_back<u64>(&mut v0, 3200000000000000);
        0x1::vector::push_back<u64>(&mut v0, 3200000000000000);
        0x1::vector::push_back<u64>(&mut v0, 3200000000000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 2133333330000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1920000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1706666670000000);
        v0
    }

    fun init_mazu_emissions() : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 2666666670000000);
        0x1::vector::push_back<u64>(&mut v0, 1777777780000000);
        0x1::vector::push_back<u64>(&mut v0, 1688888890000000);
        0x1::vector::push_back<u64>(&mut v0, 1555555560000000);
        0x1::vector::push_back<u64>(&mut v0, 1444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 1333333330000000);
        0x1::vector::push_back<u64>(&mut v0, 1222222220000000);
        0x1::vector::push_back<u64>(&mut v0, 1111111110000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000000000000);
        0x1::vector::push_back<u64>(&mut v0, 888888890000000);
        0x1::vector::push_back<u64>(&mut v0, 888888890000000);
        0x1::vector::push_back<u64>(&mut v0, 888888890000000);
        0x1::vector::push_back<u64>(&mut v0, 777777780000000);
        0x1::vector::push_back<u64>(&mut v0, 777777780000000);
        0x1::vector::push_back<u64>(&mut v0, 777777780000000);
        0x1::vector::push_back<u64>(&mut v0, 777777780000000);
        0x1::vector::push_back<u64>(&mut v0, 777777780000000);
        0x1::vector::push_back<u64>(&mut v0, 666666670000000);
        0x1::vector::push_back<u64>(&mut v0, 666666670000000);
        0x1::vector::push_back<u64>(&mut v0, 666666670000000);
        0x1::vector::push_back<u64>(&mut v0, 666666670000000);
        0x1::vector::push_back<u64>(&mut v0, 666666670000000);
        0x1::vector::push_back<u64>(&mut v0, 666666670000000);
        0x1::vector::push_back<u64>(&mut v0, 666666670000000);
        0x1::vector::push_back<u64>(&mut v0, 666666670000000);
        0x1::vector::push_back<u64>(&mut v0, 666666670000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 444444440000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 400000000000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        0x1::vector::push_back<u64>(&mut v0, 355555560000000);
        v0
    }

    public fun propose_start(arg0: &mut 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::multisig::Multisig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StartRequest{dummy_field: false};
        0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::multisig::create_proposal<StartRequest>(arg0, arg1, v0, arg2);
    }

    public fun stake<T0: drop>(arg0: &mut Staking, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Staked<T0> {
        assert_active(arg0);
        assert_last_version(arg0);
        let v0 = PoolKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<PoolKey<T0>>(&arg0.id, v0), 0);
        assert!(0x2::coin::value<T0>(&arg1) != 0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = PoolKey<T0>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<PoolKey<T0>, Pool>(&mut arg0.id, v2);
        let v4 = 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::mul_div_down(0x2::coin::value<T0>(&arg1), get_boost(arg3), 1000000000);
        update_rewards(v3, v1, arg0.start);
        v3.total_value = v3.total_value + v4;
        v3.total_staked = v3.total_staked + 0x2::coin::value<T0>(&arg1);
        Staked<T0>{
            id           : 0x2::object::new(arg4),
            end          : v1 + 604800000 * arg3,
            value        : v4,
            reward_index : v3.reward_index,
            balance      : 0x2::coin::into_balance<T0>(arg1),
        }
    }

    public fun start_start(arg0: 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::multisig::Proposal) : StartRequest {
        0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::multisig::get_request<StartRequest>(arg0)
    }

    public fun unstake<T0: drop>(arg0: &mut 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::Vault, arg1: &mut Staking, arg2: Staked<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU>) {
        assert_active(arg1);
        assert_last_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let Staked {
            id           : v1,
            end          : v2,
            value        : v3,
            reward_index : v4,
            balance      : v5,
        } = arg2;
        let v6 = v5;
        0x2::object::delete(v1);
        assert!(v2 <= v0 || (v0 - arg1.start) / 604800000 >= 72, 3);
        let v7 = PoolKey<T0>{dummy_field: false};
        let v8 = 0x2::dynamic_field::borrow_mut<PoolKey<T0>, Pool>(&mut arg1.id, v7);
        update_rewards(v8, v0, arg1.start);
        v8.total_value = 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::sub(v8.total_value, v3);
        v8.total_staked = 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::sub(v8.total_staked, 0x2::balance::value<T0>(&v6));
        (0x2::coin::from_balance<T0>(v6, arg4), 0x2::coin::mint<0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::MAZU>(0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::mazu::cap_mut(arg0), ((0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math::sub_u128(v8.reward_index, v4) * (v3 as u128) / (1000000000 as u128)) as u64), arg4))
    }

    fun update_rewards(arg0: &mut Pool, arg1: u64, arg2: u64) {
        if (arg0.total_value == 0) {
            return
        };
        arg0.reward_index = (get_emitted(arg0, arg2, arg1) as u128) * (1000000000 as u128) / (arg0.total_value as u128) + arg0.reward_index;
        arg0.last_updated = arg1;
    }

    // decompiled from Move bytecode v6
}

