module 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::render {
    fun blend(arg0: &mut vector<u8>, arg1: u64, arg2: &vector<u8>, arg3: u64, arg4: u64) {
        let v0 = 0;
        while (v0 < 3) {
            *0x1::vector::borrow_mut<u8>(arg0, arg1 + v0) = (((*0x1::vector::borrow<u8>(arg0, arg1 + v0) as u64) * (256 - arg4) + (*0x1::vector::borrow<u8>(arg2, arg3 + v0) as u64) * arg4 + 128 >> 8) as u8);
            v0 = v0 + 1;
        };
    }

    fun colour(arg0: u64, arg1: u64) : u64 {
        (arg0 * 12 + arg1) * 3
    }

    fun copy3(arg0: &mut vector<u8>, arg1: u64, arg2: &vector<u8>, arg3: u64) {
        *0x1::vector::borrow_mut<u8>(arg0, arg1) = *0x1::vector::borrow<u8>(arg2, arg3);
        *0x1::vector::borrow_mut<u8>(arg0, arg1 + 1) = *0x1::vector::borrow<u8>(arg2, arg3 + 1);
        *0x1::vector::borrow_mut<u8>(arg0, arg1 + 2) = *0x1::vector::borrow<u8>(arg2, arg3 + 2);
    }

    fun filled(arg0: u64, arg1: u8) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, arg1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun hashbit_svg(arg0: &0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit) : 0x1::string::String {
        svg(0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::traits(arg0))
    }

    public fun pixels(arg0: u64) : vector<u8> {
        let v0 = arg0 & 15;
        let v1 = arg0 >> 4 & 15;
        let v2 = arg0 >> 8 & 15;
        let v3 = arg0 >> 12 & 15;
        let v4 = arg0 >> 16 & 15;
        let v5 = arg0 >> 20 & 15;
        let v6 = arg0 >> 24 & 15;
        let v7 = arg0 >> 28 & 15;
        let v8 = if (v0 < 6) {
            if (v1 < 7) {
                if (v2 < 7) {
                    if (v3 < 7) {
                        if (v4 < 10) {
                            if (v5 < 10) {
                                if (v6 < 6) {
                                    if (v7 < 5) {
                                        arg0 >> 32 == 0
                                    } else {
                                        false
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
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 13906834689739849735);
        let v9 = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::art::parts();
        let v10 = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::art::part_off();
        let v11 = filled(32 * 32, 255);
        let v12 = filled(32 * 32, 0);
        let v13 = filled(32 * 32, 0);
        let v14 = filled(32 * 32, 0);
        let v15 = 0x1::vector::empty<u64>();
        let v16 = &mut v15;
        0x1::vector::push_back<u64>(v16, v0);
        0x1::vector::push_back<u64>(v16, 6 + v1);
        0x1::vector::push_back<u64>(v16, 13 + 7 * v1 + v2);
        0x1::vector::push_back<u64>(v16, 62 + 7 * v1 + v3);
        let v17 = 0;
        let v18 = 0;
        while (v18 < 4) {
            let v19 = read2(&v10, *0x1::vector::borrow<u64>(&v15, v18) * 2);
            let v20 = v19 + 1;
            let v21 = 0;
            while (v21 < (*0x1::vector::borrow<u8>(&v9, v19) as u64)) {
                let v22 = read2(&v9, v20);
                let v23 = v20 + 2;
                let v24 = 0;
                while (v24 < v22) {
                    let v25 = v23 + v24 * 3;
                    let v26 = (*0x1::vector::borrow<u8>(&v9, v25 + 1) as u64) * 32 + ((*0x1::vector::borrow<u8>(&v9, v25) & 31) as u64);
                    *0x1::vector::borrow_mut<u8>(&mut v11, v26) = *0x1::vector::borrow<u8>(&v9, v25 + 2) & 7;
                    *0x1::vector::borrow_mut<u8>(&mut v12, v26) = *0x1::vector::borrow<u8>(&v9, v25 + 2) >> 3;
                    *0x1::vector::borrow_mut<u8>(&mut v13, v26) = *0x1::vector::borrow<u8>(&v9, v25) >> 6 & 1;
                    *0x1::vector::borrow_mut<u8>(&mut v14, v26) = v17;
                    v24 = v24 + 1;
                };
                v24 = 0;
                while (v24 < v22) {
                    let v27 = v23 + v24 * 3;
                    if (*0x1::vector::borrow<u8>(&v9, v27) >> 5 & 1 == 1) {
                        let v28 = ((*0x1::vector::borrow<u8>(&v9, v27 + 1) as u64) + 1) * 32 + ((*0x1::vector::borrow<u8>(&v9, v27) & 31) as u64);
                        let v29 = if (*0x1::vector::borrow<u8>(&v11, v28) != 255) {
                            if (*0x1::vector::borrow<u8>(&v14, v28) != v17) {
                                if (*0x1::vector::borrow<u8>(&v11, v28) < 5) {
                                    *0x1::vector::borrow<u8>(&v12, v28) > 0
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
                            *0x1::vector::borrow_mut<u8>(&mut v12, v28) = *0x1::vector::borrow<u8>(&v12, v28) - 1;
                        };
                    };
                    v24 = v24 + 1;
                };
                v20 = v23 + v22 * 3;
                v21 = v21 + 1;
                v17 = v17 + 1;
            };
            v18 = v18 + 1;
        };
        let v30 = 0x1::vector::empty<u64>();
        let v31 = &mut v30;
        0x1::vector::push_back<u64>(v31, v4);
        0x1::vector::push_back<u64>(v31, v5);
        0x1::vector::push_back<u64>(v31, 10);
        0x1::vector::push_back<u64>(v31, 11);
        0x1::vector::push_back<u64>(v31, 12);
        0x1::vector::push_back<u64>(v31, 13 + v6);
        0x1::vector::push_back<u64>(v31, 19 + v6);
        let v32 = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::art::pal();
        let v33 = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::art::scenes();
        let v34 = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::art::scene_off();
        let v35 = (*0x1::vector::borrow<u8>(&v34, v7 * 3) as u64) << 16 | (*0x1::vector::borrow<u8>(&v34, v7 * 3 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(&v34, v7 * 3 + 2) as u64);
        let v36 = read2(&v33, v35);
        let v37 = v35 + 2;
        let v38 = b"";
        let v39 = 0;
        while (v39 < 48 * 48) {
            let v40 = if (v36 > 256) {
                read2(&v33, v37 + v36 * 3 + v39 * 2)
            } else {
                (*0x1::vector::borrow<u8>(&v33, v37 + v36 * 3 + v39) as u64)
            };
            0x1::vector::push_back<u8>(&mut v38, *0x1::vector::borrow<u8>(&v33, v37 + v40 * 3));
            0x1::vector::push_back<u8>(&mut v38, *0x1::vector::borrow<u8>(&v33, v37 + v40 * 3 + 1));
            0x1::vector::push_back<u8>(&mut v38, *0x1::vector::borrow<u8>(&v33, v37 + v40 * 3 + 2));
            v39 = v39 + 1;
        };
        let v41 = if (v0 == 5) {
            2
        } else {
            0
        };
        let v42 = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::art::shadow();
        let v43 = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::art::shadow_rgb();
        let v44 = if (v41 > 0) {
            144
        } else {
            0
        };
        v39 = 0;
        while (v39 < 3 * 48) {
            let v45 = (*0x1::vector::borrow<u8>(&v42, v44 + v39) as u64);
            if (v45 > 0) {
                let v46 = &mut v38;
                blend(v46, (42 * 48 + v39) * 3, &v43, 0, v45);
            };
            v39 = v39 + 1;
        };
        let v47 = 8;
        let v48 = 12 - v41;
        v39 = 0;
        while (v39 < 32 * 32) {
            let v49 = *0x1::vector::borrow<u8>(&v11, v39);
            if (v49 >= 5 && v49 != 255) {
                let v50 = v39 % 32 + v47;
                let v51 = v39 / 32 + v48;
                let v52 = 0;
                while (v52 < 5) {
                    let v53 = 0;
                    while (v53 < 5) {
                        let v54 = if (v53 > 2) {
                            v53 - 2
                        } else {
                            2 - v53
                        };
                        let v55 = if (v52 > 2) {
                            v52 - 2
                        } else {
                            2 - v52
                        };
                        let v56 = v54 + v55;
                        let v57 = if (v56 > 0) {
                            if (v56 <= 3) {
                                if (v50 + v53 >= 2) {
                                    if (v51 + v52 >= 2) {
                                        if (v50 + v53 - 2 < 48) {
                                            v51 + v52 - 2 < 48
                                        } else {
                                            false
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
                        if (v57) {
                            let v58 = if (v56 == 1) {
                                41
                            } else {
                                18
                            };
                            let v59 = &mut v38;
                            blend(v59, ((v51 + v52 - 2) * 48 + v50 + v53 - 2) * 3, &v32, colour(13 + v6, 3), v58);
                        };
                        v53 = v53 + 1;
                    };
                    v52 = v52 + 1;
                };
            };
            v39 = v39 + 1;
        };
        v39 = 0;
        while (v39 < 32 * 32) {
            let v60 = v39 % 32;
            let v61 = v39 / 32;
            let v62 = *0x1::vector::borrow<u8>(&v11, v39);
            if (v62 != 255) {
                let v63 = if (*0x1::vector::borrow<u8>(&v12, v39) > 4) {
                    4
                } else {
                    (*0x1::vector::borrow<u8>(&v12, v39) as u64)
                };
                let v64 = if (v62 >= 5) {
                    4
                } else if (*0x1::vector::borrow<u8>(&v13, v39) == 1) {
                    5 + v63
                } else {
                    v63
                };
                let v65 = &mut v38;
                copy3(v65, ((v61 + v48) * 48 + v60 + v47) * 3, &v32, colour(*0x1::vector::borrow<u64>(&v30, (v62 as u64)), v64));
            } else {
                let v66 = 32 * 32;
                let v67 = false;
                if (v61 > 0 && *0x1::vector::borrow<u8>(&v11, v39 - 32) != 255) {
                    v66 = v39 - 32;
                } else if (v61 < 32 - 1 && *0x1::vector::borrow<u8>(&v11, v39 + 32) != 255) {
                    v66 = v39 + 32;
                } else if (v60 > 0 && *0x1::vector::borrow<u8>(&v11, v39 - 1) != 255) {
                    v66 = v39 - 1;
                    v67 = true;
                } else if (v60 < 32 - 1 && *0x1::vector::borrow<u8>(&v11, v39 + 1) != 255) {
                    v66 = v39 + 1;
                };
                if (v66 < 32 * 32) {
                    let v68 = if (v67) {
                        11
                    } else {
                        10
                    };
                    let v69 = &mut v38;
                    copy3(v69, ((v61 + v48) * 48 + v60 + v47) * 3, &v32, colour(*0x1::vector::borrow<u64>(&v30, (*0x1::vector::borrow<u8>(&v11, v66) as u64)), v68));
                };
            };
            v39 = v39 + 1;
        };
        v38
    }

    fun push_hex(arg0: &mut vector<u8>, arg1: u8) {
        let v0 = b"0123456789abcdef";
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, ((arg1 >> 4) as u64)));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, ((arg1 & 15) as u64)));
    }

    fun push_num(arg0: &mut vector<u8>, arg1: u64) {
        if (arg1 >= 10) {
            push_num(arg0, arg1 / 10);
        };
        0x1::vector::push_back<u8>(arg0, 48 + ((arg1 % 10) as u8));
    }

    fun read2(arg0: &vector<u8>, arg1: u64) : u64 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u64)
    }

    public fun svg(arg0: u64) : 0x1::string::String {
        let v0 = pixels(arg0);
        let v1 = b"<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 48 48\" shape-rendering=\"crispEdges\">";
        let v2 = 0;
        while (v2 < 48) {
            let v3 = 0;
            while (v3 < 48) {
                let v4 = (v2 * 48 + v3) * 3;
                let v5 = 1;
                loop {
                    let v6 = if (v3 + v5 < 48) {
                        if (*0x1::vector::borrow<u8>(&v0, v4 + v5 * 3) == *0x1::vector::borrow<u8>(&v0, v4)) {
                            if (*0x1::vector::borrow<u8>(&v0, v4 + v5 * 3 + 1) == *0x1::vector::borrow<u8>(&v0, v4 + 1)) {
                                *0x1::vector::borrow<u8>(&v0, v4 + v5 * 3 + 2) == *0x1::vector::borrow<u8>(&v0, v4 + 2)
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
                        v5 = v5 + 1;
                    } else {
                        break
                    };
                };
                0x1::vector::append<u8>(&mut v1, b"<rect x=\"");
                let v7 = &mut v1;
                push_num(v7, v3);
                0x1::vector::append<u8>(&mut v1, b"\" y=\"");
                let v8 = &mut v1;
                push_num(v8, v2);
                0x1::vector::append<u8>(&mut v1, b"\" width=\"");
                let v9 = &mut v1;
                push_num(v9, v5);
                0x1::vector::append<u8>(&mut v1, b"\" height=\"1\" fill=\"#");
                let v10 = &mut v1;
                push_hex(v10, *0x1::vector::borrow<u8>(&v0, v4));
                let v11 = &mut v1;
                push_hex(v11, *0x1::vector::borrow<u8>(&v0, v4 + 1));
                let v12 = &mut v1;
                push_hex(v12, *0x1::vector::borrow<u8>(&v0, v4 + 2));
                0x1::vector::append<u8>(&mut v1, b"\"/>");
                v3 = v3 + v5;
            };
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v1, b"</svg>");
        0x1::string::utf8(v1)
    }

    // decompiled from Move bytecode v7
}

