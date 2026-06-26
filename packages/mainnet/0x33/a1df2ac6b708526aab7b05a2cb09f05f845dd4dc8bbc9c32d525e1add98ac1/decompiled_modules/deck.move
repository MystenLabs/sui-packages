module 0x33a1df2ac6b708526aab7b05a2cb09f05f845dd4dc8bbc9c32d525e1add98ac1::deck {
    public fun burn_card(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: address, arg3: &mut u64) {
        draw_card(arg0, arg1, arg2, arg3);
    }

    fun card_from_rank_suit(arg0: u8, arg1: u8) : u8 {
        (arg0 - 2) * 4 + arg1
    }

    fun copy_deck(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun deal_preflop_pressure_runout(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: address, arg3: &mut u64, arg4: u8, arg5: u64) : (vector<u8>, vector<u8>) {
        assert!(arg4 < 2, 13906834371912138757);
        assert!(arg5 == 12000, 13906834376207106053);
        let v0 = sample_preflop_pressure_holes(arg1, arg2, arg3, arg4, arg5);
        remove_card(arg0, *0x1::vector::borrow<u8>(&v0, 0));
        remove_card(arg0, *0x1::vector::borrow<u8>(&v0, 1));
        remove_card(arg0, *0x1::vector::borrow<u8>(&v0, 2));
        remove_card(arg0, *0x1::vector::borrow<u8>(&v0, 3));
        let v1 = copy_deck(arg0);
        let v2 = sample_flop(arg0, &v1, arg1, arg2, arg3);
        let v3 = draw_card(arg0, arg1, arg2, arg3);
        0x1::vector::push_back<u8>(&mut v2, v3);
        0x1::vector::push_back<u8>(&mut v2, draw_card(arg0, arg1, arg2, arg3));
        (v0, v2)
    }

    fun deck_position(arg0: &vector<u8>, arg1: u8) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        0x1::vector::length<u8>(arg0)
    }

    public fun derive_entropy(arg0: &vector<u8>, arg1: address, arg2: u64) : u64 {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 & 255) as u8));
        let v1 = 0x2::hash::blake2b256(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 8) {
            let v4 = v2 << 8;
            v2 = v4 | (*0x1::vector::borrow<u8>(&v1, v3) as u64);
            v3 = v3 + 1;
        };
        v2
    }

    public fun draw_card(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: address, arg3: &mut u64) : u8 {
        *arg3 = *arg3 + 1;
        0x1::vector::swap_remove<u8>(arg0, derive_entropy(arg1, arg2, *arg3) % (0x1::vector::length<u8>(arg0) as u64))
    }

    fun exp_anchor(arg0: u64) : u128 {
        if (arg0 == 0) {
            1000000000
        } else if (arg0 == 1) {
            1648721271
        } else if (arg0 == 2) {
            2718281828
        } else if (arg0 == 3) {
            4481689070
        } else if (arg0 == 4) {
            7389056099
        } else if (arg0 == 5) {
            12182493961
        } else if (arg0 == 6) {
            20085536923
        } else if (arg0 == 7) {
            33115451959
        } else if (arg0 == 8) {
            54598150033
        } else if (arg0 == 9) {
            90017131301
        } else if (arg0 == 10) {
            148413159103
        } else if (arg0 == 11) {
            244691932264
        } else if (arg0 == 12) {
            403428793493
        } else if (arg0 == 13) {
            665141633044
        } else if (arg0 == 14) {
            1096633158428
        } else if (arg0 == 15) {
            1808042414456
        } else if (arg0 == 16) {
            2980957987042
        } else if (arg0 == 17) {
            4914768840299
        } else if (arg0 == 18) {
            8103083927575
        } else if (arg0 == 19) {
            13359726829662
        } else if (arg0 == 20) {
            22026465794807
        } else if (arg0 == 21) {
            36315502674246
        } else if (arg0 == 22) {
            59874141715197
        } else if (arg0 == 23) {
            98715771010760
        } else if (arg0 == 24) {
            162754791419003
        } else if (arg0 == 25) {
            268337286520874
        } else if (arg0 == 26) {
            442413392008920
        } else if (arg0 == 27) {
            729416369847701
        } else if (arg0 == 28) {
            1202604284164776
        } else if (arg0 == 29) {
            1982759263537568
        } else {
            3269017372472110
        }
    }

    fun exp_weight(arg0: u64) : u128 {
        if (arg0 >= 12000) {
            return exp_anchor(12000 / 500)
        };
        let v0 = arg0 / 500;
        let v1 = exp_anchor(v0);
        v1 + (exp_anchor(v0 + 1) - v1) * ((arg0 % 500) as u128) / 500
    }

    fun holes_are_disjoint(arg0: u8, arg1: u8, arg2: u8, arg3: u8) : bool {
        if (arg0 != arg2) {
            if (arg0 != arg3) {
                if (arg1 != arg2) {
                    arg1 != arg3
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun min_u16(arg0: u16, arg1: u16) : u16 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun pair_suits(arg0: u8) : (u8, u8) {
        let (v0, v1) = if (arg0 == 0) {
            (1, 0)
        } else {
            let (v2, v3) = if (arg0 == 1) {
                (0, 2)
            } else if (arg0 == 2) {
                (0, 3)
            } else if (arg0 == 3) {
                (1, 2)
            } else if (arg0 == 4) {
                (1, 3)
            } else {
                (2, 3)
            };
            (v3, v2)
        };
        (v1, v0)
    }

    fun pick_u128(arg0: &vector<u8>, arg1: address, arg2: &mut u64, arg3: u128) : u128 {
        assert!(arg3 > 0, 13906837030496632833);
        *arg2 = *arg2 + 1;
        *arg2 = *arg2 + 1;
        ((derive_entropy(arg0, arg1, *arg2) as u128) * 18446744073709551616 + (derive_entropy(arg0, arg1, *arg2) as u128)) % arg3
    }

    fun preflop_big_blind_score(arg0: u8, arg1: u8) : u16 {
        if (arg0 == 0) {
            row13(arg1, 1000, 998, 963, 959, 879, 868, 813, 827, 779, 799, 798, 818, 762)
        } else if (arg0 == 1) {
            row13(arg1, 993, 1000, 901, 787, 724, 781, 754, 754, 645, 730, 627, 617, 552)
        } else if (arg0 == 2) {
            row13(arg1, 911, 841, 1000, 771, 816, 744, 814, 691, 676, 655, 539, 495, 486)
        } else if (arg0 == 3) {
            row13(arg1, 796, 777, 789, 998, 857, 826, 699, 773, 621, 640, 593, 419, 330)
        } else if (arg0 == 4) {
            row13(arg1, 820, 765, 756, 742, 985, 834, 737, 706, 657, 632, 491, 386, 290)
        } else if (arg0 == 5) {
            row13(arg1, 775, 737, 688, 677, 652, 911, 771, 760, 595, 520, 431, 354, 282)
        } else if (arg0 == 6) {
            row13(arg1, 745, 616, 488, 522, 588, 561, 853, 703, 612, 524, 431, 305, 304)
        } else if (arg0 == 7) {
            row13(arg1, 740, 536, 410, 397, 437, 502, 469, 842, 657, 457, 366, 359, 249)
        } else if (arg0 == 8) {
            row13(arg1, 693, 520, 371, 353, 304, 291, 332, 331, 829, 491, 368, 289, 288)
        } else if (arg0 == 9) {
            row13(arg1, 679, 471, 416, 258, 246, 207, 206, 244, 330, 834, 424, 291, 283)
        } else if (arg0 == 10) {
            row13(arg1, 615, 427, 309, 229, 253, 197, 192, 205, 251, 198, 755, 325, 267)
        } else if (arg0 == 11) {
            row13(arg1, 628, 387, 276, 251, 205, 207, 173, 213, 200, 202, 170, 802, 213)
        } else {
            row13(arg1, 677, 447, 325, 255, 262, 196, 194, 220, 195, 186, 187, 211, 763)
        }
    }

    fun preflop_class_combo_count(arg0: u8, arg1: u8) : u8 {
        assert!(arg0 < 13 && arg1 < 13, 13906836772798857221);
        if (arg0 == arg1) {
            6
        } else if (arg0 < arg1) {
            4
        } else {
            12
        }
    }

    fun preflop_class_contains_rank(arg0: u8, arg1: u8, arg2: u8) : bool {
        arg0 == arg2 || arg1 == arg2
    }

    fun preflop_class_coords(arg0: u64) : (u8, u8) {
        (((arg0 / 13) as u8), ((arg0 % 13) as u8))
    }

    fun preflop_class_exact_combo(arg0: u8, arg1: u8, arg2: u8) : (u8, u8) {
        assert!(arg2 < preflop_class_combo_count(arg0, arg1), 13906835200840826885);
        if (arg0 == arg1) {
            let (v2, v3) = pair_suits(arg2);
            let v4 = rank_from_index(arg0);
            (card_from_rank_suit(v4, v2), card_from_rank_suit(v4, v3))
        } else if (arg0 < arg1) {
            (card_from_rank_suit(rank_from_index(arg0), arg2), card_from_rank_suit(rank_from_index(arg1), arg2))
        } else {
            let v5 = arg2 / 3;
            let v6 = arg2 % 3;
            let v7 = if (v6 < v5) {
                v6
            } else {
                v6 + 1
            };
            (card_from_rank_suit(rank_from_index(arg1), v5), card_from_rank_suit(rank_from_index(arg0), v7))
        }
    }

    fun preflop_class_pair_legal_deals(arg0: u8, arg1: u8, arg2: u8, arg3: u8) : u16 {
        let v0 = preflop_class_shape(arg0, arg1);
        let v1 = preflop_class_shape(arg2, arg3);
        let v2 = preflop_class_rank_overlap(arg0, arg1, arg2, arg3);
        if (v2 == 0) {
            return (preflop_class_combo_count(arg0, arg1) as u16) * (preflop_class_combo_count(arg2, arg3) as u16)
        };
        if (v0 == 0 && v1 == 0) {
            6
        } else if (v0 == 0) {
            if (v1 == 1) {
                12
            } else {
                36
            }
        } else if (v1 == 0) {
            if (v0 == 1) {
                12
            } else {
                36
            }
        } else if (v0 == 1 && v1 == 1) {
            12
        } else if (v0 == 1 && v1 == 2) {
            if (v2 == 2) {
                24
            } else {
                36
            }
        } else if (v0 == 2 && v1 == 1) {
            if (v2 == 2) {
                24
            } else {
                36
            }
        } else if (v2 == 2) {
            84
        } else {
            108
        }
    }

    fun preflop_class_pair_weight(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: u64) : u128 {
        let v0 = preflop_class_pair_legal_deals(arg0, arg1, arg2, arg3);
        if (v0 == 0) {
            return 0
        };
        (v0 as u128) * exp_weight(arg4 * (min_u16(preflop_small_blind_score(arg0, arg1), preflop_big_blind_score(arg2, arg3)) as u64) / 1000)
    }

    fun preflop_class_rank_overlap(arg0: u8, arg1: u8, arg2: u8, arg3: u8) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (preflop_class_contains_rank(arg2, arg3, arg0)) {
            v1 = v0 + 1;
        };
        if (arg1 != arg0 && preflop_class_contains_rank(arg2, arg3, arg1)) {
            v1 = v1 + 1;
        };
        v1
    }

    fun preflop_class_shape(arg0: u8, arg1: u8) : u8 {
        assert!(arg0 < 13 && arg1 < 13, 13906836661129707525);
        if (arg0 == arg1) {
            0
        } else if (arg0 < arg1) {
            1
        } else {
            2
        }
    }

    fun preflop_pressure_score(arg0: u8, arg1: u8) : u16 {
        if (arg0 == 0) {
            row13(arg1, 1000, 943, 929, 914, 886, 686, 657, 629, 600, 571, 543, 514, 486)
        } else if (arg0 == 1) {
            row13(arg1, 971, 993, 914, 871, 814, 657, 457, 371, 314, 257, 200, 143, 86)
        } else if (arg0 == 2) {
            row13(arg1, 943, 900, 979, 886, 800, 600, 429, 257, 171, 86, 29, 0, 0)
        } else if (arg0 == 3) {
            row13(arg1, 900, 843, 857, 957, 886, 657, 514, 371, 214, 71, 0, 0, 0)
        } else if (arg0 == 4) {
            row13(arg1, 829, 743, 714, 786, 929, 843, 629, 457, 314, 171, 0, 0, 0)
        } else if (arg0 == 5) {
            row13(arg1, 457, 314, 257, 371, 600, 900, 814, 600, 457, 257, 0, 0, 0)
        } else if (arg0 == 6) {
            row13(arg1, 400, 29, 0, 86, 171, 457, 871, 786, 600, 371, 0, 0, 0)
        } else if (arg0 == 7) {
            row13(arg1, 343, 0, 0, 0, 0, 86, 371, 843, 757, 543, 171, 0, 0)
        } else if (arg0 == 8) {
            row13(arg1, 286, 0, 0, 0, 0, 0, 0, 314, 814, 729, 371, 0, 0)
        } else if (arg0 == 9) {
            row13(arg1, 229, 0, 0, 0, 0, 0, 0, 0, 171, 786, 700, 171, 0)
        } else if (arg0 == 10) {
            row13(arg1, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 757, 657, 0)
        } else if (arg0 == 11) {
            row13(arg1, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 729, 600)
        } else {
            row13(arg1, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 700)
        }
    }

    fun preflop_small_blind_score(arg0: u8, arg1: u8) : u16 {
        if (arg0 == 0) {
            row13(arg1, 995, 948, 930, 796, 749, 716, 670, 693, 727, 651, 659, 631, 629)
        } else if (arg0 == 1) {
            row13(arg1, 933, 995, 764, 755, 677, 607, 642, 658, 657, 599, 599, 566, 582)
        } else if (arg0 == 2) {
            row13(arg1, 825, 730, 988, 676, 663, 644, 633, 655, 610, 592, 570, 580, 515)
        } else if (arg0 == 3) {
            row13(arg1, 716, 695, 623, 970, 710, 615, 695, 670, 628, 537, 609, 527, 515)
        } else if (arg0 == 4) {
            row13(arg1, 675, 605, 640, 619, 950, 652, 630, 674, 605, 597, 548, 514, 518)
        } else if (arg0 == 5) {
            row13(arg1, 636, 624, 611, 619, 627, 791, 621, 629, 590, 617, 506, 526, 503)
        } else if (arg0 == 6) {
            row13(arg1, 616, 586, 576, 542, 600, 582, 719, 645, 569, 592, 557, 492, 455)
        } else if (arg0 == 7) {
            row13(arg1, 616, 581, 518, 555, 527, 567, 574, 667, 645, 559, 568, 515, 461)
        } else if (arg0 == 8) {
            row13(arg1, 641, 567, 521, 470, 513, 491, 534, 544, 672, 604, 559, 495, 478)
        } else if (arg0 == 9) {
            row13(arg1, 633, 601, 480, 482, 489, 453, 457, 491, 527, 625, 545, 510, 417)
        } else if (arg0 == 10) {
            row13(arg1, 607, 543, 521, 497, 476, 416, 429, 420, 476, 468, 668, 450, 485)
        } else if (arg0 == 11) {
            row13(arg1, 583, 564, 501, 449, 426, 396, 373, 371, 385, 442, 413, 643, 377)
        } else {
            row13(arg1, 617, 552, 527, 463, 468, 436, 409, 360, 388, 396, 378, 332, 606)
        }
    }

    fun rank_from_index(arg0: u8) : u8 {
        14 - arg0
    }

    fun remove_card(arg0: &mut vector<u8>, arg1: u8) : u8 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return 0x1::vector::swap_remove<u8>(arg0, v0)
            };
            v0 = v0 + 1;
        };
        abort 13906837717691531267
    }

    fun row13(arg0: u8, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u16, arg8: u16, arg9: u16, arg10: u16, arg11: u16, arg12: u16, arg13: u16) : u16 {
        if (arg0 == 0) {
            arg1
        } else if (arg0 == 1) {
            arg2
        } else if (arg0 == 2) {
            arg3
        } else if (arg0 == 3) {
            arg4
        } else if (arg0 == 4) {
            arg5
        } else if (arg0 == 5) {
            arg6
        } else if (arg0 == 6) {
            arg7
        } else if (arg0 == 7) {
            arg8
        } else if (arg0 == 8) {
            arg9
        } else if (arg0 == 9) {
            arg10
        } else if (arg0 == 10) {
            arg11
        } else if (arg0 == 11) {
            arg12
        } else {
            arg13
        }
    }

    fun row13_u128(arg0: u8, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: u128) : u128 {
        if (arg0 == 0) {
            arg1
        } else if (arg0 == 1) {
            arg2
        } else if (arg0 == 2) {
            arg3
        } else if (arg0 == 3) {
            arg4
        } else if (arg0 == 4) {
            arg5
        } else if (arg0 == 5) {
            arg6
        } else if (arg0 == 6) {
            arg7
        } else if (arg0 == 7) {
            arg8
        } else if (arg0 == 8) {
            arg9
        } else if (arg0 == 9) {
            arg10
        } else if (arg0 == 10) {
            arg11
        } else if (arg0 == 11) {
            arg12
        } else {
            arg13
        }
    }

    fun sample_flop(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: address, arg4: &mut u64) : vector<u8> {
        let v0 = b"";
        let v1 = draw_card(arg0, arg2, arg3, arg4);
        0x1::vector::push_back<u8>(&mut v0, v1);
        let v2 = draw_card(arg0, arg2, arg3, arg4);
        0x1::vector::push_back<u8>(&mut v0, v2);
        0x1::vector::push_back<u8>(&mut v0, draw_card(arg0, arg2, arg3, arg4));
        let v3 = &mut v0;
        sort_three_by_deck_order(v3, arg1);
        v0
    }

    fun sample_preflop_class_pair_holes(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: &vector<u8>, arg5: address, arg6: &mut u64) : (u8, u8, u8, u8) {
        let v0 = preflop_class_pair_legal_deals(arg0, arg1, arg2, arg3);
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 12) {
            if (v7 < preflop_class_combo_count(arg0, arg1)) {
                let (v8, v9) = preflop_class_exact_combo(arg0, arg1, v7);
                let v10 = 0;
                while (v10 < 12) {
                    if (v10 < preflop_class_combo_count(arg2, arg3)) {
                        let (v11, v12) = preflop_class_exact_combo(arg2, arg3, v10);
                        if (holes_are_disjoint(v8, v9, v11, v12)) {
                            if (!v2 && v1 == (pick_u128(arg4, arg5, arg6, (v0 as u128)) as u16)) {
                                v3 = v8;
                                v4 = v9;
                                v5 = v11;
                                v6 = v12;
                                v2 = true;
                            };
                            v1 = v1 + 1;
                        };
                    };
                    v10 = v10 + 1;
                };
            };
            v7 = v7 + 1;
        };
        assert!(v2 && v1 == v0, 13906835102056316929);
        (v3, v4, v5, v6)
    }

    fun sample_preflop_pressure_holes(arg0: &vector<u8>, arg1: address, arg2: &mut u64, arg3: u8, arg4: u64) : vector<u8> {
        assert!(arg4 == 12000, 13906834638200111109);
        sample_preflop_pressure_holes_table(arg0, arg1, arg2, arg3)
    }

    fun sample_preflop_pressure_holes_table(arg0: &vector<u8>, arg1: address, arg2: &mut u64, arg3: u8) : vector<u8> {
        let v0 = pick_u128(arg0, arg1, arg2, 1426020184191933882);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = false;
        while (v1 < 169) {
            let v5 = v2;
            v2 = v2 + table_sb_class_total(v1);
            if (!v4 && v0 < v2) {
                v3 = v5;
                v4 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v4, 13906834749868998657);
        let (v6, v7) = preflop_class_coords(0);
        let v8 = 0;
        let v9 = 0;
        let v10 = false;
        while (v8 < 169) {
            let (v11, v12) = preflop_class_coords(v8);
            v9 = v9 + preflop_class_pair_weight(v6, v7, v11, v12, 12000);
            if (!v10 && v0 - v3 < v9) {
                v10 = true;
            };
            v8 = v8 + 1;
        };
        assert!(v10, 13906834852948213761);
        let (v13, v14) = preflop_class_coords(0);
        let (v15, v16, v17, v18) = sample_preflop_class_pair_holes(v6, v7, v13, v14, arg0, arg1, arg2);
        seat_ordered_holes(arg3, v15, v16, v17, v18)
    }

    fun seat_ordered_holes(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: u8) : vector<u8> {
        let v0 = 1 - arg0;
        let v1 = x"00000000";
        *0x1::vector::borrow_mut<u8>(&mut v1, (arg0 as u64) * 2) = arg1;
        *0x1::vector::borrow_mut<u8>(&mut v1, (arg0 as u64) * 2 + 1) = arg2;
        *0x1::vector::borrow_mut<u8>(&mut v1, (v0 as u64) * 2) = arg3;
        *0x1::vector::borrow_mut<u8>(&mut v1, (v0 as u64) * 2 + 1) = arg4;
        v1
    }

    fun sort_three_by_deck_order(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        if (deck_position(arg1, *0x1::vector::borrow<u8>(arg0, 1)) < deck_position(arg1, *0x1::vector::borrow<u8>(arg0, 0))) {
            *0x1::vector::borrow_mut<u8>(arg0, 0) = *0x1::vector::borrow<u8>(arg0, 1);
            *0x1::vector::borrow_mut<u8>(arg0, 1) = *0x1::vector::borrow<u8>(arg0, 0);
        };
        if (deck_position(arg1, *0x1::vector::borrow<u8>(arg0, 2)) < deck_position(arg1, *0x1::vector::borrow<u8>(arg0, 1))) {
            *0x1::vector::borrow_mut<u8>(arg0, 1) = *0x1::vector::borrow<u8>(arg0, 2);
            *0x1::vector::borrow_mut<u8>(arg0, 2) = *0x1::vector::borrow<u8>(arg0, 1);
        };
        if (deck_position(arg1, *0x1::vector::borrow<u8>(arg0, 1)) < deck_position(arg1, *0x1::vector::borrow<u8>(arg0, 0))) {
            *0x1::vector::borrow_mut<u8>(arg0, 0) = *0x1::vector::borrow<u8>(arg0, 1);
            *0x1::vector::borrow_mut<u8>(arg0, 1) = *0x1::vector::borrow<u8>(arg0, 0);
        };
    }

    public fun standard_deck() : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 52) {
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    fun table_sb_class_total(arg0: u64) : u128 {
        let v0 = arg0 / 13;
        if (v0 == 0) {
            row13_u128(((arg0 % 13) as u8), 61215662336560002, 34201820377631076, 31817868585218008, 16807203916139812, 11954508473840264, 9039906823052740, 5958443717594452, 7542792876104420, 10418668738856712, 5100939666803312, 5507464126765160, 4186378066410884, 4091451513842964)
        } else if (v0 == 1) {
            row13_u128(((arg0 % 13) as u8), 96061423429176624, 67181410169613702, 14185767268359300, 13125490103113920, 6573798613121572, 3292431026878264, 4749576783899540, 5552542199334728, 5531463862996292, 3117402180405140, 3132585107357956, 2232964762357004, 2573842573321196)
        } else if (v0 == 2) {
            row13_u128(((arg0 % 13) as u8), 59534034410233452, 31989902078798748, 69303545687867778, 6541118277863708, 5687989349705188, 4824362117172420, 4350321002748644, 5456743135122672, 3512587056460392, 2916722499326792, 2338736380755228, 2560887171160556, 1353257037720368)
        } else if (v0 == 3) {
            row13_u128(((arg0 % 13) as u8), 26950944878165460, 23254112065145028, 11515588418485176, 65074421840564880, 8805069363514864, 3596349828742512, 7975407928842240, 6254147226255232, 4153816180781832, 1650256191347712, 3511082364349492, 1526321609491752, 1355150134697256)
        } else if (v0 == 4) {
            row13_u128(((arg0 % 13) as u8), 18594150411030744, 9660862768785468, 13865342832749652, 11136465076878060, 58961618379902118, 5200373481938436, 4197000261270088, 6559699782036040, 3339430336582896, 3083403135417412, 1859657069690136, 1341570593911580, 1399118674552860)
        } else if (v0 == 5) {
            row13_u128(((arg0 % 13) as u8), 12787319769958944, 11488720414652172, 10395365065382376, 11162761305326280, 12003216001897716, 26249647678695972, 3826285539343392, 4194777789660864, 2835639605282748, 3762356392533440, 1218664633708620, 1511324047678700, 1179214744908672)
        } else if (v0 == 6) {
            row13_u128(((arg0 % 13) as u8), 10560388475931204, 7858416506665764, 7210682661637284, 5051930525489724, 9369485792644116, 7596330391647684, 15190152657841242, 5055833629876148, 2310355504782700, 2936379995280136, 2066254727288836, 1064724193410092, 724030694875376)
        } else if (v0 == 7) {
            row13_u128(((arg0 % 13) as u8), 10675104236730948, 7523278488098916, 4104006035041224, 5953062262325820, 4487949774448560, 6724413667897872, 7213684053510600, 9249639223716204, 5112014385902468, 2124684065876008, 2333619960584328, 1370763189712044, 773642828202796)
        } else if (v0 == 8) {
            row13_u128(((arg0 % 13) as u8), 13834154548972896, 6670796266502532, 4260874385131980, 2542686255569508, 3926324182950876, 3122088481427040, 4815974149495512, 5338757439161424, 9945635480321088, 3398932324740924, 2145514148900676, 1110041631622348, 948243370354444)
        } else if (v0 == 9) {
            row13_u128(((arg0 % 13) as u8), 12743986387257084, 9540550360158804, 2814694412978976, 2882567191991016, 3077056619918304, 2114542747582260, 2184662555956752, 3157486700950740, 4619620592800680, 6197964437496504, 1836775361220940, 1309775348903440, 497090348181512)
        } else if (v0 == 10) {
            row13_u128(((arg0 % 13) as u8), 9946376842451784, 5169337725332616, 4301193847597272, 3314089795599060, 2731456015419648, 1450178691232512, 1690483407105612, 1522930906486920, 2775607680374040, 2546930764961388, 9671458616191368, 709836074619272, 1023926704370788)
        } else if (v0 == 11) {
            row13_u128(((arg0 % 13) as u8), 7617065155731384, 6561421610137488, 3442210214963376, 2066074565836188, 1642267451478804, 1216945619493096, 941260089169620, 925424822313924, 1088205406747020, 1969341144965988, 1446353506877688, 7728459049417386, 333568770131380)
        } else {
            assert!(v0 == 12, 13906836454971277317);
            row13_u128(((arg0 % 13) as u8), 10949132126833140, 5781498147107856, 4568712038967312, 2368331376672372, 2514564157797600, 1829695060026348, 1374757834888344, 841218614380032, 1127854120912812, 1232698184933844, 1010148879487368, 632483234014440, 5318394949090626)
        }
    }

    // decompiled from Move bytecode v7
}

