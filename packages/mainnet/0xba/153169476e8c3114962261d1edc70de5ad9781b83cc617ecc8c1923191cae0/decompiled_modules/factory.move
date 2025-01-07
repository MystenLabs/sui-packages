module 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory {
    struct Container has key {
        id: 0x2::object::UID,
        pairs: 0x2::bag::Bag,
        treasury: 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::treasury::Treasury,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PairCreated has copy, drop {
        user: address,
        pair: 0x1::string::String,
        coin_x: 0x1::string::String,
        coin_y: 0x1::string::String,
    }

    struct FeeChanged has copy, drop {
        user: address,
        coin_x: 0x1::string::String,
        coin_y: 0x1::string::String,
        fee_rate: u64,
    }

    public fun borrow_mut_pair<T0, T1>(arg0: &mut Container) : &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1> {
        assert!(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>(), 1);
        0x2::bag::borrow_mut<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>>(&mut arg0.pairs, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T0, T1>())
    }

    public fun borrow_mut_pair_and_treasury<T0, T1>(arg0: &mut Container) : (&mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::treasury::Treasury) {
        assert!(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>(), 1);
        (0x2::bag::borrow_mut<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>>(&mut arg0.pairs, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T0, T1>()), &arg0.treasury)
    }

    public fun borrow_pair<T0, T1>(arg0: &Container) : &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1> {
        assert!(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>(), 1);
        0x2::bag::borrow<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>>(&arg0.pairs, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T0, T1>())
    }

    public fun borrow_treasury(arg0: &Container) : &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::treasury::Treasury {
        &arg0.treasury
    }

    public fun create_pair<T0, T1>(arg0: &mut Container, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>()) {
            let v1 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T0, T1>();
            assert!(!0x2::bag::contains_with_type<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>>(&arg0.pairs, v1), 0);
            0x2::bag::add<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>>(&mut arg0.pairs, v1, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::create_pair<T0, T1>(arg1));
            v1
        } else {
            let v2 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T1, T0>();
            assert!(!0x2::bag::contains_with_type<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>>(&arg0.pairs, v2), 0);
            0x2::bag::add<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>>(&mut arg0.pairs, v2, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::create_pair<T1, T0>(arg1));
            v2
        };
        let v3 = PairCreated{
            user   : 0x2::tx_context::sender(arg1),
            pair   : v0,
            coin_x : 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::type_helper::get_type_name<T0>(),
            coin_y : 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::type_helper::get_type_name<T1>(),
        };
        0x2::event::emit<PairCreated>(v3);
        set_fee_rate_<T0, T1>(arg0, 30, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Container{
            id       : 0x2::object::new(arg0),
            pairs    : 0x2::bag::new(arg0),
            treasury : 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::treasury::new(@0x0),
        };
        0x2::transfer::share_object<Container>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun pair_is_created<T0, T1>(arg0: &Container) : bool {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>() && 0x2::bag::contains_with_type<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>>(&arg0.pairs, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T0, T1>()) || 0x2::bag::contains_with_type<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>>(&arg0.pairs, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T1, T0>())
    }

    public entry fun set_fee_rate<T0, T1>(arg0: &mut AdminCap, arg1: &mut Container, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        set_fee_rate_<T0, T1>(arg1, arg2, arg3);
    }

    fun set_fee_rate_<T0, T1>(arg0: &mut Container, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>()) {
            0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::set_fee_rate<T0, T1>(0x2::bag::borrow_mut<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>>(&mut arg0.pairs, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T0, T1>()), arg1);
        } else {
            0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::set_fee_rate<T1, T0>(0x2::bag::borrow_mut<0x1::string::String, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>>(&mut arg0.pairs, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T1, T0>()), arg1);
        };
        let v0 = FeeChanged{
            user     : 0x2::tx_context::sender(arg2),
            coin_x   : 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::type_helper::get_type_name<T0>(),
            coin_y   : 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::type_helper::get_type_name<T1>(),
            fee_rate : arg1,
        };
        0x2::event::emit<FeeChanged>(v0);
    }

    public entry fun set_fee_to(arg0: &mut AdminCap, arg1: &mut Container, arg2: address) {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::treasury::appoint(&mut arg1.treasury, arg2);
    }

    // decompiled from Move bytecode v6
}

