module 0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::battle {
    struct BattleResult has copy, drop {
        battle_id: address,
        winner: address,
        loser: address,
        winner_payout: u64,
        house_rake: u64,
        p1_final_hp: u64,
        p2_final_hp: u64,
        rounds: u64,
    }

    struct Battle has key {
        id: 0x2::object::UID,
        player1: address,
        player2: address,
        stake_amount: u64,
        round: u64,
        p1_hp: u64,
        p2_hp: u64,
        resolved: bool,
    }

    public fun resolve(arg0: &mut 0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::Spaceship, arg1: &mut 0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::Spaceship, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: address, arg6: vector<u8>, arg7: vector<u8>, arg8: address, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 0);
        assert!(0x1::vector::length<u8>(&arg6) == 5, 1);
        assert!(0x1::vector::length<u8>(&arg7) == 5, 1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg2, arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = 0x2::random::new_generator(arg9, arg10);
        let v3 = 0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::get_hull(arg0);
        let v4 = 0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::get_hull(arg1);
        let v5 = 0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::get_shield(arg0);
        let v6 = 0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::get_shield(arg1);
        let v7 = 0;
        let v8 = 0;
        while (v8 < 5) {
            let v9 = *0x1::vector::borrow<u8>(&arg6, v8);
            let v10 = *0x1::vector::borrow<u8>(&arg7, v8);
            let v11 = v9 == 2 && 0x2::random::generate_u8_in_range(&mut v2, 0, 99) < 40;
            let v12 = v10 == 2 && 0x2::random::generate_u8_in_range(&mut v2, 0, 99) < 40;
            let v13 = 0;
            if (v9 == 0) {
                let v14 = if (0x2::random::generate_u8_in_range(&mut v2, 0, 99) < 25) {
                    0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::get_laser(arg0) * 2
                } else {
                    0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::get_laser(arg0)
                };
                v13 = v14;
                if (v10 == 1) {
                    let v15 = v14 * v6 / (v6 + 50);
                    let v16 = if (v14 > v15) {
                        v14 - v15
                    } else {
                        0
                    };
                    v13 = v16;
                };
                if (v12) {
                    v13 = 0;
                };
            };
            let v17 = 0;
            if (v10 == 0) {
                let v18 = if (0x2::random::generate_u8_in_range(&mut v2, 0, 99) < 25) {
                    0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::get_laser(arg1) * 2
                } else {
                    0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::get_laser(arg1)
                };
                v17 = v18;
                if (v9 == 1) {
                    let v19 = v18 * v5 / (v5 + 50);
                    let v20 = if (v18 > v19) {
                        v18 - v19
                    } else {
                        0
                    };
                    v17 = v20;
                };
                if (v11) {
                    v17 = 0;
                };
            };
            let v21 = if (v3 > v17) {
                v3 - v17
            } else {
                0
            };
            v3 = v21;
            let v22 = if (v4 > v13) {
                v4 - v13
            } else {
                0
            };
            v4 = v22;
            v7 = v7 + 1;
            if (v21 == 0 || v22 == 0) {
                v8 = 5;
                continue
            };
            v8 = v8 + 1;
        };
        let v23 = v1 * 300 / 10000;
        let v24 = v3 >= v4;
        let v25 = if (v24) {
            arg4
        } else {
            arg5
        };
        let v26 = if (v24) {
            arg5
        } else {
            arg4
        };
        0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::record_match(arg0, v24);
        0x25043baa4f913b2d76e2efbeb6c60043c9c04139bdc705cef52a1de96483bf65::spaceship::record_match(arg1, !v24);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v23, arg10), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v25);
        let v27 = 0x2::object::new(arg10);
        0x2::object::delete(v27);
        let v28 = BattleResult{
            battle_id     : 0x2::object::uid_to_address(&v27),
            winner        : v25,
            loser         : v26,
            winner_payout : v1 - v23,
            house_rake    : v23,
            p1_final_hp   : v3,
            p2_final_hp   : v4,
            rounds        : v7,
        };
        0x2::event::emit<BattleResult>(v28);
    }

    // decompiled from Move bytecode v6
}

