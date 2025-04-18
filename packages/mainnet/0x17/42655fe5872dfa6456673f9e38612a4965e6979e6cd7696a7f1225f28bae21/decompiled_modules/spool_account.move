module 0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool_account {
    struct SpoolAccount<phantom T0> has store, key {
        id: 0x2::object::UID,
        spool_id: 0x2::object::ID,
        stake_type: 0x1::type_name::TypeName,
        stakes: 0x2::balance::Balance<T0>,
        points: u64,
        total_points: u64,
        index: u64,
    }

    public(friend) fun new<T0>(arg0: &0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::Spool, arg1: &mut 0x2::tx_context::TxContext) : SpoolAccount<T0> {
        SpoolAccount<T0>{
            id           : 0x2::object::new(arg1),
            spool_id     : 0x2::object::id<0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::Spool>(arg0),
            stake_type   : 0x1::type_name::get<T0>(),
            stakes       : 0x2::balance::zero<T0>(),
            points       : 0,
            total_points : 0,
            index        : 0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::index(arg0),
        }
    }

    public(friend) fun accrue_points<T0>(arg0: &0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::Spool, arg1: &mut SpoolAccount<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::is_points_up_to_date(arg0, arg2), 18);
        if (arg1.index >= 0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::index(arg0)) {
            return
        };
        if (0x2::balance::value<T0>(&arg1.stakes) == 0) {
            arg1.index = 0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::index(arg0);
            return
        };
        let v0 = 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::u64::mul_div(0x2::balance::value<T0>(&arg1.stakes), 0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::index(arg0) - arg1.index, 0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::base_index_rate());
        arg1.index = 0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::index(arg0);
        arg1.points = arg1.points + v0;
        arg1.total_points = arg1.total_points + v0;
    }

    public fun assert_pool_id<T0>(arg0: &0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::Spool, arg1: &SpoolAccount<T0>) {
        assert!(arg1.spool_id == 0x2::object::id<0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::Spool>(arg0), 19);
    }

    public fun points<T0>(arg0: &SpoolAccount<T0>) : u64 {
        arg0.points
    }

    public(friend) fun redeem_point<T0>(arg0: &mut SpoolAccount<T0>, arg1: u64) {
        arg0.points = arg0.points - arg1;
    }

    public fun spool_id<T0>(arg0: &SpoolAccount<T0>) : 0x2::object::ID {
        arg0.spool_id
    }

    public(friend) fun stake<T0>(arg0: &0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::Spool, arg1: &mut SpoolAccount<T0>, arg2: 0x2::balance::Balance<T0>) {
        assert!(arg1.index == 0x1742655fe5872dfa6456673f9e38612a4965e6979e6cd7696a7f1225f28bae21::spool::index(arg0), 17);
        0x2::balance::join<T0>(&mut arg1.stakes, arg2);
    }

    public fun stake_amount<T0>(arg0: &SpoolAccount<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.stakes)
    }

    public fun stake_type<T0>(arg0: &SpoolAccount<T0>) : 0x1::type_name::TypeName {
        arg0.stake_type
    }

    public fun total_points<T0>(arg0: &SpoolAccount<T0>) : u64 {
        arg0.total_points
    }

    public(friend) fun unstake<T0>(arg0: &mut SpoolAccount<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.stakes, arg1)
    }

    // decompiled from Move bytecode v6
}

