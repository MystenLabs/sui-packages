module 0xced1cbaa5cf3b4527e947ededcf1604758c1376035e12c6d81205c6529b9c675::h {
    struct H has copy, drop {
        u: address,
        h: bool,
        f: u256,
        lv: u256,
        cv: u256,
    }

    public fun get_user_data_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: vector<address>) : vector<H> {
        let v0 = 0x1::vector::empty<H>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = 0x1::vector::borrow<address>(&arg3, v1);
            let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg2, arg1, *v2);
            let v4 = H{
                u  : *v2,
                h  : v3 >= 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray(),
                f  : v3,
                lv : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_loan_value(arg0, arg1, arg2, *v2),
                cv : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_collateral_value(arg0, arg1, arg2, *v2),
            };
            0x2::event::emit<H>(v4);
            0x1::vector::push_back<H>(&mut v0, v4);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

