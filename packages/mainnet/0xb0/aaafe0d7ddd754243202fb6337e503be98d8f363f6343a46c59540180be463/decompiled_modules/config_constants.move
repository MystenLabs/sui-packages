module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants {
    public(friend) fun chk_att(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 3, 17);
    }

    public(friend) fun chk_bands(arg0: &vector<u64>) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 % 3 == 0 && v0 <= 24, 29);
        let v1 = 1000000000;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(arg0, v2);
            let v4 = *0x1::vector::borrow<u64>(arg0, v2 + 1);
            let v5 = *0x1::vector::borrow<u64>(arg0, v2 + 2);
            let v6 = if (v3 >= 0) {
                if (v3 < v4) {
                    if (v4 <= v1) {
                        if (v5 >= v1) {
                            v5 <= 10000000000
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v6, 29);
            v2 = v2 + 3;
        };
    }

    public(friend) fun chk_base(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 1000000000, 0);
    }

    public(friend) fun chk_bcap(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 28);
    }

    public(friend) fun chk_bs_age(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 60000, 5);
    }

    public(friend) fun chk_cad(arg0: u64) {
        assert!(arg0 <= 10, 15);
    }

    public(friend) fun chk_impact(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 21);
    }

    public(friend) fun chk_lambda(arg0: u64) {
        assert!(arg0 >= 50000000 && arg0 <= 1000000000, 14);
    }

    public(friend) fun chk_life(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 27);
    }

    public(friend) fun chk_live(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 26);
    }

    public(friend) fun chk_maxp(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 999999999, 3);
    }

    public(friend) fun chk_mfee(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 1);
    }

    public(friend) fun chk_minp(arg0: u64) {
        assert!(arg0 >= 10000000 && arg0 <= 999999999, 2);
    }

    public(friend) fun chk_mult(arg0: u64) {
        assert!(arg0 >= 1000000000 && arg0 <= 10000000000, 9);
    }

    public(friend) fun chk_nt(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 15000, 24);
    }

    public(friend) fun chk_pool(arg0: u64) {
        assert!(arg0 >= 20000000 && arg0 <= 18446744073709551615, 18);
    }

    public(friend) fun chk_pyage(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 60000, 4);
    }

    public(friend) fun chk_ref(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 250000000, 22);
    }

    public(friend) fun chk_rsv(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 6);
    }

    public(friend) fun chk_sub(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 500000000, 25);
    }

    public(friend) fun chk_sup(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 50000000, 19);
    }

    public(friend) fun chk_svi(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 120000, 7);
    }

    public(friend) fun chk_ticks(arg0: u64) {
        assert!(arg0 > 0 && arg0 % 10000 == 0, 10);
        assert!(arg0 <= 17179869200, 16);
    }

    public(friend) fun chk_vw(arg0: u64) {
        assert!(arg0 >= 60000 && arg0 <= 14400000, 23);
    }

    public(friend) fun chk_wd_fee(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 50000000, 20);
    }

    public(friend) fun chk_win(arg0: u64) {
        assert!(arg0 >= 60000 && arg0 <= 31536000000, 8);
    }

    // decompiled from Move bytecode v7
}

