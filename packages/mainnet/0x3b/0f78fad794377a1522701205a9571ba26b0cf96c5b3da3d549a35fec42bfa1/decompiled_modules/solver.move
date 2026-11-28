module 0x3023610934fdf6a1a259ea5b7159594fe8b0e469896f0bd288616fc39be324ea::solver {
    struct Grid has drop {
        inputs: vector<u64>,
        amounts: vector<u64>,
        alive: vector<bool>,
    }

    public fun best_candidate(arg0: &Grid) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg0.inputs)) {
            if (*0x1::vector::borrow<bool>(&arg0.alive, v3)) {
                let v4 = *0x1::vector::borrow<u64>(&arg0.inputs, v3);
                let v5 = *0x1::vector::borrow<u64>(&arg0.amounts, v3);
                if (v5 > v4) {
                    let v6 = v5 - v4;
                    if (v6 > v1) {
                        v2 = v6;
                        v0 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        (v0, v2)
    }

    public fun grid_outputs(arg0: &Grid) : (vector<u64>, vector<u64>) {
        (arg0.inputs, arg0.amounts)
    }

    public fun new_adaptive_grid(arg0: u64, arg1: vector<u64>) : Grid {
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 > 0, 408);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = (arg0 as u128) * (*0x1::vector::borrow<u64>(&arg1, v4) as u128) / 10000;
            let v6 = if (v5 > 18446744073709551615) {
                (18446744073709551615 as u64)
            } else {
                (v5 as u64)
            };
            0x1::vector::push_back<u64>(&mut v1, v6);
            0x1::vector::push_back<u64>(&mut v2, v6);
            0x1::vector::push_back<bool>(&mut v3, v6 > 0);
            v4 = v4 + 1;
        };
        Grid{
            inputs  : v1,
            amounts : v2,
            alive   : v3,
        }
    }

    public fun new_grid(arg0: vector<u64>) : Grid {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 > 0, 408);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<bool>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg0, v3);
            0x1::vector::push_back<u64>(&mut v1, v4);
            0x1::vector::push_back<bool>(&mut v2, v4 > 0);
            v3 = v3 + 1;
        };
        Grid{
            inputs  : arg0,
            amounts : v1,
            alive   : v2,
        }
    }

    public fun pick_best_of_two(arg0: &Grid, arg1: &Grid, arg2: u64) : (u64, u64) {
        let (v0, v1) = best_candidate(arg0);
        let (v2, v3) = best_candidate(arg1);
        if (v1 >= v3) {
            let v6 = if (v0 > 0) {
                if (v1 > 0) {
                    v1 >= arg2
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v6, 409);
            (v0, 0)
        } else {
            let v7 = if (v2 > 0) {
                if (v3 > 0) {
                    v3 >= arg2
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v7, 409);
            (0, v2)
        }
    }

    public fun pick_optimal(arg0: &Grid, arg1: u64) : u64 {
        let (v0, v1) = best_candidate(arg0);
        let v2 = if (v0 > 0) {
            if (v1 > 0) {
                v1 >= arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 409);
        v0
    }

    public fun quote_b5_clmm<T0, T1>(arg0: &mut Grid, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool, arg3: u128) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.amounts)) {
            let v1 = 0x1::vector::borrow_mut<bool>(&mut arg0.alive, v0);
            if (*v1) {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v0);
                if (*v2 == 0) {
                    *v1 = false;
                } else {
                    let v3 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::compute_swap_result<T0, T1>(arg1, arg2, true, arg3, *v2);
                    let v4 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_calculated(&v3);
                    *v2 = v4;
                    if (v4 == 0) {
                        *v1 = false;
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun quote_bluefin<T0, T1>(arg0: &mut Grid, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool, arg3: u128) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.amounts)) {
            let v1 = 0x1::vector::borrow_mut<bool>(&mut arg0.alive, v0);
            if (*v1) {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v0);
                if (*v2 == 0) {
                    *v1 = false;
                } else {
                    let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, arg2, true, *v2, arg3);
                    if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v3)) {
                        *v2 = 0;
                        *v1 = false;
                    } else {
                        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v3);
                        *v2 = v4;
                        if (v4 == 0) {
                            *v1 = false;
                        };
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun quote_cetus<T0, T1>(arg0: &mut Grid, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.amounts)) {
            let v1 = 0x1::vector::borrow_mut<bool>(&mut arg0.alive, v0);
            if (*v1) {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v0);
                if (*v2 == 0) {
                    *v1 = false;
                } else {
                    let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, *v2);
                    if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v3)) {
                        *v2 = 0;
                        *v1 = false;
                    } else {
                        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v3);
                        *v2 = v4;
                        if (v4 == 0) {
                            *v1 = false;
                        };
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun quote_constant_product(arg0: &mut Grid, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = (arg1 as u128);
        let v1 = (arg2 as u128);
        let v2 = if ((arg3 as u128) >= 10000) {
            0
        } else {
            10000 - (arg3 as u128)
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg0.amounts)) {
            let v4 = 0x1::vector::borrow_mut<bool>(&mut arg0.alive, v3);
            if (*v4) {
                let v5 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v3);
                let v6 = if (*v5 == 0) {
                    true
                } else if (v0 == 0) {
                    true
                } else if (v1 == 0) {
                    true
                } else {
                    v2 == 0
                };
                if (v6) {
                    *v5 = 0;
                    *v4 = false;
                } else {
                    let v7 = (*v5 as u128) * v2;
                    let v8 = v7 * v1 / (v0 * 10000 + v7);
                    let v9 = if (v8 > 18446744073709551615) {
                        (18446744073709551615 as u64)
                    } else {
                        (v8 as u64)
                    };
                    *v5 = v9;
                    if (v9 == 0) {
                        *v4 = false;
                    };
                };
            };
            v3 = v3 + 1;
        };
    }

    public fun quote_deepbook<T0, T1>(arg0: &mut Grid, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.amounts)) {
            let v1 = 0x1::vector::borrow_mut<bool>(&mut arg0.alive, v0);
            if (*v1) {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v0);
                let v3 = *v2;
                let v4 = v3;
                if (arg3 > 0 && (arg3 as u128) < 10000) {
                    v4 = (((v3 as u128) * (10000 - (arg3 as u128)) / 10000) as u64);
                };
                if (v4 == 0) {
                    *v2 = 0;
                    *v1 = false;
                } else if (arg2) {
                    let (_, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, v4, arg4);
                    if (v6 == 0) {
                        *v2 = 0;
                        *v1 = false;
                    } else {
                        *v2 = v6;
                    };
                } else {
                    let (v8, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, v4, arg4);
                    if (v8 == 0) {
                        *v2 = 0;
                        *v1 = false;
                    } else {
                        *v2 = v8;
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun quote_ferra_clmm<T0, T1>(arg0: &mut Grid, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.amounts)) {
            let v1 = 0x1::vector::borrow_mut<bool>(&mut arg0.alive, v0);
            if (*v1) {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v0);
                if (*v2 == 0) {
                    *v1 = false;
                } else {
                    let v3 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, *v2);
                    if (0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_is_exceed(&v3)) {
                        *v2 = 0;
                        *v1 = false;
                    } else {
                        let v4 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_amount_out(&v3);
                        *v2 = v4;
                        if (v4 == 0) {
                            *v1 = false;
                        };
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun quote_magma<T0, T1>(arg0: &mut Grid, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.amounts)) {
            let v1 = 0x1::vector::borrow_mut<bool>(&mut arg0.alive, v0);
            if (*v1) {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v0);
                if (*v2 == 0) {
                    *v1 = false;
                } else {
                    let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg1, arg2, arg3, true, *v2);
                    if (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_is_exceed(&v3)) {
                        *v2 = 0;
                        *v1 = false;
                    } else {
                        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v3);
                        *v2 = v4;
                        if (v4 == 0) {
                            *v1 = false;
                        };
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun quote_mmt<T0, T1>(arg0: &mut Grid, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: u128) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.amounts)) {
            let v1 = 0x1::vector::borrow_mut<bool>(&mut arg0.alive, v0);
            if (*v1) {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v0);
                if (*v2 == 0) {
                    *v1 = false;
                } else {
                    let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, arg2, true, arg3, *v2);
                    let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v3);
                    *v2 = v4;
                    if (v4 == 0) {
                        *v1 = false;
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

