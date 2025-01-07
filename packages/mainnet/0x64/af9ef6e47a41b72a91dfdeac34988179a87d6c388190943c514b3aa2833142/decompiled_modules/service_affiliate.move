module 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service_affiliate {
    struct Feature has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        affiliate: 0x2::vec_map::VecMap<address, 0x1::string::String>,
    }

    struct Affiliator has drop, store {
        user: address,
        nation: 0x1::string::String,
        affiliate_code: 0x1::string::String,
        is_lock: bool,
        accumulate: 0x2::vec_map::VecMap<0x1::string::String, Fund>,
    }

    struct Fund has drop, store {
        token_type: 0x1::string::String,
        amount: u64,
    }

    public(friend) fun add(arg0: &mut 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::Service, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id        : 0x2::object::new(arg1),
            affiliate : 0x2::vec_map::empty<address, 0x1::string::String>(),
        };
        0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::add_feature<Feature, Config>(arg0, v0);
    }

    public(friend) fun remove(arg0: &mut 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::Service) {
        let Config {
            id        : v0,
            affiliate : _,
        } = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::remove_feature<Feature, Config>(arg0);
        0x2::object::delete(v0);
    }

    public(friend) fun add_affiliator_list(arg0: &mut 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::Service, arg1: 0x2::vec_map::VecMap<address, 0x1::string::String>) {
        let v0 = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::utils::get_key_by_struct<Feature>();
        assert!(0x2::vec_set::contains<0x1::string::String>(0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::features(arg0), &v0), 702);
        let v1 = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::get_feature_mut<Feature, Config>(arg0);
        while (!0x2::vec_map::is_empty<address, 0x1::string::String>(&arg1)) {
            let (v2, v3) = 0x2::vec_map::pop<address, 0x1::string::String>(&mut arg1);
            let v4 = get_affiliate_code(v2, v3);
            if (!0x2::dynamic_field::exists_<0x1::string::String>(&v1.id, v4)) {
                0x2::vec_map::insert<address, 0x1::string::String>(&mut v1.affiliate, v2, v4);
                let v5 = Affiliator{
                    user           : v2,
                    nation         : v3,
                    affiliate_code : v4,
                    is_lock        : false,
                    accumulate     : 0x2::vec_map::empty<0x1::string::String, Fund>(),
                };
                0x2::dynamic_field::add<0x1::string::String, Affiliator>(&mut v1.id, v4, v5);
            };
        };
    }

    public(friend) fun add_profit_by_affiliate<T0>(arg0: &mut 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::Service, arg1: 0x1::string::String, arg2: u64) {
        check_valid_affiliate_code(arg0, arg1);
        let v0 = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::utils::get_full_type<T0>();
        let v1 = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::features(arg0), &v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, Affiliator>(&mut 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::get_feature_mut<Feature, Config>(arg0).id, arg1);
            if (0x2::vec_map::contains<0x1::string::String, Fund>(&v2.accumulate, &v0)) {
                let v3 = 0x2::vec_map::get_mut<0x1::string::String, Fund>(&mut v2.accumulate, &v0);
                v3.amount = v3.amount + arg2;
            } else {
                let v4 = Fund{
                    token_type : v0,
                    amount     : arg2,
                };
                0x2::vec_map::insert<0x1::string::String, Fund>(&mut v2.accumulate, v0, v4);
            };
        };
    }

    public(friend) fun check_valid_affiliate_code(arg0: &0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::Service, arg1: 0x1::string::String) {
        let v0 = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::features(arg0), &v0)) {
            let v1 = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::get_feature<Feature, Config>(arg0);
            assert!(0x2::dynamic_field::exists_<0x1::string::String>(&v1.id, arg1), 700);
            assert!(!0x2::dynamic_field::borrow<0x1::string::String, Affiliator>(&v1.id, arg1).is_lock, 701);
        };
    }

    fun get_affiliate_code(arg0: address, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x2::address::to_string(arg0);
        0x1::string::append(&mut arg1, 0x1::string::sub_string(&v0, 39, 64));
        arg1
    }

    public(friend) fun remove_affiliator_list(arg0: &mut 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::Service, arg1: 0x2::vec_map::VecMap<address, 0x1::string::String>) {
        let v0 = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::utils::get_key_by_struct<Feature>();
        assert!(0x2::vec_set::contains<0x1::string::String>(0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::features(arg0), &v0), 702);
        let v1 = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::service::get_feature_mut<Feature, Config>(arg0);
        while (!0x2::vec_map::is_empty<address, 0x1::string::String>(&arg1)) {
            let (v2, v3) = 0x2::vec_map::pop<address, 0x1::string::String>(&mut arg1);
            let v4 = v2;
            let v5 = get_affiliate_code(v4, v3);
            if (0x2::dynamic_field::exists_<0x1::string::String>(&v1.id, v5)) {
                let (_, _) = 0x2::vec_map::remove<address, 0x1::string::String>(&mut v1.affiliate, &v4);
                0x2::dynamic_field::remove<0x1::string::String, Affiliator>(&mut v1.id, v5);
            };
        };
    }

    // decompiled from Move bytecode v6
}

