module 0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::routes {
    public fun flash_ba<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 106) {
            if (arg5 == 29) {
                if (arg6 == 14) {
                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg3 == 150) {
                if (arg5 == 6) {
                    if (arg6 == 16) {
                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg3 == 153) {
                    if (arg5 == 1) {
                        if (arg6 == 18) {
                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    true
                } else if (arg3 == 172) {
                    if (arg5 == 1) {
                        if (arg6 == 2) {
                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
        };
        assert!(v1, 0);
        assert!(arg7 > 0, 2);
        let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg9, arg0, arg1, true, false, arg7, 4295048017);
        let v7 = v6;
        let v8 = v5;
        0x2::balance::destroy_zero<T0>(v4);
        assert!(0x2::balance::value<T1>(&v8) == arg7, 2);
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v7);
        let (v10, v11) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T1, T0>(arg2, arg4, arg5, arg6, 0x2::coin::from_balance<T1>(v8, arg10), arg9, arg10);
        let v12 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v10, arg9, arg10));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v12), v9, arg8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v12, v9), 0x2::balance::zero<T1>(), v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg10), 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, 0x2::tx_context::sender(arg10));
    }

    public fun flash_ba_bb<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 161) {
            if (arg6 == 2) {
                if (arg7 == 18) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
        let v1 = if (v0) {
            true
        } else if (arg4 == 180) {
            if (arg6 == 18) {
                if (arg7 == 2) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
        assert!(v1, 0);
        assert!(arg8 > 0, 2);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg10, arg0, arg2, false, false, arg8, 79226673515401279992447579054);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        assert!(0x2::balance::value<T2>(&v6) == arg8, 2);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v5);
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg10, arg0, arg1, true, false, v7, 4295048017);
        let v11 = v10;
        let v12 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        assert!(0x2::balance::value<T1>(&v12) == v7, 2);
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v11);
        let (v14, v15) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T2, T0>(arg3, arg5, arg6, arg7, 0x2::coin::from_balance<T2>(v6, arg11), arg10, arg11);
        let v16 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v14, arg10, arg11));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v16), v13, arg9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v16, v13), 0x2::balance::zero<T1>(), v11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), v12, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg11), 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v15, 0x2::tx_context::sender(arg11));
    }

    public fun flash_ba_ca<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: u64, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5 == 135) {
            if (arg7 == 10) {
                if (arg8 == 16) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07) {
                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg5 == 138) {
                if (arg7 == 13) {
                    if (arg8 == 16) {
                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
            if (v2) {
                true
            } else {
                let v3 = if (arg5 == 140) {
                    if (arg7 == 15) {
                        if (arg8 == 16) {
                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                if (v3) {
                    true
                } else {
                    let v4 = if (arg5 == 144) {
                        if (arg7 == 29) {
                            if (arg8 == 16) {
                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg5 == 146) {
                            if (arg7 == 31) {
                                if (arg8 == 16) {
                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg5 == 147) {
                                if (arg7 == 33) {
                                    if (arg8 == 16) {
                                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                            if (v6) {
                                true
                            } else if (arg5 == 149) {
                                if (arg7 == 5) {
                                    if (arg8 == 16) {
                                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg9 > 0, 2);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, false, arg9, 4295048017, arg11);
        let v10 = v9;
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v7);
        assert!(0x2::balance::value<T2>(&v11) == arg9, 2);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v10);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg11, arg1, arg2, true, false, v12, 4295048017);
        let v16 = v15;
        let v17 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        assert!(0x2::balance::value<T1>(&v17) == v12, 2);
        let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16);
        let (v19, v20) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T2, T0>(arg4, arg6, arg7, arg8, 0x2::coin::from_balance<T2>(v11, arg12), arg11, arg12);
        let v21 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg4, v19, arg11, arg12));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v21), v18, arg10);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v21, v18), 0x2::balance::zero<T1>(), v16);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, v17, 0x2::balance::zero<T2>(), v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg12), 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v20, 0x2::tx_context::sender(arg12));
    }

    public fun flash_ba_ca_bb<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg6 == 139) {
            if (arg8 == 14) {
                if (arg9 == 16) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
        } else {
            false
        };
        assert!(v0, 0);
        assert!(arg10 > 0, 2);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T2>(arg12, arg1, arg4, false, false, arg10, 79226673515401279992447579054);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        assert!(0x2::balance::value<T3>(&v5) == arg10, 2);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T3, T2>(&v4);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, false, v6, 4295048017, arg12);
        let v10 = v9;
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v7);
        assert!(0x2::balance::value<T2>(&v11) == v6, 2);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v10);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg1, arg2, true, false, v12, 4295048017);
        let v16 = v15;
        let v17 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        assert!(0x2::balance::value<T1>(&v17) == v12, 2);
        let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16);
        let (v19, v20) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T3, T0>(arg5, arg7, arg8, arg9, 0x2::coin::from_balance<T3>(v5, arg13), arg12, arg13);
        let v21 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg5, v19, arg12, arg13));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v21), v18, arg11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v21, v18), 0x2::balance::zero<T1>(), v16);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, v17, 0x2::balance::zero<T2>(), v10);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T2>(arg1, arg4, 0x2::balance::zero<T3>(), v11, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg13), 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v20, 0x2::tx_context::sender(arg13));
    }

    public fun flash_ba_ca_cb<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg6 == 145) {
            if (arg8 == 3) {
                if (arg9 == 16) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg4) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else if (arg6 == 152) {
            if (arg8 == 9) {
                if (arg9 == 16) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg4) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
        } else {
            false
        };
        assert!(v1, 0);
        assert!(arg10 > 0, 2);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T2>(arg0, arg4, false, false, arg10, 79226673515401279992447579054, arg12);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T2>(v3);
        assert!(0x2::balance::value<T3>(&v6) == arg10, 2);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T3, T2>(&v5);
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, false, v7, 4295048017, arg12);
        let v11 = v10;
        let v12 = v9;
        0x2::balance::destroy_zero<T1>(v8);
        assert!(0x2::balance::value<T2>(&v12) == v7, 2);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v11);
        let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg1, arg2, true, false, v13, 4295048017);
        let v17 = v16;
        let v18 = v15;
        0x2::balance::destroy_zero<T0>(v14);
        assert!(0x2::balance::value<T1>(&v18) == v13, 2);
        let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v17);
        let (v20, v21) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T3, T0>(arg5, arg7, arg8, arg9, 0x2::coin::from_balance<T3>(v6, arg13), arg12, arg13);
        let v22 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg5, v20, arg12, arg13));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v22), v19, arg11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v22, v19), 0x2::balance::zero<T1>(), v17);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, v18, 0x2::balance::zero<T2>(), v11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T2>(arg0, arg4, 0x2::balance::zero<T3>(), v12, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v22, arg13), 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v21, 0x2::tx_context::sender(arg13));
    }

    public fun flash_ba_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: u64, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5 == 107) {
            if (arg7 == 3) {
                if (arg8 == 14) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg5 == 112) {
                if (arg7 == 6) {
                    if (arg8 == 14) {
                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
            if (v2) {
                true
            } else {
                let v3 = if (arg5 == 155) {
                    if (arg7 == 11) {
                        if (arg8 == 18) {
                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                if (v3) {
                    true
                } else {
                    let v4 = if (arg5 == 156) {
                        if (arg7 == 12) {
                            if (arg8 == 18) {
                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg5 == 160) {
                            if (arg7 == 16) {
                                if (arg8 == 18) {
                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5
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
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg5 == 162) {
                                if (arg7 == 28) {
                                    if (arg8 == 18) {
                                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg5 == 167) {
                                    if (arg7 == 4) {
                                        if (arg8 == 18) {
                                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg5 == 169) {
                                        if (arg7 == 6) {
                                            if (arg8 == 18) {
                                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg5 == 170) {
                                            if (arg7 == 7) {
                                                if (arg8 == 18) {
                                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                        if (v9) {
                                            true
                                        } else {
                                            let v10 = if (arg5 == 174) {
                                                if (arg7 == 11) {
                                                    if (arg8 == 2) {
                                                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                            if (v10) {
                                                true
                                            } else {
                                                let v11 = if (arg5 == 175) {
                                                    if (arg7 == 12) {
                                                        if (arg8 == 2) {
                                                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                if (v11) {
                                                    true
                                                } else {
                                                    let v12 = if (arg5 == 179) {
                                                        if (arg7 == 16) {
                                                            if (arg8 == 2) {
                                                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5
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
                                                    if (v12) {
                                                        true
                                                    } else {
                                                        let v13 = if (arg5 == 181) {
                                                            if (arg7 == 28) {
                                                                if (arg8 == 2) {
                                                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                        if (v13) {
                                                            true
                                                        } else {
                                                            let v14 = if (arg5 == 186) {
                                                                if (arg7 == 4) {
                                                                    if (arg8 == 2) {
                                                                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                            if (v14) {
                                                                true
                                                            } else {
                                                                let v15 = if (arg5 == 188) {
                                                                    if (arg7 == 6) {
                                                                        if (arg8 == 2) {
                                                                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                if (v15) {
                                                                    true
                                                                } else if (arg5 == 189) {
                                                                    if (arg7 == 7) {
                                                                        if (arg8 == 2) {
                                                                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg9 > 0, 2);
        let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, arg9, 79226673515401279992447579054, arg11);
        let v19 = v18;
        let v20 = v16;
        0x2::balance::destroy_zero<T1>(v17);
        assert!(0x2::balance::value<T2>(&v20) == arg9, 2);
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v19);
        let (v22, v23, v24) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg11, arg1, arg2, true, false, v21, 4295048017);
        let v25 = v24;
        let v26 = v23;
        0x2::balance::destroy_zero<T0>(v22);
        assert!(0x2::balance::value<T1>(&v26) == v21, 2);
        let v27 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v25);
        let (v28, v29) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T2, T0>(arg4, arg6, arg7, arg8, 0x2::coin::from_balance<T2>(v20, arg12), arg11, arg12);
        let v30 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg4, v28, arg11, arg12));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v30), v27, arg10);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v30, v27), 0x2::balance::zero<T1>(), v25);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v26, v19);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v30, arg12), 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v29, 0x2::tx_context::sender(arg12));
    }

    public fun flash_ba_cb_bb<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg6 == 102) {
            if (arg8 == 16) {
                if (arg9 == 14) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
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
        } else {
            false
        };
        assert!(v0, 0);
        assert!(arg10 > 0, 2);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T2>(arg12, arg1, arg4, false, false, arg10, 79226673515401279992447579054);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        assert!(0x2::balance::value<T3>(&v5) == arg10, 2);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T3, T2>(&v4);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, v6, 79226673515401279992447579054, arg12);
        let v10 = v9;
        let v11 = v7;
        0x2::balance::destroy_zero<T1>(v8);
        assert!(0x2::balance::value<T2>(&v11) == v6, 2);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v10);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg1, arg2, true, false, v12, 4295048017);
        let v16 = v15;
        let v17 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        assert!(0x2::balance::value<T1>(&v17) == v12, 2);
        let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16);
        let (v19, v20) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T3, T0>(arg5, arg7, arg8, arg9, 0x2::coin::from_balance<T3>(v5, arg13), arg12, arg13);
        let v21 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg5, v19, arg12, arg13));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v21), v18, arg11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v21, v18), 0x2::balance::zero<T1>(), v16);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v17, v10);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T2>(arg1, arg4, 0x2::balance::zero<T3>(), v11, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg13), 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v20, 0x2::tx_context::sender(arg13));
    }

    public fun flash_ba_cb_ca<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg6 == 96) {
            if (arg8 == 1) {
                if (arg9 == 14) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg6 == 97) {
                if (arg8 == 10) {
                    if (arg9 == 14) {
                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg6 == 100) {
                    if (arg8 == 13) {
                        if (arg9 == 14) {
                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                } else {
                    false
                };
                if (v3) {
                    true
                } else {
                    let v4 = if (arg6 == 101) {
                        if (arg8 == 15) {
                            if (arg9 == 14) {
                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                    } else {
                        false
                    };
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg6 == 108) {
                            if (arg8 == 31) {
                                if (arg9 == 14) {
                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                        } else {
                            false
                        };
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg6 == 109) {
                                if (arg8 == 33) {
                                    if (arg9 == 14) {
                                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                            } else {
                                false
                            };
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg6 == 111) {
                                    if (arg8 == 5) {
                                        if (arg9 == 14) {
                                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                } else {
                                    false
                                };
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg6 == 154) {
                                        if (arg8 == 10) {
                                            if (arg9 == 18) {
                                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                    } else {
                                        false
                                    };
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg6 == 157) {
                                            if (arg8 == 13) {
                                                if (arg9 == 18) {
                                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                        } else {
                                            false
                                        };
                                        if (v9) {
                                            true
                                        } else {
                                            let v10 = if (arg6 == 159) {
                                                if (arg8 == 15) {
                                                    if (arg9 == 18) {
                                                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                            } else {
                                                false
                                            };
                                            if (v10) {
                                                true
                                            } else {
                                                let v11 = if (arg6 == 163) {
                                                    if (arg8 == 29) {
                                                        if (arg9 == 18) {
                                                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                } else {
                                                    false
                                                };
                                                if (v11) {
                                                    true
                                                } else {
                                                    let v12 = if (arg6 == 165) {
                                                        if (arg8 == 31) {
                                                            if (arg9 == 18) {
                                                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                    } else {
                                                        false
                                                    };
                                                    if (v12) {
                                                        true
                                                    } else {
                                                        let v13 = if (arg6 == 166) {
                                                            if (arg8 == 33) {
                                                                if (arg9 == 18) {
                                                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                        } else {
                                                            false
                                                        };
                                                        if (v13) {
                                                            true
                                                        } else {
                                                            let v14 = if (arg6 == 168) {
                                                                if (arg8 == 5) {
                                                                    if (arg9 == 18) {
                                                                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                            } else {
                                                                false
                                                            };
                                                            if (v14) {
                                                                true
                                                            } else {
                                                                let v15 = if (arg6 == 173) {
                                                                    if (arg8 == 10) {
                                                                        if (arg9 == 2) {
                                                                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                } else {
                                                                    false
                                                                };
                                                                if (v15) {
                                                                    true
                                                                } else {
                                                                    let v16 = if (arg6 == 176) {
                                                                        if (arg8 == 13) {
                                                                            if (arg9 == 2) {
                                                                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                    } else {
                                                                        false
                                                                    };
                                                                    if (v16) {
                                                                        true
                                                                    } else {
                                                                        let v17 = if (arg6 == 178) {
                                                                            if (arg8 == 15) {
                                                                                if (arg9 == 2) {
                                                                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                                                        } else {
                                                                            false
                                                                        };
                                                                        if (v17) {
                                                                            true
                                                                        } else {
                                                                            let v18 = if (arg6 == 182) {
                                                                                if (arg8 == 29) {
                                                                                    if (arg9 == 2) {
                                                                                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                                            } else {
                                                                                false
                                                                            };
                                                                            if (v18) {
                                                                                true
                                                                            } else {
                                                                                let v19 = if (arg6 == 184) {
                                                                                    if (arg8 == 31) {
                                                                                        if (arg9 == 2) {
                                                                                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                                                } else {
                                                                                    false
                                                                                };
                                                                                if (v19) {
                                                                                    true
                                                                                } else {
                                                                                    let v20 = if (arg6 == 185) {
                                                                                        if (arg8 == 33) {
                                                                                            if (arg9 == 2) {
                                                                                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                                                    } else {
                                                                                        false
                                                                                    };
                                                                                    if (v20) {
                                                                                        true
                                                                                    } else if (arg6 == 187) {
                                                                                        if (arg8 == 5) {
                                                                                            if (arg9 == 2) {
                                                                                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                                                    } else {
                                                                                        false
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg10 > 0, 2);
        let (v21, v22, v23) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg10, 4295048017, arg12);
        let v24 = v23;
        let v25 = v22;
        0x2::balance::destroy_zero<T2>(v21);
        assert!(0x2::balance::value<T3>(&v25) == arg10, 2);
        let v26 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v24);
        let (v27, v28, v29) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, v26, 79226673515401279992447579054, arg12);
        let v30 = v29;
        let v31 = v27;
        0x2::balance::destroy_zero<T1>(v28);
        assert!(0x2::balance::value<T2>(&v31) == v26, 2);
        let v32 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v30);
        let (v33, v34, v35) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg1, arg2, true, false, v32, 4295048017);
        let v36 = v35;
        let v37 = v34;
        0x2::balance::destroy_zero<T0>(v33);
        assert!(0x2::balance::value<T1>(&v37) == v32, 2);
        let v38 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v36);
        let (v39, v40) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T3, T0>(arg5, arg7, arg8, arg9, 0x2::coin::from_balance<T3>(v25, arg13), arg12, arg13);
        let v41 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg5, v39, arg12, arg13));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v41), v38, arg11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v41, v38), 0x2::balance::zero<T1>(), v36);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v37, v30);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v31, 0x2::balance::zero<T3>(), v24);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v41, arg13), 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v40, 0x2::tx_context::sender(arg13));
    }

    public fun flash_ba_cb_ca_bb<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: u64, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7 == 103) {
            if (arg9 == 18) {
                if (arg10 == 14) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg7 == 104) {
                if (arg9 == 2) {
                    if (arg10 == 14) {
                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg7 == 158) {
                    if (arg9 == 14) {
                        if (arg10 == 18) {
                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    true
                } else if (arg7 == 177) {
                    if (arg9 == 14) {
                        if (arg10 == 2) {
                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                    } else {
                        false
                    }
                } else {
                    false
                }
            }
        };
        assert!(v1, 0);
        assert!(arg11 > 0, 2);
        let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T4, T3>(arg13, arg1, arg5, false, false, arg11, 79226673515401279992447579054);
        let v7 = v6;
        let v8 = v4;
        0x2::balance::destroy_zero<T3>(v5);
        assert!(0x2::balance::value<T4>(&v8) == arg11, 2);
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T4, T3>(&v7);
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, v9, 4295048017, arg13);
        let v13 = v12;
        let v14 = v11;
        0x2::balance::destroy_zero<T2>(v10);
        assert!(0x2::balance::value<T3>(&v14) == v9, 2);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v13);
        let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, v15, 79226673515401279992447579054, arg13);
        let v19 = v18;
        let v20 = v16;
        0x2::balance::destroy_zero<T1>(v17);
        assert!(0x2::balance::value<T2>(&v20) == v15, 2);
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v19);
        let (v22, v23, v24) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg1, arg2, true, false, v21, 4295048017);
        let v25 = v24;
        let v26 = v23;
        0x2::balance::destroy_zero<T0>(v22);
        assert!(0x2::balance::value<T1>(&v26) == v21, 2);
        let v27 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v25);
        let (v28, v29) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T4, T0>(arg6, arg8, arg9, arg10, 0x2::coin::from_balance<T4>(v8, arg14), arg13, arg14);
        let v30 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg6, v28, arg13, arg14));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v30), v27, arg12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v30, v27), 0x2::balance::zero<T1>(), v25);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v26, v19);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v20, 0x2::balance::zero<T3>(), v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T4, T3>(arg1, arg5, 0x2::balance::zero<T4>(), v14, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v30, arg14), 0x2::tx_context::sender(arg14));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v29, 0x2::tx_context::sender(arg14));
    }

    public fun flash_ba_cb_ca_cb<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: u64, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7 == 98) {
            if (arg9 == 11) {
                if (arg10 == 14) {
                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg5) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg7 == 99) {
                if (arg9 == 12) {
                    if (arg10 == 14) {
                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg5) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg7 == 105) {
                    if (arg9 == 28) {
                        if (arg10 == 14) {
                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg5) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    true
                } else {
                    let v4 = if (arg7 == 110) {
                        if (arg9 == 4) {
                            if (arg10 == 14) {
                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg5) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg7 == 113) {
                            if (arg9 == 7) {
                                if (arg10 == 14) {
                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg5) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg7 == 114) {
                                if (arg9 == 9) {
                                    if (arg10 == 14) {
                                        if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg5) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg7 == 164) {
                                    if (arg9 == 3) {
                                        if (arg10 == 18) {
                                            if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg5) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg7 == 171) {
                                        if (arg9 == 9) {
                                            if (arg10 == 18) {
                                                if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg5) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    };
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg7 == 183) {
                                            if (arg9 == 3) {
                                                if (arg10 == 2) {
                                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg5) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        };
                                        if (v9) {
                                            true
                                        } else if (arg7 == 190) {
                                            if (arg9 == 9) {
                                                if (arg10 == 2) {
                                                    if (0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg5) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg11 > 0, 2);
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T4, T3>(arg0, arg5, false, false, arg11, 79226673515401279992447579054, arg13);
        let v13 = v12;
        let v14 = v10;
        0x2::balance::destroy_zero<T3>(v11);
        assert!(0x2::balance::value<T4>(&v14) == arg11, 2);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T4, T3>(&v13);
        let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, v15, 4295048017, arg13);
        let v19 = v18;
        let v20 = v17;
        0x2::balance::destroy_zero<T2>(v16);
        assert!(0x2::balance::value<T3>(&v20) == v15, 2);
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v19);
        let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, v21, 79226673515401279992447579054, arg13);
        let v25 = v24;
        let v26 = v22;
        0x2::balance::destroy_zero<T1>(v23);
        assert!(0x2::balance::value<T2>(&v26) == v21, 2);
        let v27 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v25);
        let (v28, v29, v30) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg1, arg2, true, false, v27, 4295048017);
        let v31 = v30;
        let v32 = v29;
        0x2::balance::destroy_zero<T0>(v28);
        assert!(0x2::balance::value<T1>(&v32) == v27, 2);
        let v33 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v31);
        let (v34, v35) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T4, T0>(arg6, arg8, arg9, arg10, 0x2::coin::from_balance<T4>(v14, arg14), arg13, arg14);
        let v36 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg6, v34, arg13, arg14));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v36), v33, arg12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v36, v33), 0x2::balance::zero<T1>(), v31);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v32, v25);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v26, 0x2::balance::zero<T3>(), v19);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T4, T3>(arg0, arg5, 0x2::balance::zero<T4>(), v20, v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v36, arg14), 0x2::tx_context::sender(arg14));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v35, 0x2::tx_context::sender(arg14));
    }

    public fun flash_bb<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 215) {
            if (arg5 == 14) {
                if (arg6 == 29) {
                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg1) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else if (arg3 == 331) {
            if (arg5 == 16) {
                if (arg6 == 6) {
                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg1) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0);
        assert!(arg7 > 0, 2);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg9, arg0, arg1, false, false, arg7, 79226673515401279992447579054);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T0>(v3);
        assert!(0x2::balance::value<T1>(&v6) == arg7, 2);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v5);
        let (v8, v9) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T1, T0>(arg2, arg4, arg5, arg6, 0x2::coin::from_balance<T1>(v6, arg10), arg9, arg10);
        let v10 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v8, arg9, arg10));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v10), v7, arg8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v10, v7), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg10), 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, 0x2::tx_context::sender(arg10));
    }

    public fun flash_bb_sui<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 8) {
            if (arg6 == 18) {
                if (arg7 == 1) {
                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else if (arg4 == 9) {
            if (arg6 == 2) {
                if (arg7 == 1) {
                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0);
        assert!(arg8 > 0, 2);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg10, arg0, arg1, false, false, arg8, 79226673515401279992447579054);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        assert!(0x2::balance::value<T0>(&v6) == arg8, 2);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v5);
        let (v8, v9) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg2, arg5, arg6, arg7, 0x2::coin::from_balance<T0>(v6, arg11), arg10, arg11);
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, v8, arg3, arg10, arg11));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<0x2::sui::SUI>(&v10), v7, arg9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v10, v7), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v10, arg11), 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, 0x2::tx_context::sender(arg11));
    }

    public fun flash_ca<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 39) {
            if (arg5 == 1) {
                if (arg6 == 11) {
                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg3 == 58) {
                if (arg5 == 1) {
                    if (arg6 == 12) {
                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg3 == 134) {
                    if (arg5 == 1) {
                        if (arg6 == 16) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    true
                } else {
                    let v4 = if (arg3 == 191) {
                        if (arg5 == 1) {
                            if (arg6 == 28) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg3 == 240) {
                            if (arg5 == 29) {
                                if (arg6 == 3) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg3 == 286) {
                                if (arg5 == 1) {
                                    if (arg6 == 4) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg3 == 324) {
                                    if (arg5 == 1) {
                                        if (arg6 == 6) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg3 == 325) {
                                        if (arg5 == 10) {
                                            if (arg6 == 6) {
                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    };
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg3 == 328) {
                                            if (arg5 == 13) {
                                                if (arg6 == 6) {
                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        };
                                        if (v9) {
                                            true
                                        } else {
                                            let v10 = if (arg3 == 330) {
                                                if (arg5 == 15) {
                                                    if (arg6 == 6) {
                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
                                                    } else {
                                                        false
                                                    }
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            };
                                            if (v10) {
                                                true
                                            } else {
                                                let v11 = if (arg3 == 335) {
                                                    if (arg5 == 29) {
                                                        if (arg6 == 6) {
                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
                                                        } else {
                                                            false
                                                        }
                                                    } else {
                                                        false
                                                    }
                                                } else {
                                                    false
                                                };
                                                if (v11) {
                                                    true
                                                } else {
                                                    let v12 = if (arg3 == 337) {
                                                        if (arg5 == 31) {
                                                            if (arg6 == 6) {
                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
                                                            } else {
                                                                false
                                                            }
                                                        } else {
                                                            false
                                                        }
                                                    } else {
                                                        false
                                                    };
                                                    if (v12) {
                                                        true
                                                    } else {
                                                        let v13 = if (arg3 == 338) {
                                                            if (arg5 == 33) {
                                                                if (arg6 == 6) {
                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
                                                                } else {
                                                                    false
                                                                }
                                                            } else {
                                                                false
                                                            }
                                                        } else {
                                                            false
                                                        };
                                                        if (v13) {
                                                            true
                                                        } else {
                                                            let v14 = if (arg3 == 340) {
                                                                if (arg5 == 5) {
                                                                    if (arg6 == 6) {
                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
                                                                    } else {
                                                                        false
                                                                    }
                                                                } else {
                                                                    false
                                                                }
                                                            } else {
                                                                false
                                                            };
                                                            if (v14) {
                                                                true
                                                            } else if (arg3 == 343) {
                                                                if (arg5 == 1) {
                                                                    if (arg6 == 7) {
                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg7 > 0, 2);
        let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg7, 4295048017, arg9);
        let v18 = v17;
        let v19 = v16;
        0x2::balance::destroy_zero<T0>(v15);
        assert!(0x2::balance::value<T1>(&v19) == arg7, 2);
        let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v18);
        let (v21, v22) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T1, T0>(arg2, arg4, arg5, arg6, 0x2::coin::from_balance<T1>(v19, arg10), arg9, arg10);
        let v23 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v21, arg9, arg10));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v23), v20, arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v23, v20), 0x2::balance::zero<T1>(), v18);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v23, arg10), 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v22, 0x2::tx_context::sender(arg10));
    }

    public fun flash_ca_bb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: u64, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5 == 46) {
            if (arg7 == 18) {
                if (arg8 == 11) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg5 == 47) {
                if (arg7 == 2) {
                    if (arg8 == 11) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
            if (v2) {
                true
            } else {
                let v3 = if (arg5 == 65) {
                    if (arg7 == 18) {
                        if (arg8 == 12) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                if (v3) {
                    true
                } else {
                    let v4 = if (arg5 == 66) {
                        if (arg7 == 2) {
                            if (arg8 == 12) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg5 == 141) {
                            if (arg7 == 18) {
                                if (arg8 == 16) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5) {
                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg5 == 142) {
                                if (arg7 == 2) {
                                    if (arg8 == 16) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5) {
                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg5 == 199) {
                                    if (arg7 == 18) {
                                        if (arg8 == 28) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg5 == 200) {
                                        if (arg7 == 2) {
                                            if (arg8 == 28) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg5 == 234) {
                                            if (arg7 == 14) {
                                                if (arg8 == 3) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                                        if (v9) {
                                            true
                                        } else {
                                            let v10 = if (arg5 == 294) {
                                                if (arg7 == 18) {
                                                    if (arg8 == 4) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                                            if (v10) {
                                                true
                                            } else {
                                                let v11 = if (arg5 == 295) {
                                                    if (arg7 == 2) {
                                                        if (arg8 == 4) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                                                if (v11) {
                                                    true
                                                } else {
                                                    let v12 = if (arg5 == 329) {
                                                        if (arg7 == 14) {
                                                            if (arg8 == 6) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                                                    if (v12) {
                                                        true
                                                    } else {
                                                        let v13 = if (arg5 == 332) {
                                                            if (arg7 == 18) {
                                                                if (arg8 == 6) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                                                        if (v13) {
                                                            true
                                                        } else {
                                                            let v14 = if (arg5 == 333) {
                                                                if (arg7 == 2) {
                                                                    if (arg8 == 6) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                                                            if (v14) {
                                                                true
                                                            } else {
                                                                let v15 = if (arg5 == 351) {
                                                                    if (arg7 == 18) {
                                                                        if (arg8 == 7) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                                                                if (v15) {
                                                                    true
                                                                } else if (arg5 == 352) {
                                                                    if (arg7 == 2) {
                                                                        if (arg8 == 7) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg9 > 0, 2);
        let (v16, v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg11, arg1, arg3, false, false, arg9, 79226673515401279992447579054);
        let v19 = v18;
        let v20 = v16;
        0x2::balance::destroy_zero<T1>(v17);
        assert!(0x2::balance::value<T2>(&v20) == arg9, 2);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v19);
        let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, false, v21, 4295048017, arg11);
        let v25 = v24;
        let v26 = v23;
        0x2::balance::destroy_zero<T0>(v22);
        assert!(0x2::balance::value<T1>(&v26) == v21, 2);
        let v27 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v25);
        let (v28, v29) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T2, T0>(arg4, arg6, arg7, arg8, 0x2::coin::from_balance<T2>(v20, arg12), arg11, arg12);
        let v30 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg4, v28, arg11, arg12));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v30), v27, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v30, v27), 0x2::balance::zero<T1>(), v25);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::balance::zero<T2>(), v26, v19);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v30, arg12), 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v29, 0x2::tx_context::sender(arg12));
    }

    public fun flash_ca_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 41) {
            if (arg6 == 12) {
                if (arg7 == 11) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg4 == 45) {
                if (arg6 == 16) {
                    if (arg7 == 11) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5
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
            if (v2) {
                true
            } else {
                let v3 = if (arg4 == 48) {
                    if (arg6 == 28) {
                        if (arg7 == 11) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                if (v3) {
                    true
                } else {
                    let v4 = if (arg4 == 53) {
                        if (arg6 == 4) {
                            if (arg7 == 11) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg4 == 55) {
                            if (arg6 == 6) {
                                if (arg7 == 11) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg4 == 56) {
                                if (arg6 == 7) {
                                    if (arg7 == 11) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg4 == 60) {
                                    if (arg6 == 11) {
                                        if (arg7 == 12) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg4 == 64) {
                                        if (arg6 == 16) {
                                            if (arg7 == 12) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5
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
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg4 == 67) {
                                            if (arg6 == 28) {
                                                if (arg7 == 12) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                        if (v9) {
                                            true
                                        } else {
                                            let v10 = if (arg4 == 72) {
                                                if (arg6 == 4) {
                                                    if (arg7 == 12) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                            if (v10) {
                                                true
                                            } else {
                                                let v11 = if (arg4 == 74) {
                                                    if (arg6 == 6) {
                                                        if (arg7 == 12) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                if (v11) {
                                                    true
                                                } else {
                                                    let v12 = if (arg4 == 75) {
                                                        if (arg6 == 7) {
                                                            if (arg7 == 12) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                    if (v12) {
                                                        true
                                                    } else {
                                                        let v13 = if (arg4 == 136) {
                                                            if (arg6 == 11) {
                                                                if (arg7 == 16) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5) {
                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                        if (v13) {
                                                            true
                                                        } else {
                                                            let v14 = if (arg4 == 137) {
                                                                if (arg6 == 12) {
                                                                    if (arg7 == 16) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5) {
                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                            if (v14) {
                                                                true
                                                            } else {
                                                                let v15 = if (arg4 == 143) {
                                                                    if (arg6 == 28) {
                                                                        if (arg7 == 16) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5) {
                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                                if (v15) {
                                                                    true
                                                                } else {
                                                                    let v16 = if (arg4 == 148) {
                                                                        if (arg6 == 4) {
                                                                            if (arg7 == 16) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5) {
                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                                    if (v16) {
                                                                        true
                                                                    } else {
                                                                        let v17 = if (arg4 == 151) {
                                                                            if (arg6 == 7) {
                                                                                if (arg7 == 16) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5) {
                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                                        if (v17) {
                                                                            true
                                                                        } else {
                                                                            let v18 = if (arg4 == 193) {
                                                                                if (arg6 == 11) {
                                                                                    if (arg7 == 28) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                                            if (v18) {
                                                                                true
                                                                            } else {
                                                                                let v19 = if (arg4 == 194) {
                                                                                    if (arg6 == 12) {
                                                                                        if (arg7 == 28) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                                                if (v19) {
                                                                                    true
                                                                                } else {
                                                                                    let v20 = if (arg4 == 198) {
                                                                                        if (arg6 == 16) {
                                                                                            if (arg7 == 28) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5
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
                                                                                    if (v20) {
                                                                                        true
                                                                                    } else {
                                                                                        let v21 = if (arg4 == 205) {
                                                                                            if (arg6 == 4) {
                                                                                                if (arg7 == 28) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                                                        if (v21) {
                                                                                            true
                                                                                        } else {
                                                                                            let v22 = if (arg4 == 207) {
                                                                                                if (arg6 == 6) {
                                                                                                    if (arg7 == 28) {
                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                                            if (v22) {
                                                                                                true
                                                                                            } else {
                                                                                                let v23 = if (arg4 == 208) {
                                                                                                    if (arg6 == 7) {
                                                                                                        if (arg7 == 28) {
                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                                                                if (v23) {
                                                                                                    true
                                                                                                } else {
                                                                                                    let v24 = if (arg4 == 245) {
                                                                                                        if (arg6 == 6) {
                                                                                                            if (arg7 == 3) {
                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                                                                    if (v24) {
                                                                                                        true
                                                                                                    } else {
                                                                                                        let v25 = if (arg4 == 288) {
                                                                                                            if (arg6 == 11) {
                                                                                                                if (arg7 == 4) {
                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                                                                        if (v25) {
                                                                                                            true
                                                                                                        } else {
                                                                                                            let v26 = if (arg4 == 289) {
                                                                                                                if (arg6 == 12) {
                                                                                                                    if (arg7 == 4) {
                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                                                                            if (v26) {
                                                                                                                true
                                                                                                            } else {
                                                                                                                let v27 = if (arg4 == 293) {
                                                                                                                    if (arg6 == 16) {
                                                                                                                        if (arg7 == 4) {
                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5
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
                                                                                                                if (v27) {
                                                                                                                    true
                                                                                                                } else {
                                                                                                                    let v28 = if (arg4 == 296) {
                                                                                                                        if (arg6 == 28) {
                                                                                                                            if (arg7 == 4) {
                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                                                                                    if (v28) {
                                                                                                                        true
                                                                                                                    } else {
                                                                                                                        let v29 = if (arg4 == 302) {
                                                                                                                            if (arg6 == 6) {
                                                                                                                                if (arg7 == 4) {
                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                                                                        if (v29) {
                                                                                                                            true
                                                                                                                        } else {
                                                                                                                            let v30 = if (arg4 == 303) {
                                                                                                                                if (arg6 == 7) {
                                                                                                                                    if (arg7 == 4) {
                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                                                                                            if (v30) {
                                                                                                                                true
                                                                                                                            } else {
                                                                                                                                let v31 = if (arg4 == 326) {
                                                                                                                                    if (arg6 == 11) {
                                                                                                                                        if (arg7 == 6) {
                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                                                                                                if (v31) {
                                                                                                                                    true
                                                                                                                                } else {
                                                                                                                                    let v32 = if (arg4 == 327) {
                                                                                                                                        if (arg6 == 12) {
                                                                                                                                            if (arg7 == 6) {
                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                                                                                                    if (v32) {
                                                                                                                                        true
                                                                                                                                    } else {
                                                                                                                                        let v33 = if (arg4 == 334) {
                                                                                                                                            if (arg6 == 28) {
                                                                                                                                                if (arg7 == 6) {
                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                                                                                                        if (v33) {
                                                                                                                                            true
                                                                                                                                        } else {
                                                                                                                                            let v34 = if (arg4 == 336) {
                                                                                                                                                if (arg6 == 3) {
                                                                                                                                                    if (arg7 == 6) {
                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                                                                                                                            if (v34) {
                                                                                                                                                true
                                                                                                                                            } else {
                                                                                                                                                let v35 = if (arg4 == 339) {
                                                                                                                                                    if (arg6 == 4) {
                                                                                                                                                        if (arg7 == 6) {
                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                                                                                                                if (v35) {
                                                                                                                                                    true
                                                                                                                                                } else {
                                                                                                                                                    let v36 = if (arg4 == 341) {
                                                                                                                                                        if (arg6 == 7) {
                                                                                                                                                            if (arg7 == 6) {
                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                                                                                                                    if (v36) {
                                                                                                                                                        true
                                                                                                                                                    } else {
                                                                                                                                                        let v37 = if (arg4 == 342) {
                                                                                                                                                            if (arg6 == 9) {
                                                                                                                                                                if (arg7 == 6) {
                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                                                                                                                                        if (v37) {
                                                                                                                                                            true
                                                                                                                                                        } else {
                                                                                                                                                            let v38 = if (arg4 == 345) {
                                                                                                                                                                if (arg6 == 11) {
                                                                                                                                                                    if (arg7 == 7) {
                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                                                                                                                            if (v38) {
                                                                                                                                                                true
                                                                                                                                                            } else {
                                                                                                                                                                let v39 = if (arg4 == 346) {
                                                                                                                                                                    if (arg6 == 12) {
                                                                                                                                                                        if (arg7 == 7) {
                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                                                                                                                                if (v39) {
                                                                                                                                                                    true
                                                                                                                                                                } else {
                                                                                                                                                                    let v40 = if (arg4 == 350) {
                                                                                                                                                                        if (arg6 == 16) {
                                                                                                                                                                            if (arg7 == 7) {
                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5
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
                                                                                                                                                                    if (v40) {
                                                                                                                                                                        true
                                                                                                                                                                    } else {
                                                                                                                                                                        let v41 = if (arg4 == 353) {
                                                                                                                                                                            if (arg6 == 28) {
                                                                                                                                                                                if (arg7 == 7) {
                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                                                                                                                                        if (v41) {
                                                                                                                                                                            true
                                                                                                                                                                        } else {
                                                                                                                                                                            let v42 = if (arg4 == 358) {
                                                                                                                                                                                if (arg6 == 4) {
                                                                                                                                                                                    if (arg7 == 7) {
                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                                                                                                                                            if (v42) {
                                                                                                                                                                                true
                                                                                                                                                                            } else {
                                                                                                                                                                                let v43 = if (arg4 == 360) {
                                                                                                                                                                                    if (arg6 == 6) {
                                                                                                                                                                                        if (arg7 == 7) {
                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                                                                                                                                if (v43) {
                                                                                                                                                                                    true
                                                                                                                                                                                } else if (arg4 == 379) {
                                                                                                                                                                                    if (arg6 == 6) {
                                                                                                                                                                                        if (arg7 == 9) {
                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4
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
                                                                                                                                                                            }
                                                                                                                                                                        }
                                                                                                                                                                    }
                                                                                                                                                                }
                                                                                                                                                            }
                                                                                                                                                        }
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                }
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg8 > 0, 2);
        let (v44, v45, v46) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, false, arg8, 79226673515401279992447579054, arg10);
        let v47 = v46;
        let v48 = v44;
        0x2::balance::destroy_zero<T1>(v45);
        assert!(0x2::balance::value<T2>(&v48) == arg8, 2);
        let v49 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v47);
        let (v50, v51, v52) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v49, 4295048017, arg10);
        let v53 = v52;
        let v54 = v51;
        0x2::balance::destroy_zero<T0>(v50);
        assert!(0x2::balance::value<T1>(&v54) == v49, 2);
        let v55 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v53);
        let (v56, v57) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T2, T0>(arg3, arg5, arg6, arg7, 0x2::coin::from_balance<T2>(v48, arg11), arg10, arg11);
        let v58 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v56, arg10, arg11));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v58), v55, arg9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v58, v55), 0x2::balance::zero<T1>(), v53);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), v54, v47);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v58, arg11), 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v57, 0x2::tx_context::sender(arg11));
    }

    public fun flash_ca_cb_bb<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg6 == 236) {
            if (arg8 == 16) {
                if (arg9 == 3) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
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
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else if (arg6 == 369) {
            if (arg8 == 16) {
                if (arg9 == 9) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
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
        } else {
            false
        };
        assert!(v1, 0);
        assert!(arg10 > 0, 2);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T2>(arg12, arg1, arg4, false, false, arg10, 79226673515401279992447579054);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T2>(v3);
        assert!(0x2::balance::value<T3>(&v6) == arg10, 2);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T3, T2>(&v5);
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, v7, 79226673515401279992447579054, arg12);
        let v11 = v10;
        let v12 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        assert!(0x2::balance::value<T2>(&v12) == v7, 2);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v11);
        let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, false, v13, 4295048017, arg12);
        let v17 = v16;
        let v18 = v15;
        0x2::balance::destroy_zero<T0>(v14);
        assert!(0x2::balance::value<T1>(&v18) == v13, 2);
        let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v17);
        let (v20, v21) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T3, T0>(arg5, arg7, arg8, arg9, 0x2::coin::from_balance<T3>(v6, arg13), arg12, arg13);
        let v22 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg5, v20, arg12, arg13));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v22), v19, arg11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v22, v19), 0x2::balance::zero<T1>(), v17);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v18, v11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T2>(arg1, arg4, 0x2::balance::zero<T3>(), v12, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v22, arg13), 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v21, 0x2::tx_context::sender(arg13));
    }

    public fun flash_ca_cb_ca<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: u64, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5 == 40) {
            if (arg7 == 10) {
                if (arg8 == 11) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg5 == 42) {
                if (arg7 == 13) {
                    if (arg8 == 11) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg5 == 44) {
                    if (arg7 == 15) {
                        if (arg8 == 11) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                } else {
                    false
                };
                if (v3) {
                    true
                } else {
                    let v4 = if (arg5 == 49) {
                        if (arg7 == 29) {
                            if (arg8 == 11) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                    } else {
                        false
                    };
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg5 == 51) {
                            if (arg7 == 31) {
                                if (arg8 == 11) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                        } else {
                            false
                        };
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg5 == 52) {
                                if (arg7 == 33) {
                                    if (arg8 == 11) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                            } else {
                                false
                            };
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg5 == 54) {
                                    if (arg7 == 5) {
                                        if (arg8 == 11) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                } else {
                                    false
                                };
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg5 == 59) {
                                        if (arg7 == 10) {
                                            if (arg8 == 12) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                    } else {
                                        false
                                    };
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg5 == 61) {
                                            if (arg7 == 13) {
                                                if (arg8 == 12) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                        } else {
                                            false
                                        };
                                        if (v9) {
                                            true
                                        } else {
                                            let v10 = if (arg5 == 63) {
                                                if (arg7 == 15) {
                                                    if (arg8 == 12) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                            } else {
                                                false
                                            };
                                            if (v10) {
                                                true
                                            } else {
                                                let v11 = if (arg5 == 68) {
                                                    if (arg7 == 29) {
                                                        if (arg8 == 12) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                } else {
                                                    false
                                                };
                                                if (v11) {
                                                    true
                                                } else {
                                                    let v12 = if (arg5 == 70) {
                                                        if (arg7 == 31) {
                                                            if (arg8 == 12) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                    } else {
                                                        false
                                                    };
                                                    if (v12) {
                                                        true
                                                    } else {
                                                        let v13 = if (arg5 == 71) {
                                                            if (arg7 == 33) {
                                                                if (arg8 == 12) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                        } else {
                                                            false
                                                        };
                                                        if (v13) {
                                                            true
                                                        } else {
                                                            let v14 = if (arg5 == 73) {
                                                                if (arg7 == 5) {
                                                                    if (arg8 == 12) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                            } else {
                                                                false
                                                            };
                                                            if (v14) {
                                                                true
                                                            } else {
                                                                let v15 = if (arg5 == 192) {
                                                                    if (arg7 == 10) {
                                                                        if (arg8 == 28) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                } else {
                                                                    false
                                                                };
                                                                if (v15) {
                                                                    true
                                                                } else {
                                                                    let v16 = if (arg5 == 195) {
                                                                        if (arg7 == 13) {
                                                                            if (arg8 == 28) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                    } else {
                                                                        false
                                                                    };
                                                                    if (v16) {
                                                                        true
                                                                    } else {
                                                                        let v17 = if (arg5 == 197) {
                                                                            if (arg7 == 15) {
                                                                                if (arg8 == 28) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                                                        } else {
                                                                            false
                                                                        };
                                                                        if (v17) {
                                                                            true
                                                                        } else {
                                                                            let v18 = if (arg5 == 201) {
                                                                                if (arg7 == 29) {
                                                                                    if (arg8 == 28) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                                            } else {
                                                                                false
                                                                            };
                                                                            if (v18) {
                                                                                true
                                                                            } else {
                                                                                let v19 = if (arg5 == 203) {
                                                                                    if (arg7 == 31) {
                                                                                        if (arg8 == 28) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                                                } else {
                                                                                    false
                                                                                };
                                                                                if (v19) {
                                                                                    true
                                                                                } else {
                                                                                    let v20 = if (arg5 == 204) {
                                                                                        if (arg7 == 33) {
                                                                                            if (arg8 == 28) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                                                    } else {
                                                                                        false
                                                                                    };
                                                                                    if (v20) {
                                                                                        true
                                                                                    } else {
                                                                                        let v21 = if (arg5 == 206) {
                                                                                            if (arg7 == 5) {
                                                                                                if (arg8 == 28) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                                                        } else {
                                                                                            false
                                                                                        };
                                                                                        if (v21) {
                                                                                            true
                                                                                        } else {
                                                                                            let v22 = if (arg5 == 229) {
                                                                                                if (arg7 == 1) {
                                                                                                    if (arg8 == 3) {
                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                                            } else {
                                                                                                false
                                                                                            };
                                                                                            if (v22) {
                                                                                                true
                                                                                            } else {
                                                                                                let v23 = if (arg5 == 230) {
                                                                                                    if (arg7 == 10) {
                                                                                                        if (arg8 == 3) {
                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                                                } else {
                                                                                                    false
                                                                                                };
                                                                                                if (v23) {
                                                                                                    true
                                                                                                } else {
                                                                                                    let v24 = if (arg5 == 233) {
                                                                                                        if (arg7 == 13) {
                                                                                                            if (arg8 == 3) {
                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                                                    } else {
                                                                                                        false
                                                                                                    };
                                                                                                    if (v24) {
                                                                                                        true
                                                                                                    } else {
                                                                                                        let v25 = if (arg5 == 235) {
                                                                                                            if (arg7 == 15) {
                                                                                                                if (arg8 == 3) {
                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                                                                                        } else {
                                                                                                            false
                                                                                                        };
                                                                                                        if (v25) {
                                                                                                            true
                                                                                                        } else {
                                                                                                            let v26 = if (arg5 == 241) {
                                                                                                                if (arg7 == 31) {
                                                                                                                    if (arg8 == 3) {
                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                                                                            } else {
                                                                                                                false
                                                                                                            };
                                                                                                            if (v26) {
                                                                                                                true
                                                                                                            } else {
                                                                                                                let v27 = if (arg5 == 242) {
                                                                                                                    if (arg7 == 33) {
                                                                                                                        if (arg8 == 3) {
                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                                                                                } else {
                                                                                                                    false
                                                                                                                };
                                                                                                                if (v27) {
                                                                                                                    true
                                                                                                                } else {
                                                                                                                    let v28 = if (arg5 == 244) {
                                                                                                                        if (arg7 == 5) {
                                                                                                                            if (arg8 == 3) {
                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                                                                                    } else {
                                                                                                                        false
                                                                                                                    };
                                                                                                                    if (v28) {
                                                                                                                        true
                                                                                                                    } else {
                                                                                                                        let v29 = if (arg5 == 287) {
                                                                                                                            if (arg7 == 10) {
                                                                                                                                if (arg8 == 4) {
                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                                                                        } else {
                                                                                                                            false
                                                                                                                        };
                                                                                                                        if (v29) {
                                                                                                                            true
                                                                                                                        } else {
                                                                                                                            let v30 = if (arg5 == 290) {
                                                                                                                                if (arg7 == 13) {
                                                                                                                                    if (arg8 == 4) {
                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                                                                            } else {
                                                                                                                                false
                                                                                                                            };
                                                                                                                            if (v30) {
                                                                                                                                true
                                                                                                                            } else {
                                                                                                                                let v31 = if (arg5 == 292) {
                                                                                                                                    if (arg7 == 15) {
                                                                                                                                        if (arg8 == 4) {
                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                                                                                                                } else {
                                                                                                                                    false
                                                                                                                                };
                                                                                                                                if (v31) {
                                                                                                                                    true
                                                                                                                                } else {
                                                                                                                                    let v32 = if (arg5 == 297) {
                                                                                                                                        if (arg7 == 29) {
                                                                                                                                            if (arg8 == 4) {
                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                                                                                                    } else {
                                                                                                                                        false
                                                                                                                                    };
                                                                                                                                    if (v32) {
                                                                                                                                        true
                                                                                                                                    } else {
                                                                                                                                        let v33 = if (arg5 == 299) {
                                                                                                                                            if (arg7 == 31) {
                                                                                                                                                if (arg8 == 4) {
                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                                                                                                        } else {
                                                                                                                                            false
                                                                                                                                        };
                                                                                                                                        if (v33) {
                                                                                                                                            true
                                                                                                                                        } else {
                                                                                                                                            let v34 = if (arg5 == 300) {
                                                                                                                                                if (arg7 == 33) {
                                                                                                                                                    if (arg8 == 4) {
                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                                                                                                            } else {
                                                                                                                                                false
                                                                                                                                            };
                                                                                                                                            if (v34) {
                                                                                                                                                true
                                                                                                                                            } else {
                                                                                                                                                let v35 = if (arg5 == 301) {
                                                                                                                                                    if (arg7 == 5) {
                                                                                                                                                        if (arg8 == 4) {
                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                                                                                                                } else {
                                                                                                                                                    false
                                                                                                                                                };
                                                                                                                                                if (v35) {
                                                                                                                                                    true
                                                                                                                                                } else {
                                                                                                                                                    let v36 = if (arg5 == 344) {
                                                                                                                                                        if (arg7 == 10) {
                                                                                                                                                            if (arg8 == 7) {
                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                                                                                                    } else {
                                                                                                                                                        false
                                                                                                                                                    };
                                                                                                                                                    if (v36) {
                                                                                                                                                        true
                                                                                                                                                    } else {
                                                                                                                                                        let v37 = if (arg5 == 347) {
                                                                                                                                                            if (arg7 == 13) {
                                                                                                                                                                if (arg8 == 7) {
                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                                                                                                        } else {
                                                                                                                                                            false
                                                                                                                                                        };
                                                                                                                                                        if (v37) {
                                                                                                                                                            true
                                                                                                                                                        } else {
                                                                                                                                                            let v38 = if (arg5 == 349) {
                                                                                                                                                                if (arg7 == 15) {
                                                                                                                                                                    if (arg8 == 7) {
                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                                                                                                                                            } else {
                                                                                                                                                                false
                                                                                                                                                            };
                                                                                                                                                            if (v38) {
                                                                                                                                                                true
                                                                                                                                                            } else {
                                                                                                                                                                let v39 = if (arg5 == 354) {
                                                                                                                                                                    if (arg7 == 29) {
                                                                                                                                                                        if (arg8 == 7) {
                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                                                                                                                                } else {
                                                                                                                                                                    false
                                                                                                                                                                };
                                                                                                                                                                if (v39) {
                                                                                                                                                                    true
                                                                                                                                                                } else {
                                                                                                                                                                    let v40 = if (arg5 == 356) {
                                                                                                                                                                        if (arg7 == 31) {
                                                                                                                                                                            if (arg8 == 7) {
                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                                                                                                                                    } else {
                                                                                                                                                                        false
                                                                                                                                                                    };
                                                                                                                                                                    if (v40) {
                                                                                                                                                                        true
                                                                                                                                                                    } else {
                                                                                                                                                                        let v41 = if (arg5 == 357) {
                                                                                                                                                                            if (arg7 == 33) {
                                                                                                                                                                                if (arg8 == 7) {
                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                                                                                                                                        } else {
                                                                                                                                                                            false
                                                                                                                                                                        };
                                                                                                                                                                        if (v41) {
                                                                                                                                                                            true
                                                                                                                                                                        } else {
                                                                                                                                                                            let v42 = if (arg5 == 359) {
                                                                                                                                                                                if (arg7 == 5) {
                                                                                                                                                                                    if (arg8 == 7) {
                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                                                                                                                                            } else {
                                                                                                                                                                                false
                                                                                                                                                                            };
                                                                                                                                                                            if (v42) {
                                                                                                                                                                                true
                                                                                                                                                                            } else {
                                                                                                                                                                                let v43 = if (arg5 == 362) {
                                                                                                                                                                                    if (arg7 == 1) {
                                                                                                                                                                                        if (arg8 == 9) {
                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                                                                                                                                } else {
                                                                                                                                                                                    false
                                                                                                                                                                                };
                                                                                                                                                                                if (v43) {
                                                                                                                                                                                    true
                                                                                                                                                                                } else {
                                                                                                                                                                                    let v44 = if (arg5 == 363) {
                                                                                                                                                                                        if (arg7 == 10) {
                                                                                                                                                                                            if (arg8 == 9) {
                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                                                                                                                                    } else {
                                                                                                                                                                                        false
                                                                                                                                                                                    };
                                                                                                                                                                                    if (v44) {
                                                                                                                                                                                        true
                                                                                                                                                                                    } else {
                                                                                                                                                                                        let v45 = if (arg5 == 366) {
                                                                                                                                                                                            if (arg7 == 13) {
                                                                                                                                                                                                if (arg8 == 9) {
                                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                                                                                                                                        } else {
                                                                                                                                                                                            false
                                                                                                                                                                                        };
                                                                                                                                                                                        if (v45) {
                                                                                                                                                                                            true
                                                                                                                                                                                        } else {
                                                                                                                                                                                            let v46 = if (arg5 == 368) {
                                                                                                                                                                                                if (arg7 == 15) {
                                                                                                                                                                                                    if (arg8 == 9) {
                                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                                                                                                                                                                            } else {
                                                                                                                                                                                                false
                                                                                                                                                                                            };
                                                                                                                                                                                            if (v46) {
                                                                                                                                                                                                true
                                                                                                                                                                                            } else {
                                                                                                                                                                                                let v47 = if (arg5 == 373) {
                                                                                                                                                                                                    if (arg7 == 29) {
                                                                                                                                                                                                        if (arg8 == 9) {
                                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                                                                                                                                                                } else {
                                                                                                                                                                                                    false
                                                                                                                                                                                                };
                                                                                                                                                                                                if (v47) {
                                                                                                                                                                                                    true
                                                                                                                                                                                                } else {
                                                                                                                                                                                                    let v48 = if (arg5 == 375) {
                                                                                                                                                                                                        if (arg7 == 31) {
                                                                                                                                                                                                            if (arg8 == 9) {
                                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                                                                                                                                                                    } else {
                                                                                                                                                                                                        false
                                                                                                                                                                                                    };
                                                                                                                                                                                                    if (v48) {
                                                                                                                                                                                                        true
                                                                                                                                                                                                    } else {
                                                                                                                                                                                                        let v49 = if (arg5 == 376) {
                                                                                                                                                                                                            if (arg7 == 33) {
                                                                                                                                                                                                                if (arg8 == 9) {
                                                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                                                                                                                                                                        } else {
                                                                                                                                                                                                            false
                                                                                                                                                                                                        };
                                                                                                                                                                                                        if (v49) {
                                                                                                                                                                                                            true
                                                                                                                                                                                                        } else if (arg5 == 378) {
                                                                                                                                                                                                            if (arg7 == 5) {
                                                                                                                                                                                                                if (arg8 == 9) {
                                                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                                                                                                                                                                        } else {
                                                                                                                                                                                                            false
                                                                                                                                                                                                        }
                                                                                                                                                                                                    }
                                                                                                                                                                                                }
                                                                                                                                                                                            }
                                                                                                                                                                                        }
                                                                                                                                                                                    }
                                                                                                                                                                                }
                                                                                                                                                                            }
                                                                                                                                                                        }
                                                                                                                                                                    }
                                                                                                                                                                }
                                                                                                                                                            }
                                                                                                                                                        }
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                }
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg9 > 0, 2);
        let (v50, v51, v52) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg9, 4295048017, arg11);
        let v53 = v52;
        let v54 = v51;
        0x2::balance::destroy_zero<T2>(v50);
        assert!(0x2::balance::value<T3>(&v54) == arg9, 2);
        let v55 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v53);
        let (v56, v57, v58) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, false, v55, 79226673515401279992447579054, arg11);
        let v59 = v58;
        let v60 = v56;
        0x2::balance::destroy_zero<T1>(v57);
        assert!(0x2::balance::value<T2>(&v60) == v55, 2);
        let v61 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v59);
        let (v62, v63, v64) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v61, 4295048017, arg11);
        let v65 = v64;
        let v66 = v63;
        0x2::balance::destroy_zero<T0>(v62);
        assert!(0x2::balance::value<T1>(&v66) == v61, 2);
        let v67 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v65);
        let (v68, v69) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T3, T0>(arg4, arg6, arg7, arg8, 0x2::coin::from_balance<T3>(v54, arg12), arg11, arg12);
        let v70 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg4, v68, arg11, arg12));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v70), v67, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v70, v67), 0x2::balance::zero<T1>(), v65);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), v66, v59);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, v60, 0x2::balance::zero<T3>(), v53);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v70, arg12), 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v69, 0x2::tx_context::sender(arg12));
    }

    public fun flash_ca_cb_ca_bb<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: u64, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7 == 43) {
            if (arg9 == 14) {
                if (arg10 == 11) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg7 == 62) {
                if (arg9 == 14) {
                    if (arg10 == 12) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg7 == 196) {
                    if (arg9 == 14) {
                        if (arg10 == 28) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    true
                } else {
                    let v4 = if (arg7 == 237) {
                        if (arg9 == 18) {
                            if (arg10 == 3) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg7 == 238) {
                            if (arg9 == 2) {
                                if (arg10 == 3) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg7 == 291) {
                                if (arg9 == 14) {
                                    if (arg10 == 4) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg7 == 348) {
                                    if (arg9 == 14) {
                                        if (arg10 == 7) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg7 == 367) {
                                        if (arg9 == 14) {
                                            if (arg10 == 9) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    };
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg7 == 370) {
                                            if (arg9 == 18) {
                                                if (arg10 == 9) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        };
                                        if (v9) {
                                            true
                                        } else if (arg7 == 371) {
                                            if (arg9 == 2) {
                                                if (arg10 == 9) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T3>>(arg5) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg11 > 0, 2);
        let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T4, T3>(arg13, arg1, arg5, false, false, arg11, 79226673515401279992447579054);
        let v13 = v12;
        let v14 = v10;
        0x2::balance::destroy_zero<T3>(v11);
        assert!(0x2::balance::value<T4>(&v14) == arg11, 2);
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T4, T3>(&v13);
        let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, v15, 4295048017, arg13);
        let v19 = v18;
        let v20 = v17;
        0x2::balance::destroy_zero<T2>(v16);
        assert!(0x2::balance::value<T3>(&v20) == v15, 2);
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v19);
        let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, v21, 79226673515401279992447579054, arg13);
        let v25 = v24;
        let v26 = v22;
        0x2::balance::destroy_zero<T1>(v23);
        assert!(0x2::balance::value<T2>(&v26) == v21, 2);
        let v27 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v25);
        let (v28, v29, v30) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, false, v27, 4295048017, arg13);
        let v31 = v30;
        let v32 = v29;
        0x2::balance::destroy_zero<T0>(v28);
        assert!(0x2::balance::value<T1>(&v32) == v27, 2);
        let v33 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v31);
        let (v34, v35) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T4, T0>(arg6, arg8, arg9, arg10, 0x2::coin::from_balance<T4>(v14, arg14), arg13, arg14);
        let v36 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg6, v34, arg13, arg14));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v36), v33, arg12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v36, v33), 0x2::balance::zero<T1>(), v31);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v32, v25);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v26, 0x2::balance::zero<T3>(), v19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T4, T3>(arg1, arg5, 0x2::balance::zero<T4>(), v20, v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v36, arg14), 0x2::tx_context::sender(arg14));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v35, 0x2::tx_context::sender(arg14));
    }

    public fun flash_ca_cb_ca_cb<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg6 == 50) {
            if (arg8 == 3) {
                if (arg9 == 11) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg6 == 57) {
                if (arg8 == 9) {
                    if (arg9 == 11) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg6 == 69) {
                    if (arg8 == 3) {
                        if (arg9 == 12) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    true
                } else {
                    let v4 = if (arg6 == 76) {
                        if (arg8 == 9) {
                            if (arg9 == 12) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg6 == 202) {
                            if (arg8 == 3) {
                                if (arg9 == 28) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg6 == 209) {
                                if (arg8 == 9) {
                                    if (arg9 == 28) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg6 == 231) {
                                    if (arg8 == 11) {
                                        if (arg9 == 3) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg6 == 232) {
                                        if (arg8 == 12) {
                                            if (arg9 == 3) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    };
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg6 == 239) {
                                            if (arg8 == 28) {
                                                if (arg9 == 3) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        };
                                        if (v9) {
                                            true
                                        } else {
                                            let v10 = if (arg6 == 243) {
                                                if (arg8 == 4) {
                                                    if (arg9 == 3) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            };
                                            if (v10) {
                                                true
                                            } else {
                                                let v11 = if (arg6 == 246) {
                                                    if (arg8 == 7) {
                                                        if (arg9 == 3) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                    } else {
                                                        false
                                                    }
                                                } else {
                                                    false
                                                };
                                                if (v11) {
                                                    true
                                                } else {
                                                    let v12 = if (arg6 == 247) {
                                                        if (arg8 == 9) {
                                                            if (arg9 == 3) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                                        } else {
                                                            false
                                                        }
                                                    } else {
                                                        false
                                                    };
                                                    if (v12) {
                                                        true
                                                    } else {
                                                        let v13 = if (arg6 == 298) {
                                                            if (arg8 == 3) {
                                                                if (arg9 == 4) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                                            } else {
                                                                false
                                                            }
                                                        } else {
                                                            false
                                                        };
                                                        if (v13) {
                                                            true
                                                        } else {
                                                            let v14 = if (arg6 == 304) {
                                                                if (arg8 == 9) {
                                                                    if (arg9 == 4) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                                                } else {
                                                                    false
                                                                }
                                                            } else {
                                                                false
                                                            };
                                                            if (v14) {
                                                                true
                                                            } else {
                                                                let v15 = if (arg6 == 355) {
                                                                    if (arg8 == 3) {
                                                                        if (arg9 == 7) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                                                    } else {
                                                                        false
                                                                    }
                                                                } else {
                                                                    false
                                                                };
                                                                if (v15) {
                                                                    true
                                                                } else {
                                                                    let v16 = if (arg6 == 361) {
                                                                        if (arg8 == 9) {
                                                                            if (arg9 == 7) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                                                        } else {
                                                                            false
                                                                        }
                                                                    } else {
                                                                        false
                                                                    };
                                                                    if (v16) {
                                                                        true
                                                                    } else {
                                                                        let v17 = if (arg6 == 364) {
                                                                            if (arg8 == 11) {
                                                                                if (arg9 == 9) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                                            } else {
                                                                                false
                                                                            }
                                                                        } else {
                                                                            false
                                                                        };
                                                                        if (v17) {
                                                                            true
                                                                        } else {
                                                                            let v18 = if (arg6 == 365) {
                                                                                if (arg8 == 12) {
                                                                                    if (arg9 == 9) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                                                } else {
                                                                                    false
                                                                                }
                                                                            } else {
                                                                                false
                                                                            };
                                                                            if (v18) {
                                                                                true
                                                                            } else {
                                                                                let v19 = if (arg6 == 372) {
                                                                                    if (arg8 == 28) {
                                                                                        if (arg9 == 9) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                                                    } else {
                                                                                        false
                                                                                    }
                                                                                } else {
                                                                                    false
                                                                                };
                                                                                if (v19) {
                                                                                    true
                                                                                } else {
                                                                                    let v20 = if (arg6 == 374) {
                                                                                        if (arg8 == 3) {
                                                                                            if (arg9 == 9) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                                                                        } else {
                                                                                            false
                                                                                        }
                                                                                    } else {
                                                                                        false
                                                                                    };
                                                                                    if (v20) {
                                                                                        true
                                                                                    } else {
                                                                                        let v21 = if (arg6 == 377) {
                                                                                            if (arg8 == 4) {
                                                                                                if (arg9 == 9) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                                                            } else {
                                                                                                false
                                                                                            }
                                                                                        } else {
                                                                                            false
                                                                                        };
                                                                                        if (v21) {
                                                                                            true
                                                                                        } else if (arg6 == 380) {
                                                                                            if (arg8 == 7) {
                                                                                                if (arg9 == 9) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea) {
                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T3>>(arg4) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                                                            } else {
                                                                                                false
                                                                                            }
                                                                                        } else {
                                                                                            false
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg10 > 0, 2);
        let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T4, T3>(arg0, arg4, false, false, arg10, 79226673515401279992447579054, arg12);
        let v25 = v24;
        let v26 = v22;
        0x2::balance::destroy_zero<T3>(v23);
        assert!(0x2::balance::value<T4>(&v26) == arg10, 2);
        let v27 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T4, T3>(&v25);
        let (v28, v29, v30) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, v27, 4295048017, arg12);
        let v31 = v30;
        let v32 = v29;
        0x2::balance::destroy_zero<T2>(v28);
        assert!(0x2::balance::value<T3>(&v32) == v27, 2);
        let v33 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v31);
        let (v34, v35, v36) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, false, v33, 79226673515401279992447579054, arg12);
        let v37 = v36;
        let v38 = v34;
        0x2::balance::destroy_zero<T1>(v35);
        assert!(0x2::balance::value<T2>(&v38) == v33, 2);
        let v39 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v37);
        let (v40, v41, v42) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v39, 4295048017, arg12);
        let v43 = v42;
        let v44 = v41;
        0x2::balance::destroy_zero<T0>(v40);
        assert!(0x2::balance::value<T1>(&v44) == v39, 2);
        let v45 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v43);
        let (v46, v47) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T4, T0>(arg5, arg7, arg8, arg9, 0x2::coin::from_balance<T4>(v26, arg13), arg12, arg13);
        let v48 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg5, v46, arg12, arg13));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v48), v45, arg11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v48, v45), 0x2::balance::zero<T1>(), v43);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), v44, v37);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, v38, 0x2::balance::zero<T3>(), v31);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T4, T3>(arg0, arg4, 0x2::balance::zero<T4>(), v32, v25);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v48, arg13), 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v47, 0x2::tx_context::sender(arg13));
    }

    public fun flash_cb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 36) {
            if (arg5 == 6) {
                if (arg6 == 10) {
                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg3 == 93) {
                if (arg5 == 6) {
                    if (arg6 == 13) {
                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg3 == 131) {
                    if (arg5 == 6) {
                        if (arg6 == 15) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    true
                } else {
                    let v4 = if (arg3 == 221) {
                        if (arg5 == 3) {
                            if (arg6 == 29) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg3 == 226) {
                            if (arg5 == 6) {
                                if (arg6 == 29) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg3 == 264) {
                                if (arg5 == 6) {
                                    if (arg6 == 31) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg3 == 283) {
                                    if (arg5 == 6) {
                                        if (arg6 == 33) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v7) {
                                    true
                                } else if (arg3 == 321) {
                                    if (arg5 == 6) {
                                        if (arg6 == 5) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg7 > 0, 2);
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, false, false, arg7, 79226673515401279992447579054, arg9);
        let v11 = v10;
        let v12 = v8;
        0x2::balance::destroy_zero<T0>(v9);
        assert!(0x2::balance::value<T1>(&v12) == arg7, 2);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v11);
        let (v14, v15) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T1, T0>(arg2, arg4, arg5, arg6, 0x2::coin::from_balance<T1>(v12, arg10), arg9, arg10);
        let v16 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v14, arg9, arg10));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v16), v13, arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v16, v13), v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg10), 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v15, 0x2::tx_context::sender(arg10));
    }

    public fun flash_cb_bb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: u64, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5 == 26) {
            if (arg7 == 16) {
                if (arg8 == 10) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
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
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg5 == 83) {
                if (arg7 == 16) {
                    if (arg8 == 13) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
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
            if (v2) {
                true
            } else {
                let v3 = if (arg5 == 121) {
                    if (arg7 == 16) {
                        if (arg8 == 15) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
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
                if (v3) {
                    true
                } else {
                    let v4 = if (arg5 == 217) {
                        if (arg7 == 16) {
                            if (arg8 == 29) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
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
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg5 == 255) {
                            if (arg7 == 16) {
                                if (arg8 == 31) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
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
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg5 == 274) {
                                if (arg7 == 16) {
                                    if (arg8 == 33) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
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
                            if (v6) {
                                true
                            } else if (arg5 == 312) {
                                if (arg7 == 16) {
                                    if (arg8 == 5) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3) == @0x1b0cc1c66185ceb8eccbc807c73243ce957f0053dfa1026149265bb2ff704a07
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
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg9 > 0, 2);
        let (v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg11, arg1, arg3, false, false, arg9, 79226673515401279992447579054);
        let v10 = v9;
        let v11 = v7;
        0x2::balance::destroy_zero<T1>(v8);
        assert!(0x2::balance::value<T2>(&v11) == arg9, 2);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v10);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, false, false, v12, 79226673515401279992447579054, arg11);
        let v16 = v15;
        let v17 = v13;
        0x2::balance::destroy_zero<T0>(v14);
        assert!(0x2::balance::value<T1>(&v17) == v12, 2);
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v16);
        let (v19, v20) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T2, T0>(arg4, arg6, arg7, arg8, 0x2::coin::from_balance<T2>(v11, arg12), arg11, arg12);
        let v21 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg4, v19, arg11, arg12));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v21), v18, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v21, v18), v16);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::balance::zero<T2>(), v17, v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg12), 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v20, 0x2::tx_context::sender(arg12));
    }

    public fun flash_cb_ca<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 20) {
            if (arg6 == 1) {
                if (arg7 == 10) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg4 == 23) {
                if (arg6 == 13) {
                    if (arg7 == 10) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
            if (v2) {
                true
            } else {
                let v3 = if (arg4 == 25) {
                    if (arg6 == 15) {
                        if (arg7 == 10) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                if (v3) {
                    true
                } else {
                    let v4 = if (arg4 == 30) {
                        if (arg6 == 29) {
                            if (arg7 == 10) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg4 == 32) {
                            if (arg6 == 31) {
                                if (arg7 == 10) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg4 == 33) {
                                if (arg6 == 33) {
                                    if (arg7 == 10) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg4 == 35) {
                                    if (arg6 == 5) {
                                        if (arg7 == 10) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg4 == 77) {
                                        if (arg6 == 1) {
                                            if (arg7 == 13) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg4 == 78) {
                                            if (arg6 == 10) {
                                                if (arg7 == 13) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                        if (v9) {
                                            true
                                        } else {
                                            let v10 = if (arg4 == 82) {
                                                if (arg6 == 15) {
                                                    if (arg7 == 13) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                            if (v10) {
                                                true
                                            } else {
                                                let v11 = if (arg4 == 87) {
                                                    if (arg6 == 29) {
                                                        if (arg7 == 13) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                if (v11) {
                                                    true
                                                } else {
                                                    let v12 = if (arg4 == 89) {
                                                        if (arg6 == 31) {
                                                            if (arg7 == 13) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                    if (v12) {
                                                        true
                                                    } else {
                                                        let v13 = if (arg4 == 90) {
                                                            if (arg6 == 33) {
                                                                if (arg7 == 13) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                        if (v13) {
                                                            true
                                                        } else {
                                                            let v14 = if (arg4 == 92) {
                                                                if (arg6 == 5) {
                                                                    if (arg7 == 13) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                            if (v14) {
                                                                true
                                                            } else {
                                                                let v15 = if (arg4 == 115) {
                                                                    if (arg6 == 1) {
                                                                        if (arg7 == 15) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                if (v15) {
                                                                    true
                                                                } else {
                                                                    let v16 = if (arg4 == 116) {
                                                                        if (arg6 == 10) {
                                                                            if (arg7 == 15) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                    if (v16) {
                                                                        true
                                                                    } else {
                                                                        let v17 = if (arg4 == 119) {
                                                                            if (arg6 == 13) {
                                                                                if (arg7 == 15) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                        if (v17) {
                                                                            true
                                                                        } else {
                                                                            let v18 = if (arg4 == 125) {
                                                                                if (arg6 == 29) {
                                                                                    if (arg7 == 15) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                                            if (v18) {
                                                                                true
                                                                            } else {
                                                                                let v19 = if (arg4 == 127) {
                                                                                    if (arg6 == 31) {
                                                                                        if (arg7 == 15) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                                                if (v19) {
                                                                                    true
                                                                                } else {
                                                                                    let v20 = if (arg4 == 128) {
                                                                                        if (arg6 == 33) {
                                                                                            if (arg7 == 15) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                                                    if (v20) {
                                                                                        true
                                                                                    } else {
                                                                                        let v21 = if (arg4 == 130) {
                                                                                            if (arg6 == 5) {
                                                                                                if (arg7 == 15) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                                                        if (v21) {
                                                                                            true
                                                                                        } else {
                                                                                            let v22 = if (arg4 == 210) {
                                                                                                if (arg6 == 1) {
                                                                                                    if (arg7 == 29) {
                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                                            if (v22) {
                                                                                                true
                                                                                            } else {
                                                                                                let v23 = if (arg4 == 211) {
                                                                                                    if (arg6 == 10) {
                                                                                                        if (arg7 == 29) {
                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                                                if (v23) {
                                                                                                    true
                                                                                                } else {
                                                                                                    let v24 = if (arg4 == 214) {
                                                                                                        if (arg6 == 13) {
                                                                                                            if (arg7 == 29) {
                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                                                    if (v24) {
                                                                                                        true
                                                                                                    } else {
                                                                                                        let v25 = if (arg4 == 216) {
                                                                                                            if (arg6 == 15) {
                                                                                                                if (arg7 == 29) {
                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                                                                                        if (v25) {
                                                                                                            true
                                                                                                        } else {
                                                                                                            let v26 = if (arg4 == 222) {
                                                                                                                if (arg6 == 31) {
                                                                                                                    if (arg7 == 29) {
                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                                                                            if (v26) {
                                                                                                                true
                                                                                                            } else {
                                                                                                                let v27 = if (arg4 == 223) {
                                                                                                                    if (arg6 == 33) {
                                                                                                                        if (arg7 == 29) {
                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                                                                                if (v27) {
                                                                                                                    true
                                                                                                                } else {
                                                                                                                    let v28 = if (arg4 == 225) {
                                                                                                                        if (arg6 == 5) {
                                                                                                                            if (arg7 == 29) {
                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                                                                                    if (v28) {
                                                                                                                        true
                                                                                                                    } else {
                                                                                                                        let v29 = if (arg4 == 248) {
                                                                                                                            if (arg6 == 1) {
                                                                                                                                if (arg7 == 31) {
                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                                                                        if (v29) {
                                                                                                                            true
                                                                                                                        } else {
                                                                                                                            let v30 = if (arg4 == 249) {
                                                                                                                                if (arg6 == 10) {
                                                                                                                                    if (arg7 == 31) {
                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                                                                            if (v30) {
                                                                                                                                true
                                                                                                                            } else {
                                                                                                                                let v31 = if (arg4 == 252) {
                                                                                                                                    if (arg6 == 13) {
                                                                                                                                        if (arg7 == 31) {
                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                                                                                if (v31) {
                                                                                                                                    true
                                                                                                                                } else {
                                                                                                                                    let v32 = if (arg4 == 254) {
                                                                                                                                        if (arg6 == 15) {
                                                                                                                                            if (arg7 == 31) {
                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                                                                                                                    if (v32) {
                                                                                                                                        true
                                                                                                                                    } else {
                                                                                                                                        let v33 = if (arg4 == 259) {
                                                                                                                                            if (arg6 == 29) {
                                                                                                                                                if (arg7 == 31) {
                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                                                                                                        if (v33) {
                                                                                                                                            true
                                                                                                                                        } else {
                                                                                                                                            let v34 = if (arg4 == 261) {
                                                                                                                                                if (arg6 == 33) {
                                                                                                                                                    if (arg7 == 31) {
                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                                                                                                            if (v34) {
                                                                                                                                                true
                                                                                                                                            } else {
                                                                                                                                                let v35 = if (arg4 == 263) {
                                                                                                                                                    if (arg6 == 5) {
                                                                                                                                                        if (arg7 == 31) {
                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                                                                                                                if (v35) {
                                                                                                                                                    true
                                                                                                                                                } else {
                                                                                                                                                    let v36 = if (arg4 == 267) {
                                                                                                                                                        if (arg6 == 1) {
                                                                                                                                                            if (arg7 == 33) {
                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                                                                                                    if (v36) {
                                                                                                                                                        true
                                                                                                                                                    } else {
                                                                                                                                                        let v37 = if (arg4 == 268) {
                                                                                                                                                            if (arg6 == 10) {
                                                                                                                                                                if (arg7 == 33) {
                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                                                                                                        if (v37) {
                                                                                                                                                            true
                                                                                                                                                        } else {
                                                                                                                                                            let v38 = if (arg4 == 271) {
                                                                                                                                                                if (arg6 == 13) {
                                                                                                                                                                    if (arg7 == 33) {
                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                                                                                                            if (v38) {
                                                                                                                                                                true
                                                                                                                                                            } else {
                                                                                                                                                                let v39 = if (arg4 == 273) {
                                                                                                                                                                    if (arg6 == 15) {
                                                                                                                                                                        if (arg7 == 33) {
                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                                                                                                                                                if (v39) {
                                                                                                                                                                    true
                                                                                                                                                                } else {
                                                                                                                                                                    let v40 = if (arg4 == 278) {
                                                                                                                                                                        if (arg6 == 29) {
                                                                                                                                                                            if (arg7 == 33) {
                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                                                                                                                                    if (v40) {
                                                                                                                                                                        true
                                                                                                                                                                    } else {
                                                                                                                                                                        let v41 = if (arg4 == 280) {
                                                                                                                                                                            if (arg6 == 31) {
                                                                                                                                                                                if (arg7 == 33) {
                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                                                                                                                                        if (v41) {
                                                                                                                                                                            true
                                                                                                                                                                        } else {
                                                                                                                                                                            let v42 = if (arg4 == 282) {
                                                                                                                                                                                if (arg6 == 5) {
                                                                                                                                                                                    if (arg7 == 33) {
                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                                                                                                                                                                            if (v42) {
                                                                                                                                                                                true
                                                                                                                                                                            } else {
                                                                                                                                                                                let v43 = if (arg4 == 305) {
                                                                                                                                                                                    if (arg6 == 1) {
                                                                                                                                                                                        if (arg7 == 5) {
                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
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
                                                                                                                                                                                if (v43) {
                                                                                                                                                                                    true
                                                                                                                                                                                } else {
                                                                                                                                                                                    let v44 = if (arg4 == 306) {
                                                                                                                                                                                        if (arg6 == 10) {
                                                                                                                                                                                            if (arg7 == 5) {
                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
                                                                                                                                                                                    if (v44) {
                                                                                                                                                                                        true
                                                                                                                                                                                    } else {
                                                                                                                                                                                        let v45 = if (arg4 == 309) {
                                                                                                                                                                                            if (arg6 == 13) {
                                                                                                                                                                                                if (arg7 == 5) {
                                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
                                                                                                                                                                                        if (v45) {
                                                                                                                                                                                            true
                                                                                                                                                                                        } else {
                                                                                                                                                                                            let v46 = if (arg4 == 311) {
                                                                                                                                                                                                if (arg6 == 15) {
                                                                                                                                                                                                    if (arg7 == 5) {
                                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                                                                                                                                                                                            if (v46) {
                                                                                                                                                                                                true
                                                                                                                                                                                            } else {
                                                                                                                                                                                                let v47 = if (arg4 == 316) {
                                                                                                                                                                                                    if (arg6 == 29) {
                                                                                                                                                                                                        if (arg7 == 5) {
                                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                                                                                                                                                                                                if (v47) {
                                                                                                                                                                                                    true
                                                                                                                                                                                                } else {
                                                                                                                                                                                                    let v48 = if (arg4 == 318) {
                                                                                                                                                                                                        if (arg6 == 31) {
                                                                                                                                                                                                            if (arg7 == 5) {
                                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                                                                                                                                                                                                    if (v48) {
                                                                                                                                                                                                        true
                                                                                                                                                                                                    } else if (arg4 == 319) {
                                                                                                                                                                                                        if (arg6 == 33) {
                                                                                                                                                                                                            if (arg7 == 5) {
                                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                                                                                                                                                                                                }
                                                                                                                                                                                            }
                                                                                                                                                                                        }
                                                                                                                                                                                    }
                                                                                                                                                                                }
                                                                                                                                                                            }
                                                                                                                                                                        }
                                                                                                                                                                    }
                                                                                                                                                                }
                                                                                                                                                            }
                                                                                                                                                        }
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                }
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg8 > 0, 2);
        let (v49, v50, v51) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, false, arg8, 4295048017, arg10);
        let v52 = v51;
        let v53 = v50;
        0x2::balance::destroy_zero<T1>(v49);
        assert!(0x2::balance::value<T2>(&v53) == arg8, 2);
        let v54 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v52);
        let (v55, v56, v57) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, false, false, v54, 79226673515401279992447579054, arg10);
        let v58 = v57;
        let v59 = v55;
        0x2::balance::destroy_zero<T0>(v56);
        assert!(0x2::balance::value<T1>(&v59) == v54, 2);
        let v60 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v58);
        let (v61, v62) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T2, T0>(arg3, arg5, arg6, arg7, 0x2::coin::from_balance<T2>(v53, arg11), arg10, arg11);
        let v63 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v61, arg10, arg11));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v63), v60, arg9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v63, v60), v58);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, v59, 0x2::balance::zero<T2>(), v52);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v63, arg11), 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v62, 0x2::tx_context::sender(arg11));
    }

    public fun flash_cb_ca_bb<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg6 == 24) {
            if (arg8 == 14) {
                if (arg9 == 10) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg6 == 27) {
                if (arg8 == 18) {
                    if (arg9 == 10) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg6 == 28) {
                    if (arg8 == 2) {
                        if (arg9 == 10) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                } else {
                    false
                };
                if (v3) {
                    true
                } else {
                    let v4 = if (arg6 == 81) {
                        if (arg8 == 14) {
                            if (arg9 == 13) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                    } else {
                        false
                    };
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg6 == 84) {
                            if (arg8 == 18) {
                                if (arg9 == 13) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                        } else {
                            false
                        };
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg6 == 85) {
                                if (arg8 == 2) {
                                    if (arg9 == 13) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                            } else {
                                false
                            };
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg6 == 120) {
                                    if (arg8 == 14) {
                                        if (arg9 == 15) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                                } else {
                                    false
                                };
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg6 == 122) {
                                        if (arg8 == 18) {
                                            if (arg9 == 15) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                                    } else {
                                        false
                                    };
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg6 == 123) {
                                            if (arg8 == 2) {
                                                if (arg9 == 15) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                                        } else {
                                            false
                                        };
                                        if (v9) {
                                            true
                                        } else {
                                            let v10 = if (arg6 == 218) {
                                                if (arg8 == 18) {
                                                    if (arg9 == 29) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                                            } else {
                                                false
                                            };
                                            if (v10) {
                                                true
                                            } else {
                                                let v11 = if (arg6 == 219) {
                                                    if (arg8 == 2) {
                                                        if (arg9 == 29) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                                                } else {
                                                    false
                                                };
                                                if (v11) {
                                                    true
                                                } else {
                                                    let v12 = if (arg6 == 253) {
                                                        if (arg8 == 14) {
                                                            if (arg9 == 31) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                                                    } else {
                                                        false
                                                    };
                                                    if (v12) {
                                                        true
                                                    } else {
                                                        let v13 = if (arg6 == 256) {
                                                            if (arg8 == 18) {
                                                                if (arg9 == 31) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                                                        } else {
                                                            false
                                                        };
                                                        if (v13) {
                                                            true
                                                        } else {
                                                            let v14 = if (arg6 == 257) {
                                                                if (arg8 == 2) {
                                                                    if (arg9 == 31) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                                                            } else {
                                                                false
                                                            };
                                                            if (v14) {
                                                                true
                                                            } else {
                                                                let v15 = if (arg6 == 272) {
                                                                    if (arg8 == 14) {
                                                                        if (arg9 == 33) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                                                                } else {
                                                                    false
                                                                };
                                                                if (v15) {
                                                                    true
                                                                } else {
                                                                    let v16 = if (arg6 == 275) {
                                                                        if (arg8 == 18) {
                                                                            if (arg9 == 33) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                                                                    } else {
                                                                        false
                                                                    };
                                                                    if (v16) {
                                                                        true
                                                                    } else {
                                                                        let v17 = if (arg6 == 276) {
                                                                            if (arg8 == 2) {
                                                                                if (arg9 == 33) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                                                                        } else {
                                                                            false
                                                                        };
                                                                        if (v17) {
                                                                            true
                                                                        } else {
                                                                            let v18 = if (arg6 == 310) {
                                                                                if (arg8 == 14) {
                                                                                    if (arg9 == 5) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
                                                                            } else {
                                                                                false
                                                                            };
                                                                            if (v18) {
                                                                                true
                                                                            } else {
                                                                                let v19 = if (arg6 == 313) {
                                                                                    if (arg8 == 18) {
                                                                                        if (arg9 == 5) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0xe80e81a24dc18b5ce708bea23dc151385df291767db4b1cccb4517105f35aa17
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
                                                                                } else {
                                                                                    false
                                                                                };
                                                                                if (v19) {
                                                                                    true
                                                                                } else if (arg6 == 314) {
                                                                                    if (arg8 == 2) {
                                                                                        if (arg9 == 5) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                    0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>>(arg4) == @0x4746414e445cebdc19666b6e4de9b79a46ca7bcaa894bf10ec230e649376356e
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
                                                                                } else {
                                                                                    false
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg10 > 0, 2);
        let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T2>(arg12, arg1, arg4, false, false, arg10, 79226673515401279992447579054);
        let v23 = v22;
        let v24 = v20;
        0x2::balance::destroy_zero<T2>(v21);
        assert!(0x2::balance::value<T3>(&v24) == arg10, 2);
        let v25 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T3, T2>(&v23);
        let (v26, v27, v28) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, false, v25, 4295048017, arg12);
        let v29 = v28;
        let v30 = v27;
        0x2::balance::destroy_zero<T1>(v26);
        assert!(0x2::balance::value<T2>(&v30) == v25, 2);
        let v31 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v29);
        let (v32, v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, false, false, v31, 79226673515401279992447579054, arg12);
        let v35 = v34;
        let v36 = v32;
        0x2::balance::destroy_zero<T0>(v33);
        assert!(0x2::balance::value<T1>(&v36) == v31, 2);
        let v37 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v35);
        let (v38, v39) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T3, T0>(arg5, arg7, arg8, arg9, 0x2::coin::from_balance<T3>(v24, arg13), arg12, arg13);
        let v40 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg5, v38, arg12, arg13));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v40), v37, arg11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v40, v37), v35);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, v36, 0x2::balance::zero<T2>(), v29);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T2>(arg1, arg4, 0x2::balance::zero<T3>(), v30, v23);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v40, arg13), 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v39, 0x2::tx_context::sender(arg13));
    }

    public fun flash_cb_ca_bb_sui<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: u64, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7 == 5) {
            if (arg9 == 14) {
                if (arg10 == 1) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg4) == @0xd1ec0340ddc83a40796fedef6c3ca131f51297effd74d95f35633d7123617e91
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
        } else {
            false
        };
        assert!(v0, 0);
        assert!(arg11 > 0, 2);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg13, arg1, arg4, false, false, arg11, 79226673515401279992447579054);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x2::balance::value<T2>(&v5) == arg11, 2);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v4);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg3, true, false, v6, 4295048017, arg13);
        let v10 = v9;
        let v11 = v8;
        0x2::balance::destroy_zero<T0>(v7);
        assert!(0x2::balance::value<T1>(&v11) == v6, 2);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg2, false, false, v12, 79226673515401279992447579054, arg13);
        let v16 = v15;
        let v17 = v13;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
        assert!(0x2::balance::value<T0>(&v17) == v12, 2);
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v16);
        let (v19, v20) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T2, 0x2::sui::SUI>(arg5, arg8, arg9, arg10, 0x2::coin::from_balance<T2>(v5, arg14), arg13, arg14);
        let v21 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg5, v19, arg6, arg13, arg14));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<0x2::sui::SUI>(&v21), v18, arg12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v21, v18), v16);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg3, v17, 0x2::balance::zero<T1>(), v10);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg4, 0x2::balance::zero<T2>(), v11, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v21, arg14), 0x2::tx_context::sender(arg14));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v20, 0x2::tx_context::sender(arg14));
    }

    public fun flash_cb_ca_cb<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: u64, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5 == 21) {
            if (arg7 == 11) {
                if (arg8 == 10) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg5 == 22) {
                if (arg7 == 12) {
                    if (arg8 == 10) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg5 == 29) {
                    if (arg7 == 28) {
                        if (arg8 == 10) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                } else {
                    false
                };
                if (v3) {
                    true
                } else {
                    let v4 = if (arg5 == 31) {
                        if (arg7 == 3) {
                            if (arg8 == 10) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                    } else {
                        false
                    };
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg5 == 34) {
                            if (arg7 == 4) {
                                if (arg8 == 10) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                        } else {
                            false
                        };
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg5 == 37) {
                                if (arg7 == 7) {
                                    if (arg8 == 10) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                            } else {
                                false
                            };
                            if (v6) {
                                true
                            } else {
                                let v7 = if (arg5 == 38) {
                                    if (arg7 == 9) {
                                        if (arg8 == 10) {
                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                } else {
                                    false
                                };
                                if (v7) {
                                    true
                                } else {
                                    let v8 = if (arg5 == 79) {
                                        if (arg7 == 11) {
                                            if (arg8 == 13) {
                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                    } else {
                                        false
                                    };
                                    if (v8) {
                                        true
                                    } else {
                                        let v9 = if (arg5 == 80) {
                                            if (arg7 == 12) {
                                                if (arg8 == 13) {
                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                        } else {
                                            false
                                        };
                                        if (v9) {
                                            true
                                        } else {
                                            let v10 = if (arg5 == 86) {
                                                if (arg7 == 28) {
                                                    if (arg8 == 13) {
                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                            } else {
                                                false
                                            };
                                            if (v10) {
                                                true
                                            } else {
                                                let v11 = if (arg5 == 88) {
                                                    if (arg7 == 3) {
                                                        if (arg8 == 13) {
                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                                } else {
                                                    false
                                                };
                                                if (v11) {
                                                    true
                                                } else {
                                                    let v12 = if (arg5 == 91) {
                                                        if (arg7 == 4) {
                                                            if (arg8 == 13) {
                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                    } else {
                                                        false
                                                    };
                                                    if (v12) {
                                                        true
                                                    } else {
                                                        let v13 = if (arg5 == 94) {
                                                            if (arg7 == 7) {
                                                                if (arg8 == 13) {
                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                        } else {
                                                            false
                                                        };
                                                        if (v13) {
                                                            true
                                                        } else {
                                                            let v14 = if (arg5 == 95) {
                                                                if (arg7 == 9) {
                                                                    if (arg8 == 13) {
                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                                            } else {
                                                                false
                                                            };
                                                            if (v14) {
                                                                true
                                                            } else {
                                                                let v15 = if (arg5 == 117) {
                                                                    if (arg7 == 11) {
                                                                        if (arg8 == 15) {
                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                                } else {
                                                                    false
                                                                };
                                                                if (v15) {
                                                                    true
                                                                } else {
                                                                    let v16 = if (arg5 == 118) {
                                                                        if (arg7 == 12) {
                                                                            if (arg8 == 15) {
                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                                    } else {
                                                                        false
                                                                    };
                                                                    if (v16) {
                                                                        true
                                                                    } else {
                                                                        let v17 = if (arg5 == 124) {
                                                                            if (arg7 == 28) {
                                                                                if (arg8 == 15) {
                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                                        } else {
                                                                            false
                                                                        };
                                                                        if (v17) {
                                                                            true
                                                                        } else {
                                                                            let v18 = if (arg5 == 126) {
                                                                                if (arg7 == 3) {
                                                                                    if (arg8 == 15) {
                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                                                            } else {
                                                                                false
                                                                            };
                                                                            if (v18) {
                                                                                true
                                                                            } else {
                                                                                let v19 = if (arg5 == 129) {
                                                                                    if (arg7 == 4) {
                                                                                        if (arg8 == 15) {
                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                                                } else {
                                                                                    false
                                                                                };
                                                                                if (v19) {
                                                                                    true
                                                                                } else {
                                                                                    let v20 = if (arg5 == 132) {
                                                                                        if (arg7 == 7) {
                                                                                            if (arg8 == 15) {
                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                                                    } else {
                                                                                        false
                                                                                    };
                                                                                    if (v20) {
                                                                                        true
                                                                                    } else {
                                                                                        let v21 = if (arg5 == 133) {
                                                                                            if (arg7 == 9) {
                                                                                                if (arg8 == 15) {
                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877) {
                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                                                                        } else {
                                                                                            false
                                                                                        };
                                                                                        if (v21) {
                                                                                            true
                                                                                        } else {
                                                                                            let v22 = if (arg5 == 212) {
                                                                                                if (arg7 == 11) {
                                                                                                    if (arg8 == 29) {
                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                                                            } else {
                                                                                                false
                                                                                            };
                                                                                            if (v22) {
                                                                                                true
                                                                                            } else {
                                                                                                let v23 = if (arg5 == 213) {
                                                                                                    if (arg7 == 12) {
                                                                                                        if (arg8 == 29) {
                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                                                                } else {
                                                                                                    false
                                                                                                };
                                                                                                if (v23) {
                                                                                                    true
                                                                                                } else {
                                                                                                    let v24 = if (arg5 == 220) {
                                                                                                        if (arg7 == 28) {
                                                                                                            if (arg8 == 29) {
                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                                                                    } else {
                                                                                                        false
                                                                                                    };
                                                                                                    if (v24) {
                                                                                                        true
                                                                                                    } else {
                                                                                                        let v25 = if (arg5 == 224) {
                                                                                                            if (arg7 == 4) {
                                                                                                                if (arg8 == 29) {
                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                                                                        } else {
                                                                                                            false
                                                                                                        };
                                                                                                        if (v25) {
                                                                                                            true
                                                                                                        } else {
                                                                                                            let v26 = if (arg5 == 227) {
                                                                                                                if (arg7 == 7) {
                                                                                                                    if (arg8 == 29) {
                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                                                                            } else {
                                                                                                                false
                                                                                                            };
                                                                                                            if (v26) {
                                                                                                                true
                                                                                                            } else {
                                                                                                                let v27 = if (arg5 == 228) {
                                                                                                                    if (arg7 == 9) {
                                                                                                                        if (arg8 == 29) {
                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                                                                                                } else {
                                                                                                                    false
                                                                                                                };
                                                                                                                if (v27) {
                                                                                                                    true
                                                                                                                } else {
                                                                                                                    let v28 = if (arg5 == 250) {
                                                                                                                        if (arg7 == 11) {
                                                                                                                            if (arg8 == 31) {
                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                                                                                    } else {
                                                                                                                        false
                                                                                                                    };
                                                                                                                    if (v28) {
                                                                                                                        true
                                                                                                                    } else {
                                                                                                                        let v29 = if (arg5 == 251) {
                                                                                                                            if (arg7 == 12) {
                                                                                                                                if (arg8 == 31) {
                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                                                                                        } else {
                                                                                                                            false
                                                                                                                        };
                                                                                                                        if (v29) {
                                                                                                                            true
                                                                                                                        } else {
                                                                                                                            let v30 = if (arg5 == 258) {
                                                                                                                                if (arg7 == 28) {
                                                                                                                                    if (arg8 == 31) {
                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                                                                                            } else {
                                                                                                                                false
                                                                                                                            };
                                                                                                                            if (v30) {
                                                                                                                                true
                                                                                                                            } else {
                                                                                                                                let v31 = if (arg5 == 260) {
                                                                                                                                    if (arg7 == 3) {
                                                                                                                                        if (arg8 == 31) {
                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                                                                                                                } else {
                                                                                                                                    false
                                                                                                                                };
                                                                                                                                if (v31) {
                                                                                                                                    true
                                                                                                                                } else {
                                                                                                                                    let v32 = if (arg5 == 262) {
                                                                                                                                        if (arg7 == 4) {
                                                                                                                                            if (arg8 == 31) {
                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                                                                                                    } else {
                                                                                                                                        false
                                                                                                                                    };
                                                                                                                                    if (v32) {
                                                                                                                                        true
                                                                                                                                    } else {
                                                                                                                                        let v33 = if (arg5 == 265) {
                                                                                                                                            if (arg7 == 7) {
                                                                                                                                                if (arg8 == 31) {
                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                                                                                                        } else {
                                                                                                                                            false
                                                                                                                                        };
                                                                                                                                        if (v33) {
                                                                                                                                            true
                                                                                                                                        } else {
                                                                                                                                            let v34 = if (arg5 == 266) {
                                                                                                                                                if (arg7 == 9) {
                                                                                                                                                    if (arg8 == 31) {
                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf) {
                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                                                                                                                            } else {
                                                                                                                                                false
                                                                                                                                            };
                                                                                                                                            if (v34) {
                                                                                                                                                true
                                                                                                                                            } else {
                                                                                                                                                let v35 = if (arg5 == 269) {
                                                                                                                                                    if (arg7 == 11) {
                                                                                                                                                        if (arg8 == 33) {
                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                                                                                                                } else {
                                                                                                                                                    false
                                                                                                                                                };
                                                                                                                                                if (v35) {
                                                                                                                                                    true
                                                                                                                                                } else {
                                                                                                                                                    let v36 = if (arg5 == 270) {
                                                                                                                                                        if (arg7 == 12) {
                                                                                                                                                            if (arg8 == 33) {
                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                                                                                                                    } else {
                                                                                                                                                        false
                                                                                                                                                    };
                                                                                                                                                    if (v36) {
                                                                                                                                                        true
                                                                                                                                                    } else {
                                                                                                                                                        let v37 = if (arg5 == 277) {
                                                                                                                                                            if (arg7 == 28) {
                                                                                                                                                                if (arg8 == 33) {
                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                                                                                                                        } else {
                                                                                                                                                            false
                                                                                                                                                        };
                                                                                                                                                        if (v37) {
                                                                                                                                                            true
                                                                                                                                                        } else {
                                                                                                                                                            let v38 = if (arg5 == 279) {
                                                                                                                                                                if (arg7 == 3) {
                                                                                                                                                                    if (arg8 == 33) {
                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                                                                                                                                            } else {
                                                                                                                                                                false
                                                                                                                                                            };
                                                                                                                                                            if (v38) {
                                                                                                                                                                true
                                                                                                                                                            } else {
                                                                                                                                                                let v39 = if (arg5 == 281) {
                                                                                                                                                                    if (arg7 == 4) {
                                                                                                                                                                        if (arg8 == 33) {
                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                                                                                                                                } else {
                                                                                                                                                                    false
                                                                                                                                                                };
                                                                                                                                                                if (v39) {
                                                                                                                                                                    true
                                                                                                                                                                } else {
                                                                                                                                                                    let v40 = if (arg5 == 284) {
                                                                                                                                                                        if (arg7 == 7) {
                                                                                                                                                                            if (arg8 == 33) {
                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                                                                                                                                    } else {
                                                                                                                                                                        false
                                                                                                                                                                    };
                                                                                                                                                                    if (v40) {
                                                                                                                                                                        true
                                                                                                                                                                    } else {
                                                                                                                                                                        let v41 = if (arg5 == 285) {
                                                                                                                                                                            if (arg7 == 9) {
                                                                                                                                                                                if (arg8 == 33) {
                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56) {
                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                                                                                                                                                        } else {
                                                                                                                                                                            false
                                                                                                                                                                        };
                                                                                                                                                                        if (v41) {
                                                                                                                                                                            true
                                                                                                                                                                        } else {
                                                                                                                                                                            let v42 = if (arg5 == 307) {
                                                                                                                                                                                if (arg7 == 11) {
                                                                                                                                                                                    if (arg8 == 5) {
                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
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
                                                                                                                                                                            } else {
                                                                                                                                                                                false
                                                                                                                                                                            };
                                                                                                                                                                            if (v42) {
                                                                                                                                                                                true
                                                                                                                                                                            } else {
                                                                                                                                                                                let v43 = if (arg5 == 308) {
                                                                                                                                                                                    if (arg7 == 12) {
                                                                                                                                                                                        if (arg8 == 5) {
                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
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
                                                                                                                                                                                } else {
                                                                                                                                                                                    false
                                                                                                                                                                                };
                                                                                                                                                                                if (v43) {
                                                                                                                                                                                    true
                                                                                                                                                                                } else {
                                                                                                                                                                                    let v44 = if (arg5 == 315) {
                                                                                                                                                                                        if (arg7 == 28) {
                                                                                                                                                                                            if (arg8 == 5) {
                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
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
                                                                                                                                                                                    } else {
                                                                                                                                                                                        false
                                                                                                                                                                                    };
                                                                                                                                                                                    if (v44) {
                                                                                                                                                                                        true
                                                                                                                                                                                    } else {
                                                                                                                                                                                        let v45 = if (arg5 == 317) {
                                                                                                                                                                                            if (arg7 == 3) {
                                                                                                                                                                                                if (arg8 == 5) {
                                                                                                                                                                                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                                                                                                                                                                                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
                                                                                                                                                                                        } else {
                                                                                                                                                                                            false
                                                                                                                                                                                        };
                                                                                                                                                                                        if (v45) {
                                                                                                                                                                                            true
                                                                                                                                                                                        } else {
                                                                                                                                                                                            let v46 = if (arg5 == 320) {
                                                                                                                                                                                                if (arg7 == 4) {
                                                                                                                                                                                                    if (arg8 == 5) {
                                                                                                                                                                                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
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
                                                                                                                                                                                            } else {
                                                                                                                                                                                                false
                                                                                                                                                                                            };
                                                                                                                                                                                            if (v46) {
                                                                                                                                                                                                true
                                                                                                                                                                                            } else {
                                                                                                                                                                                                let v47 = if (arg5 == 322) {
                                                                                                                                                                                                    if (arg7 == 7) {
                                                                                                                                                                                                        if (arg8 == 5) {
                                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                                                                                                                                                                                                } else {
                                                                                                                                                                                                    false
                                                                                                                                                                                                };
                                                                                                                                                                                                if (v47) {
                                                                                                                                                                                                    true
                                                                                                                                                                                                } else if (arg5 == 323) {
                                                                                                                                                                                                    if (arg7 == 9) {
                                                                                                                                                                                                        if (arg8 == 5) {
                                                                                                                                                                                                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073) {
                                                                                                                                                                                                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                                                                                                                                                                                                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
                                                                                                                                                                                                } else {
                                                                                                                                                                                                    false
                                                                                                                                                                                                }
                                                                                                                                                                                            }
                                                                                                                                                                                        }
                                                                                                                                                                                    }
                                                                                                                                                                                }
                                                                                                                                                                            }
                                                                                                                                                                        }
                                                                                                                                                                    }
                                                                                                                                                                }
                                                                                                                                                            }
                                                                                                                                                        }
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                }
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg9 > 0, 2);
        let (v48, v49, v50) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T2>(arg0, arg3, false, false, arg9, 79226673515401279992447579054, arg11);
        let v51 = v50;
        let v52 = v48;
        0x2::balance::destroy_zero<T2>(v49);
        assert!(0x2::balance::value<T3>(&v52) == arg9, 2);
        let v53 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T3, T2>(&v51);
        let (v54, v55, v56) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, false, v53, 4295048017, arg11);
        let v57 = v56;
        let v58 = v55;
        0x2::balance::destroy_zero<T1>(v54);
        assert!(0x2::balance::value<T2>(&v58) == v53, 2);
        let v59 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v57);
        let (v60, v61, v62) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, false, false, v59, 79226673515401279992447579054, arg11);
        let v63 = v62;
        let v64 = v60;
        0x2::balance::destroy_zero<T0>(v61);
        assert!(0x2::balance::value<T1>(&v64) == v59, 2);
        let v65 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v63);
        let (v66, v67) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T3, T0>(arg4, arg6, arg7, arg8, 0x2::coin::from_balance<T3>(v52, arg12), arg11, arg12);
        let v68 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg4, v66, arg11, arg12));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<T0>(&v68), v65, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v68, v65), v63);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, v64, 0x2::balance::zero<T2>(), v57);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T2>(arg0, arg3, 0x2::balance::zero<T3>(), v58, v51);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v68, arg12), 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v67, 0x2::tx_context::sender(arg12));
    }

    public fun flash_cb_ca_cb_sui<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg6 == 12) {
            if (arg8 == 3) {
                if (arg9 == 1) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0xdcd50e175016b2bfee71c1bfbe4bb80855088501e34d8b5e99fb9f58ce745dad
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
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else if (arg6 == 19) {
            if (arg8 == 9) {
                if (arg9 == 1) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0x3b13ac70030d587624e407bbe791160b459c48f1049e04269eb8ee731f5442b4) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3) == @0x899df39337a3e2beac292c13c1db008bc71e1cf48fa3da00975b7420da2246ea
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
        } else {
            false
        };
        assert!(v1, 0);
        assert!(arg10 > 0, 2);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, arg10, 79226673515401279992447579054, arg12);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        assert!(0x2::balance::value<T2>(&v6) == arg10, 2);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v5);
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, false, v7, 4295048017, arg12);
        let v11 = v10;
        let v12 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        assert!(0x2::balance::value<T1>(&v12) == v7, 2);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v11);
        let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, v13, 79226673515401279992447579054, arg12);
        let v17 = v16;
        let v18 = v14;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v15);
        assert!(0x2::balance::value<T0>(&v18) == v13, 2);
        let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v17);
        let (v20, v21) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T2, 0x2::sui::SUI>(arg4, arg7, arg8, arg9, 0x2::coin::from_balance<T2>(v6, arg13), arg12, arg13);
        let v22 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg4, v20, arg5, arg12, arg13));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<0x2::sui::SUI>(&v22), v19, arg11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v22, v19), v17);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v18, 0x2::balance::zero<T1>(), v11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v12, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v22, arg13), 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v21, 0x2::tx_context::sender(arg13));
    }

    public fun flash_cb_ca_sui<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5 == 1) {
            if (arg7 == 10) {
                if (arg8 == 1) {
                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0x9e59de50d9e5979fc03ac5bcacdb581c823dbd27d63a036131e17b391f2fac88
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
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg5 == 4) {
                if (arg7 == 13) {
                    if (arg8 == 1) {
                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xa288810f820498f7c2bca41cfadea3e99bd152b3dbeb2c282bb4b9c909f71c6d
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
            if (v2) {
                true
            } else {
                let v3 = if (arg5 == 6) {
                    if (arg7 == 15) {
                        if (arg8 == 1) {
                            if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xa59826d4bf5064ff955f9b14c2b46707477aa1c4a0d7daa2d5a40c25cd22a877
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
                if (v3) {
                    true
                } else {
                    let v4 = if (arg5 == 11) {
                        if (arg7 == 29) {
                            if (arg8 == 1) {
                                if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xe92ee9996c49057cf2449c8c9f8d7fe52040db8229f6eb01be7d7f6bbc4fc2f3
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
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg5 == 13) {
                            if (arg7 == 31) {
                                if (arg8 == 1) {
                                    if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0x93372a4880cb4cbd4a9974a822c097aa36279a1dbeed7ebd7249d07b923238cf
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
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg5 == 14) {
                                if (arg7 == 33) {
                                    if (arg8 == 1) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xa7417fb5f59e23b0a7826d78f025653823c49265be07bbf6dd9e553ba4249a56
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
                            if (v6) {
                                true
                            } else if (arg5 == 16) {
                                if (arg7 == 5) {
                                    if (arg8 == 1) {
                                        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105) {
                                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == @0xb8a67c149fd1bc7f9aca1541c61e51ba13bdded64c273c278e50850ae3bff073
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
                        }
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg9 > 0, 2);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, false, arg9, 4295048017, arg11);
        let v10 = v9;
        let v11 = v8;
        0x2::balance::destroy_zero<T0>(v7);
        assert!(0x2::balance::value<T1>(&v11) == arg9, 2);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, v12, 79226673515401279992447579054, arg11);
        let v16 = v15;
        let v17 = v13;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
        assert!(0x2::balance::value<T0>(&v17) == v12, 2);
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v16);
        let (v19, v20) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T1, 0x2::sui::SUI>(arg3, arg6, arg7, arg8, 0x2::coin::from_balance<T1>(v11, arg12), arg11, arg12);
        let v21 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg3, v19, arg4, arg11, arg12));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<0x2::sui::SUI>(&v21), v18, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v21, v18), v16);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v17, 0x2::balance::zero<T1>(), v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v21, arg12), 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v20, 0x2::tx_context::sender(arg12));
    }

    public fun flash_cb_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 2) {
            if (arg6 == 11) {
                if (arg7 == 1) {
                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xd978d331772a5b90d5a4781e1232d18afd12019d0c35db79e3674beeda8f9126
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg4 == 3) {
                if (arg6 == 12) {
                    if (arg7 == 1) {
                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xda7347c3192a27ddac32e659c9d9cbed6f8c9d1344e605c71c8886d7b787d720
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg4 == 7) {
                    if (arg6 == 16) {
                        if (arg7 == 1) {
                            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xd53f3dadccb67de4d1318534867acce0f3731cbcecb26277531277b7c5e8a8a5
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    true
                } else {
                    let v4 = if (arg4 == 10) {
                        if (arg6 == 28) {
                            if (arg7 == 1) {
                                0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xf45b01f23e9951e37733b76c8cc7d22dcd23141aa246a86e17595a7aca610e1d
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v4) {
                        true
                    } else {
                        let v5 = if (arg4 == 15) {
                            if (arg6 == 4) {
                                if (arg7 == 1) {
                                    0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0x2fc6ee9183d0f1ca0d2dded02c416be6f4671bb82db55c26ce12b536812a4b8e
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v5) {
                            true
                        } else {
                            let v6 = if (arg4 == 17) {
                                if (arg6 == 6) {
                                    if (arg7 == 1) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            if (v6) {
                                true
                            } else if (arg4 == 18) {
                                if (arg6 == 7) {
                                    if (arg7 == 1) {
                                        0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == @0xf4238fa592c9ed7f148fd091cb2c4147cb15ad81b797115ce42971923ebf6e4c
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
                    }
                }
            }
        };
        assert!(v1, 0);
        assert!(arg8 > 0, 2);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg8, 79226673515401279992447579054, arg10);
        let v10 = v9;
        let v11 = v7;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        assert!(0x2::balance::value<T0>(&v11) == arg8, 2);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v10);
        let (v13, v14) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg2, arg5, arg6, arg7, 0x2::coin::from_balance<T0>(v11, arg11), arg10, arg11);
        let v15 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, v13, arg3, arg10, arg11));
        0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math::profit(0x2::balance::value<0x2::sui::SUI>(&v15), v12, arg9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v15, v12), v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v15, arg11), 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, 0x2::tx_context::sender(arg11));
    }

    // decompiled from Move bytecode v7
}

