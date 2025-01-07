module 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::staking {
    struct STAKING has drop {
        dummy_field: bool,
    }

    struct StakingStorage has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
        website: 0x1::string::String,
        link: 0x1::string::String,
        description: 0x1::string::String,
        access_range_limit: u64,
        invest_list: 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>,
        access_list: 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>,
        core: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
        other: 0x2::object_bag::ObjectBag,
    }

    struct StakingPackage<phantom T0> has drop, store {
        key: 0x1::string::String,
        name: 0x1::string::String,
        image: 0x1::string::String,
        website: 0x1::string::String,
        link: 0x1::string::String,
        description: 0x1::string::String,
        days: u64,
        apr: u64,
        min_stake_amount: u64,
        unstake_soon_fee: u64,
        is_open: bool,
        is_pause: bool,
    }

    struct ProofOfStake has store {
        staker: address,
        stake_token: 0x1::string::String,
        stake_amount: u64,
        stake_date: u64,
        unstake_date: 0x1::option::Option<u64>,
        latest_claim_date: 0x1::option::Option<u64>,
        profit_claimed_amount: u64,
        stake_package_key: 0x1::string::String,
        apr_at_moment: u64,
        days_at_moment: u64,
        name_at_moment: 0x1::string::String,
    }

    struct Stake has copy, drop {
        sender: address,
        epoch_time: u64,
        package_key: 0x1::string::String,
        apr: u64,
        days: u64,
        stake_amount: u64,
    }

    struct Unstake has copy, drop {
        sender: address,
        epoch_time: u64,
        package_key: 0x1::string::String,
        apr: u64,
        accumulated_days: u64,
        profit: u64,
        stake_amount: u64,
    }

    struct Claim has copy, drop {
        sender: address,
        epoch_time: u64,
        package_key: 0x1::string::String,
        apr: u64,
        accumulated_days: u64,
        profit: u64,
        stake_amount: u64,
    }

    fun display<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{website}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"YouSUI Creator"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg1);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg1));
    }

    public entry fun claim<T0>(arg0: &0x2::clock::Clock, arg1: &mut StakingStorage, arg2: &mut 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::certificate::InvestmentCertificate, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::certificate::get_mut_df_info<ProofOfStake>(arg2);
        assert!(!0x2::dynamic_field::borrow<0x1::string::String, StakingPackage<T0>>(&arg1.id, v2.stake_package_key).is_pause, 2002);
        assert!(0x1::option::is_none<u64>(&v2.unstake_date), 2005);
        let v3 = if (0x1::option::is_none<u64>(&v2.latest_claim_date)) {
            v2.stake_date
        } else {
            0x1::option::extract<u64>(&mut v2.latest_claim_date)
        };
        let (v4, v5) = cal_time_and_days(v0, v3);
        let v6 = v5 * cal_profit_per_day(v2.stake_amount, v2.apr_at_moment);
        assert!(v6 > 0, 2004);
        0x1::option::fill<u64>(&mut v2.latest_claim_date, v4);
        v2.profit_claimed_amount = v2.profit_claimed_amount + v6;
        0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::vault::withdraw<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::vault::Vaults>(&mut arg1.other, 0x1::string::utf8(b"VAULT")), v6, v1, arg3);
        let v7 = Claim{
            sender           : v1,
            epoch_time       : v0,
            package_key      : v2.stake_package_key,
            apr              : v2.apr_at_moment,
            accumulated_days : v5,
            profit           : v6,
            stake_amount     : v2.stake_amount,
        };
        0x2::event::emit<Claim>(v7);
    }

    public(friend) fun add_staking_package<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: bool) {
        let v0 = StakingPackage<T0>{
            key              : arg1,
            name             : arg2,
            image            : arg3,
            website          : arg4,
            link             : arg5,
            description      : arg6,
            days             : arg7,
            apr              : arg8,
            min_stake_amount : arg9,
            unstake_soon_fee : arg10,
            is_open          : arg11,
            is_pause         : arg12,
        };
        0x2::dynamic_field::add<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1, v0);
    }

    fun cal_profit_per_day(arg0: u64, arg1: u64) : u64 {
        0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::utils::mul_u64_div_u64(arg0, parse_percent(arg1), 365 * 0x2::math::pow(10, 9))
    }

    fun cal_time_and_days(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = 0x2::math::diff(arg0, arg1) / 86400000;
        (arg1 + v0 * 86400000, v0)
    }

    public(friend) fun get_mut_vault(arg0: &mut StakingStorage) : &mut 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::vault::Vaults {
        0x2::object_bag::borrow_mut<0x1::string::String, 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::vault::Vaults>(&mut arg0.other, 0x1::string::utf8(b"VAULT"))
    }

    fun init(arg0: STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<STAKING>(arg0, arg1);
        display<StakingStorage>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>();
        let v2 = 0x2::object_bag::new(arg1);
        let v3 = &mut v1;
        let v4 = &mut v2;
        new_vault(v3, v4, arg1);
        let v5 = StakingStorage{
            id                 : 0x2::object::new(arg1),
            name               : 0x1::string::utf8(b"YouSUI Staking"),
            image              : 0x1::string::utf8(b"https://yousui.io/images/staking/water-seek.jpg"),
            website            : 0x1::string::utf8(b"https://yousui.io"),
            link               : 0x1::string::utf8(b"https://yousui.io/staking"),
            description        : 0x1::string::utf8(b"YouSUI is an All-In-One platform that runs on the Sui Blockchain and includes DEX, Launchpad, NFT Marketplace and Bridge."),
            access_range_limit : 86400000,
            invest_list        : 0x2::vec_map::empty<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(),
            access_list        : 0x2::vec_map::empty<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(),
            core               : v1,
            other              : v2,
        };
        0x2::transfer::share_object<StakingStorage>(v5);
    }

    fun is_access_granted(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 - arg1 > arg2
    }

    fun new_vault(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>, arg1: &mut 0x2::object_bag::ObjectBag, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"VAULT");
        let (v1, v2) = 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::vault::new(arg2);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(arg0, v0, v2);
        0x2::object_bag::add<0x1::string::String, 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::vault::Vaults>(arg1, v0, v1);
    }

    fun parse_percent(arg0: u64) : u64 {
        arg0 / 100
    }

    public(friend) fun remove_staking_package<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String) {
        0x2::dynamic_field::remove<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1);
    }

    public(friend) fun set_access_range_limit(arg0: &mut StakingStorage, arg1: u64) {
        arg0.access_range_limit = arg1;
    }

    public(friend) fun set_apr<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: u64) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).apr = arg2;
    }

    public(friend) fun set_days<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: u64) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).days = arg2;
    }

    public(friend) fun set_description<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).description = arg2;
    }

    public(friend) fun set_image<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).image = arg2;
    }

    public(friend) fun set_is_open<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: bool) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).is_open = arg2;
    }

    public(friend) fun set_is_pause<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: bool) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).is_pause = arg2;
    }

    public(friend) fun set_link<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).link = arg2;
    }

    public(friend) fun set_min_stake_amount<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: u64) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).min_stake_amount = arg2;
    }

    public(friend) fun set_name<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).name = arg2;
    }

    public(friend) fun set_unstake_soon_fee<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: u64) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).unstake_soon_fee = arg2;
    }

    public(friend) fun set_website<T0>(arg0: &mut StakingStorage, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, StakingPackage<T0>>(&mut arg0.id, arg1).website = arg2;
    }

    public entry fun stake<T0>(arg0: &0x2::clock::Clock, arg1: &mut StakingStorage, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::utils::get_full_type<T0>();
        let v3 = 0x2::dynamic_field::borrow<0x1::string::String, StakingPackage<T0>>(&arg1.id, arg2);
        let v4 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::vault::Vaults>(&mut arg1.other, 0x1::string::utf8(b"VAULT"));
        let v5 = 0x2::coin::value<T0>(&arg3);
        if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg1.invest_list, &v1)) {
            let v6 = 0x2::vec_map::get_mut<0x1::string::String, u64>(0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg1.invest_list, &v1), &v2);
            *v6 = *v6 + v5;
        } else {
            let v7 = 0x2::vec_map::empty<0x1::string::String, u64>();
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v7, v2, v5);
            0x2::vec_map::insert<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg1.invest_list, v1, v7);
        };
        if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg1.access_list, &v1)) {
            let v8 = 0x2::vec_map::get<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg1.access_list, &v1);
            let v9 = 0x1::string::utf8(b"ACTION_UNSTAKE");
            if (0x2::vec_map::contains<0x1::string::String, u64>(v8, &v9)) {
                let v10 = 0x1::string::utf8(b"ACTION_UNSTAKE");
                assert!(is_access_granted(v0, *0x2::vec_map::get<0x1::string::String, u64>(v8, &v10), arg1.access_range_limit), 2003);
            };
        };
        assert!(v3.is_open, 2000);
        assert!(v5 >= v3.min_stake_amount, 2001);
        if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg1.access_list, &v1)) {
            let v11 = 0x1::string::utf8(b"ACTION_CLAIM");
            *0x2::vec_map::get_mut<0x1::string::String, u64>(0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg1.access_list, &v1), &v11) = v0;
        } else {
            let v12 = 0x2::vec_map::empty<0x1::string::String, u64>();
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v12, 0x1::string::utf8(b"ACTION_CLAIM"), v0);
            0x2::vec_map::insert<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg1.access_list, v1, v12);
        };
        0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::vault::deposit<T0>(v4, arg3, arg4);
        let v13 = ProofOfStake{
            staker                : 0x2::tx_context::sender(arg4),
            stake_token           : 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::utils::get_full_type<T0>(),
            stake_amount          : v5,
            stake_date            : v0,
            unstake_date          : 0x1::option::none<u64>(),
            latest_claim_date     : 0x1::option::none<u64>(),
            profit_claimed_amount : 0,
            stake_package_key     : arg2,
            apr_at_moment         : v3.apr,
            days_at_moment        : v3.days,
            name_at_moment        : v3.name,
        };
        0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::certificate::issue_investment_certificate<ProofOfStake>(arg0, v3.name, v3.image, v3.website, v3.link, v3.description, v13, arg4);
        let v14 = Stake{
            sender       : v1,
            epoch_time   : v0,
            package_key  : arg2,
            apr          : v3.apr,
            days         : v3.days,
            stake_amount : v5,
        };
        0x2::event::emit<Stake>(v14);
    }

    public entry fun unstake<T0>(arg0: &0x2::clock::Clock, arg1: &mut StakingStorage, arg2: &mut 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::certificate::InvestmentCertificate, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::utils::get_full_type<T0>();
        let v3 = 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::certificate::get_mut_df_info<ProofOfStake>(arg2);
        let v4 = 0x2::dynamic_field::borrow<0x1::string::String, StakingPackage<T0>>(&arg1.id, v3.stake_package_key);
        if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg1.access_list, &v1)) {
            let v5 = 0x2::vec_map::get<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg1.access_list, &v1);
            let v6 = 0x1::string::utf8(b"ACTION_CLAIM");
            if (0x2::vec_map::contains<0x1::string::String, u64>(v5, &v6)) {
                let v7 = 0x1::string::utf8(b"ACTION_CLAIM");
                assert!(is_access_granted(v0, *0x2::vec_map::get<0x1::string::String, u64>(v5, &v7), arg1.access_range_limit), 2003);
            };
        };
        assert!(!v4.is_pause, 2002);
        assert!(0x1::option::is_none<u64>(&v3.unstake_date), 2005);
        let v8 = if (0x1::option::is_none<u64>(&v3.latest_claim_date)) {
            v3.stake_date
        } else {
            0x1::option::extract<u64>(&mut v3.latest_claim_date)
        };
        let (v9, v10) = cal_time_and_days(v0, v8);
        let v11 = v10 * cal_profit_per_day(v3.stake_amount, v3.apr_at_moment);
        let v12 = v3.stake_amount + v11;
        let v13 = v12;
        if (v10 < v3.days_at_moment) {
            v13 = v12 - 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::utils::mul_u64_div_decimal(v3.stake_amount, parse_percent(v4.unstake_soon_fee), 9);
        };
        let v14 = 0x2::vec_map::get_mut<0x1::string::String, u64>(0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg1.invest_list, &v1), &v2);
        *v14 = *v14 - v3.stake_amount;
        if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg1.access_list, &v1)) {
            let v15 = 0x1::string::utf8(b"ACTION_CLAIM");
            *0x2::vec_map::get_mut<0x1::string::String, u64>(0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg1.access_list, &v1), &v15) = v0;
        } else {
            let v16 = 0x2::vec_map::empty<0x1::string::String, u64>();
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v16, 0x1::string::utf8(b"ACTION_CLAIM"), v0);
            0x2::vec_map::insert<address, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut arg1.access_list, v1, v16);
        };
        0x1::option::fill<u64>(&mut v3.latest_claim_date, v9);
        0x1::option::fill<u64>(&mut v3.unstake_date, v0);
        v3.profit_claimed_amount = v3.profit_claimed_amount + v11;
        0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::vault::withdraw<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2213087b1533df978ae77401c14a5b54d0daf091eaa0d1b9874c69996811a1ce::vault::Vaults>(&mut arg1.other, 0x1::string::utf8(b"VAULT")), v13, v1, arg3);
        let v17 = Unstake{
            sender           : v1,
            epoch_time       : v0,
            package_key      : v3.stake_package_key,
            apr              : v3.apr_at_moment,
            accumulated_days : v10,
            profit           : v11,
            stake_amount     : v3.stake_amount,
        };
        0x2::event::emit<Unstake>(v17);
    }

    // decompiled from Move bytecode v6
}

