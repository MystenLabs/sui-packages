module 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::eval {
    struct HandRank has copy, drop, store {
        class: u8,
        values: vector<u8>,
    }

    public fun best_of_seven(arg0: &vector<u8>) : HandRank {
        assert!(0x1::vector::length<u8>(arg0) == 7, 13906834414861549567);
        let v0 = HandRank{
            class  : 0,
            values : x"0000000000",
        };
        let v1 = true;
        let v2 = 0;
        while (v2 < 7) {
            let v3 = v2 + 1;
            while (v3 < 7) {
                let v4 = b"";
                let v5 = 0;
                while (v5 < 7) {
                    if (v5 != v2 && v5 != v3) {
                        0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg0, v5));
                    };
                    v5 = v5 + 1;
                };
                let v6 = evaluate_five(&v4);
                if (v1 || hand_rank_cmp(&v6, &v0) == 2) {
                    v0 = v6;
                    v1 = false;
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun build_groups(arg0: &vector<u8>) : (vector<u8>, vector<u8>) {
        let v0 = b"";
        let v1 = b"";
        let v2 = 14;
        loop {
            let v3 = *0x1::vector::borrow<u8>(arg0, (v2 as u64));
            if (v3 > 0) {
                0x1::vector::push_back<u8>(&mut v0, v3);
                0x1::vector::push_back<u8>(&mut v1, v2);
            };
            if (v2 == 2) {
                break
            };
            v2 = v2 - 1;
        };
        let v4 = &mut v0;
        let v5 = &mut v1;
        stable_sort_by_key_desc(v4, v5);
        (v0, v1)
    }

    public fun evaluate_five(arg0: &vector<u8>) : HandRank {
        assert!(0x1::vector::length<u8>(arg0) == 5, 13906834535120633855);
        let v0 = x"000000000000000000000000000000";
        let v1 = b"";
        let v2 = b"";
        let v3 = 0;
        while (v3 < 5) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::types::card_rank(v4);
            0x1::vector::push_back<u8>(&mut v1, v5);
            0x1::vector::push_back<u8>(&mut v2, 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::types::card_suit(v4));
            *0x1::vector::borrow_mut<u8>(&mut v0, (v5 as u64)) = *0x1::vector::borrow<u8>(&v0, (v5 as u64)) + 1;
            v3 = v3 + 1;
        };
        let v6 = &mut v1;
        sort_desc_u8(v6);
        let v7 = if (*0x1::vector::borrow<u8>(&v2, 0) == *0x1::vector::borrow<u8>(&v2, 1)) {
            if (*0x1::vector::borrow<u8>(&v2, 1) == *0x1::vector::borrow<u8>(&v2, 2)) {
                if (*0x1::vector::borrow<u8>(&v2, 2) == *0x1::vector::borrow<u8>(&v2, 3)) {
                    *0x1::vector::borrow<u8>(&v2, 3) == *0x1::vector::borrow<u8>(&v2, 4)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v8 = find_straight_high(&v0);
        if (v7 && v8 > 0) {
            let v9 = 0x1::vector::empty<u8>();
            let v10 = &mut v9;
            0x1::vector::push_back<u8>(v10, v8);
            0x1::vector::push_back<u8>(v10, 0);
            0x1::vector::push_back<u8>(v10, 0);
            0x1::vector::push_back<u8>(v10, 0);
            0x1::vector::push_back<u8>(v10, 0);
            return HandRank{
                class  : 8,
                values : v9,
            }
        };
        let (v11, v12) = build_groups(&v0);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x1::vector::length<u8>(&v14);
        if (v15 == 2 && *0x1::vector::borrow<u8>(&v14, 0) == 4) {
            let v16 = 0x1::vector::empty<u8>();
            let v17 = &mut v16;
            0x1::vector::push_back<u8>(v17, *0x1::vector::borrow<u8>(&v13, 0));
            0x1::vector::push_back<u8>(v17, *0x1::vector::borrow<u8>(&v13, 1));
            0x1::vector::push_back<u8>(v17, 0);
            0x1::vector::push_back<u8>(v17, 0);
            0x1::vector::push_back<u8>(v17, 0);
            return HandRank{
                class  : 7,
                values : v16,
            }
        };
        if (v15 == 2 && *0x1::vector::borrow<u8>(&v14, 0) == 3) {
            let v18 = 0x1::vector::empty<u8>();
            let v19 = &mut v18;
            0x1::vector::push_back<u8>(v19, *0x1::vector::borrow<u8>(&v13, 0));
            0x1::vector::push_back<u8>(v19, *0x1::vector::borrow<u8>(&v13, 1));
            0x1::vector::push_back<u8>(v19, 0);
            0x1::vector::push_back<u8>(v19, 0);
            0x1::vector::push_back<u8>(v19, 0);
            return HandRank{
                class  : 6,
                values : v18,
            }
        };
        if (v7) {
            return HandRank{
                class  : 5,
                values : v1,
            }
        };
        if (v8 > 0) {
            let v20 = 0x1::vector::empty<u8>();
            let v21 = &mut v20;
            0x1::vector::push_back<u8>(v21, v8);
            0x1::vector::push_back<u8>(v21, 0);
            0x1::vector::push_back<u8>(v21, 0);
            0x1::vector::push_back<u8>(v21, 0);
            0x1::vector::push_back<u8>(v21, 0);
            return HandRank{
                class  : 4,
                values : v20,
            }
        };
        if (*0x1::vector::borrow<u8>(&v14, 0) == 3) {
            let v22 = 0x1::vector::empty<u8>();
            let v23 = &mut v22;
            0x1::vector::push_back<u8>(v23, *0x1::vector::borrow<u8>(&v13, 0));
            0x1::vector::push_back<u8>(v23, *0x1::vector::borrow<u8>(&v13, 1));
            0x1::vector::push_back<u8>(v23, *0x1::vector::borrow<u8>(&v13, 2));
            0x1::vector::push_back<u8>(v23, 0);
            0x1::vector::push_back<u8>(v23, 0);
            return HandRank{
                class  : 3,
                values : v22,
            }
        };
        let v24 = if (v15 == 3) {
            if (*0x1::vector::borrow<u8>(&v14, 0) == 2) {
                *0x1::vector::borrow<u8>(&v14, 1) == 2
            } else {
                false
            }
        } else {
            false
        };
        if (v24) {
            let v25 = 0x1::vector::empty<u8>();
            let v26 = &mut v25;
            0x1::vector::push_back<u8>(v26, *0x1::vector::borrow<u8>(&v13, 0));
            0x1::vector::push_back<u8>(v26, *0x1::vector::borrow<u8>(&v13, 1));
            0x1::vector::push_back<u8>(v26, *0x1::vector::borrow<u8>(&v13, 2));
            0x1::vector::push_back<u8>(v26, 0);
            0x1::vector::push_back<u8>(v26, 0);
            return HandRank{
                class  : 2,
                values : v25,
            }
        };
        if (*0x1::vector::borrow<u8>(&v14, 0) == 2) {
            let v27 = 0x1::vector::empty<u8>();
            let v28 = &mut v27;
            0x1::vector::push_back<u8>(v28, *0x1::vector::borrow<u8>(&v13, 0));
            0x1::vector::push_back<u8>(v28, *0x1::vector::borrow<u8>(&v13, 1));
            0x1::vector::push_back<u8>(v28, *0x1::vector::borrow<u8>(&v13, 2));
            0x1::vector::push_back<u8>(v28, *0x1::vector::borrow<u8>(&v13, 3));
            0x1::vector::push_back<u8>(v28, 0);
            return HandRank{
                class  : 1,
                values : v27,
            }
        };
        HandRank{
            class  : 0,
            values : v1,
        }
    }

    fun find_straight_high(arg0: &vector<u8>) : u8 {
        let v0 = 14;
        while (v0 >= 5) {
            let v1 = if (v0 == 5) {
                if (*0x1::vector::borrow<u8>(arg0, 14) > 0) {
                    if (*0x1::vector::borrow<u8>(arg0, 2) > 0) {
                        if (*0x1::vector::borrow<u8>(arg0, 3) > 0) {
                            if (*0x1::vector::borrow<u8>(arg0, 4) > 0) {
                                *0x1::vector::borrow<u8>(arg0, 5) > 0
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
                }
            } else if (*0x1::vector::borrow<u8>(arg0, (v0 as u64)) > 0) {
                if (*0x1::vector::borrow<u8>(arg0, ((v0 - 1) as u64)) > 0) {
                    if (*0x1::vector::borrow<u8>(arg0, ((v0 - 2) as u64)) > 0) {
                        if (*0x1::vector::borrow<u8>(arg0, ((v0 - 3) as u64)) > 0) {
                            *0x1::vector::borrow<u8>(arg0, ((v0 - 4) as u64)) > 0
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
            if (v1) {
                return v0
            };
            v0 = v0 - 1;
        };
        0
    }

    public fun hand_rank_cmp(arg0: &HandRank, arg1: &HandRank) : u8 {
        if (arg0.class > arg1.class) {
            return 2
        };
        if (arg0.class < arg1.class) {
            return 0
        };
        let v0 = 0;
        while (v0 < 5) {
            let v1 = *0x1::vector::borrow<u8>(&arg0.values, v0);
            let v2 = *0x1::vector::borrow<u8>(&arg1.values, v0);
            if (v1 > v2) {
                return 2
            };
            if (v1 < v2) {
                return 0
            };
            v0 = v0 + 1;
        };
        1
    }

    public fun hr_class(arg0: &HandRank) : u8 {
        arg0.class
    }

    public fun hr_values(arg0: &HandRank) : &vector<u8> {
        &arg0.values
    }

    fun sort_desc_u8(arg0: &mut vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 <= 1) {
            return
        };
        let v1 = 1;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            let v3 = v1;
            while (v3 > 0 && *0x1::vector::borrow<u8>(arg0, v3 - 1) < v2) {
                *0x1::vector::borrow_mut<u8>(arg0, v3) = *0x1::vector::borrow<u8>(arg0, v3 - 1);
                v3 = v3 - 1;
            };
            *0x1::vector::borrow_mut<u8>(arg0, v3) = v2;
            v1 = v1 + 1;
        };
    }

    fun stable_sort_by_key_desc(arg0: &mut vector<u8>, arg1: &mut vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 <= 1) {
            return
        };
        let v1 = 1;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            let v3 = v1;
            while (v3 > 0 && *0x1::vector::borrow<u8>(arg0, v3 - 1) < v2) {
                *0x1::vector::borrow_mut<u8>(arg0, v3) = *0x1::vector::borrow<u8>(arg0, v3 - 1);
                *0x1::vector::borrow_mut<u8>(arg1, v3) = *0x1::vector::borrow<u8>(arg1, v3 - 1);
                v3 = v3 - 1;
            };
            *0x1::vector::borrow_mut<u8>(arg0, v3) = v2;
            *0x1::vector::borrow_mut<u8>(arg1, v3) = *0x1::vector::borrow<u8>(arg1, v1);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

