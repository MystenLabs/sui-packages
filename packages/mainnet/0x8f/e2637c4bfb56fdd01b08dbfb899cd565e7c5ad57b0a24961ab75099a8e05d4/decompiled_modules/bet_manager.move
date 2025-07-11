module 0x8fe2637c4bfb56fdd01b08dbfb899cd565e7c5ad57b0a24961ab75099a8e05d4::bet_manager {
    struct BetManager has drop, store {
        house_edge: u64,
        combo_edge: u64,
    }

    struct BetSetting has drop, store {
        odd_weights: 0x2::vec_map::VecMap<u64, u64>,
    }

    struct Placement has copy, drop, store {
        marble_id: u64,
        rank_index: u8,
    }

    public fun create_unihouse_placement(arg0: Placement) : 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::Placement {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::create_placement(arg0.marble_id, arg0.rank_index)
    }

    public(friend) fun get_bet_payout(arg0: &BetManager, arg1: &BetSetting, arg2: u64, arg3: vector<Placement>, arg4: vector<u64>) : (u64, u64) {
        let v0 = 0;
        let v1 = arg2;
        let v2 = arg0.house_edge;
        let v3 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::precision();
        let v4 = 0x1::vector::length<u64>(&arg4);
        while (v0 < 0x1::vector::length<Placement>(&arg3)) {
            let (v5, v6) = get_placement_data(0x1::vector::borrow<Placement>(&arg3, v0));
            let v7 = v5;
            assert!(0x1::vector::contains<u64>(&arg4, &v7), 1);
            assert!((v6 as u64) < v4, 2);
            let v8 = v1 * 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_rate(v4, v3 - v2 - v0 * arg0.combo_edge);
            v1 = v8 * *0x2::vec_map::get<u64, u64>(&arg1.odd_weights, &v7);
            v0 = v0 + 1;
        };
        (v1, arg2 * 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_rate(v4, v3 - v2))
    }

    public fun get_house_edge(arg0: &BetManager) : u64 {
        arg0.house_edge
    }

    public fun get_placement_data(arg0: &Placement) : (u64, u8) {
        (arg0.marble_id, arg0.rank_index)
    }

    public(friend) fun new_bet_manager() : BetManager {
        BetManager{
            house_edge : 50000,
            combo_edge : 50000,
        }
    }

    public(friend) fun new_bet_setting(arg0: vector<u64>) : BetSetting {
        let v0 = 0x2::vec_map::empty<u64, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x2::vec_map::insert<u64, u64>(&mut v0, *0x1::vector::borrow<u64>(&arg0, v1), 1);
            v1 = v1 + 1;
        };
        BetSetting{odd_weights: v0}
    }

    public(friend) fun new_placement(arg0: u64, arg1: u8) : Placement {
        Placement{
            marble_id  : arg0,
            rank_index : arg1,
        }
    }

    public(friend) fun set_house_edge(arg0: &mut BetManager, arg1: u64) {
        arg0.house_edge = arg1;
    }

    public(friend) fun won_bet(arg0: vector<Placement>, arg1: vector<u64>) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Placement>(&arg0)) {
            v0 = false;
            let v2 = *0x1::vector::borrow<Placement>(&arg0, v1);
            if (v2.marble_id == *0x1::vector::borrow<u64>(&arg1, (v2.rank_index as u64))) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

