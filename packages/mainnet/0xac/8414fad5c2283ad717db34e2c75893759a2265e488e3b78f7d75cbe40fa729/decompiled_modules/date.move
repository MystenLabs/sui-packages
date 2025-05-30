module 0xac8414fad5c2283ad717db34e2c75893759a2265e488e3b78f7d75cbe40fa729::date {
    struct Date has copy, drop, store {
        year: u16,
        month: u8,
        day: u8,
        day_of_week: u8,
        hour: u8,
        minute: u8,
        second: u8,
        millisecond: u16,
        timezone_offset_m: u16,
        timestamp_ms: u64,
    }

    public fun timestamp_ms(arg0: &Date) : u64 {
        arg0.timestamp_ms
    }

    public fun day(arg0: &Date) : u8 {
        arg0.day
    }

    public fun format(arg0: &Date, arg1: vector<u8>) : 0x1::string::String {
        let v0 = vector[b"Jan", b"Feb", b"Mar", b"Apr", b"May", b"Jun", b"Jul", b"Aug", b"Sep", b"Oct", b"Nov", b"Dec"];
        let v1 = vector[b"Sun", b"Mon", b"Tue", b"Wed", b"Thu", b"Fri", b"Sat"];
        let v2 = vector[b"January", b"February", b"March", b"April", b"May", b"June", b"July", b"August", b"September", b"October", b"November", b"December"];
        let v3 = vector[b"Sunday", b"Monday", b"Tuesday", b"Wednesday", b"Thursday", b"Friday", b"Saturday"];
        let v4 = b"";
        let v5 = 0x1::vector::length<u8>(&arg1);
        let v6 = 0;
        while (v6 < v5) {
            let v7 = *0x1::vector::borrow<u8>(&arg1, v6);
            let v8 = &v7;
            let v9 = 89;
            if (v8 == &v9) {
                let v10 = if (v6 + 3 < v5) {
                    if (0x1::vector::borrow<u8>(&arg1, v6 + 1) == &v7) {
                        if (0x1::vector::borrow<u8>(&arg1, v6 + 2) == &v7) {
                            0x1::vector::borrow<u8>(&arg1, v6 + 3) == &v7
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
                    let v11 = (arg0.year as u16);
                    let v12 = 48;
                    let v13 = if (v11 < 10) {
                        let v14 = 0x1::vector::empty<u8>();
                        0x1::vector::push_back<u8>(&mut v14, ((v11 + v12) as u8));
                        v14
                    } else if (v11 < 100) {
                        let v15 = 0x1::vector::empty<u8>();
                        let v16 = &mut v15;
                        0x1::vector::push_back<u8>(v16, ((v11 / 10 + v12) as u8));
                        0x1::vector::push_back<u8>(v16, ((v11 % 10 + v12) as u8));
                        v15
                    } else if (v11 < 1000) {
                        let v17 = 0x1::vector::empty<u8>();
                        let v18 = &mut v17;
                        0x1::vector::push_back<u8>(v18, ((v11 / 100 + v12) as u8));
                        0x1::vector::push_back<u8>(v18, ((v11 / 10 % 10 + v12) as u8));
                        0x1::vector::push_back<u8>(v18, ((v11 % 10 + v12) as u8));
                        v17
                    } else {
                        let v19 = 0x1::vector::empty<u8>();
                        let v20 = &mut v19;
                        0x1::vector::push_back<u8>(v20, ((v11 / 1000 + v12) as u8));
                        0x1::vector::push_back<u8>(v20, ((v11 / 100 % 10 + v12) as u8));
                        0x1::vector::push_back<u8>(v20, ((v11 / 10 % 10 + v12) as u8));
                        0x1::vector::push_back<u8>(v20, ((v11 % 10 + v12) as u8));
                        v19
                    };
                    0x1::vector::append<u8>(&mut v4, v13);
                    v6 = v6 + 3;
                } else {
                    assert!(v6 + 1 < v5 && *0x1::vector::borrow<u8>(&arg1, v6 + 1) == v7, 8);
                    let v21 = ((arg0.year % 100) as u16);
                    let v22 = 48;
                    let v23 = if (v21 < 10) {
                        let v24 = 0x1::vector::empty<u8>();
                        let v25 = &mut v24;
                        0x1::vector::push_back<u8>(v25, (v22 as u8));
                        0x1::vector::push_back<u8>(v25, ((v21 + v22) as u8));
                        v24
                    } else if (v21 < 100) {
                        let v26 = 0x1::vector::empty<u8>();
                        let v27 = &mut v26;
                        0x1::vector::push_back<u8>(v27, ((v21 / 10 + v22) as u8));
                        0x1::vector::push_back<u8>(v27, ((v21 % 10 + v22) as u8));
                        v26
                    } else if (v21 < 1000) {
                        let v28 = 0x1::vector::empty<u8>();
                        let v29 = &mut v28;
                        0x1::vector::push_back<u8>(v29, ((v21 / 100 + v22) as u8));
                        0x1::vector::push_back<u8>(v29, ((v21 / 10 % 10 + v22) as u8));
                        0x1::vector::push_back<u8>(v29, ((v21 % 10 + v22) as u8));
                        v28
                    } else {
                        let v30 = 0x1::vector::empty<u8>();
                        let v31 = &mut v30;
                        0x1::vector::push_back<u8>(v31, ((v21 / 1000 + v22) as u8));
                        0x1::vector::push_back<u8>(v31, ((v21 / 100 % 10 + v22) as u8));
                        0x1::vector::push_back<u8>(v31, ((v21 / 10 % 10 + v22) as u8));
                        0x1::vector::push_back<u8>(v31, ((v21 % 10 + v22) as u8));
                        v30
                    };
                    0x1::vector::append<u8>(&mut v4, v23);
                    v6 = v6 + 1;
                };
            } else {
                let v32 = 121;
                if (v8 == &v32) {
                    let v33 = if (v6 + 3 < v5) {
                        if (0x1::vector::borrow<u8>(&arg1, v6 + 1) == &v7) {
                            if (0x1::vector::borrow<u8>(&arg1, v6 + 2) == &v7) {
                                0x1::vector::borrow<u8>(&arg1, v6 + 3) == &v7
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
                        let v34 = (arg0.year as u16);
                        let v35 = 48;
                        let v36 = if (v34 < 10) {
                            let v37 = 0x1::vector::empty<u8>();
                            0x1::vector::push_back<u8>(&mut v37, ((v34 + v35) as u8));
                            v37
                        } else if (v34 < 100) {
                            let v38 = 0x1::vector::empty<u8>();
                            let v39 = &mut v38;
                            0x1::vector::push_back<u8>(v39, ((v34 / 10 + v35) as u8));
                            0x1::vector::push_back<u8>(v39, ((v34 % 10 + v35) as u8));
                            v38
                        } else if (v34 < 1000) {
                            let v40 = 0x1::vector::empty<u8>();
                            let v41 = &mut v40;
                            0x1::vector::push_back<u8>(v41, ((v34 / 100 + v35) as u8));
                            0x1::vector::push_back<u8>(v41, ((v34 / 10 % 10 + v35) as u8));
                            0x1::vector::push_back<u8>(v41, ((v34 % 10 + v35) as u8));
                            v40
                        } else {
                            let v42 = 0x1::vector::empty<u8>();
                            let v43 = &mut v42;
                            0x1::vector::push_back<u8>(v43, ((v34 / 1000 + v35) as u8));
                            0x1::vector::push_back<u8>(v43, ((v34 / 100 % 10 + v35) as u8));
                            0x1::vector::push_back<u8>(v43, ((v34 / 10 % 10 + v35) as u8));
                            0x1::vector::push_back<u8>(v43, ((v34 % 10 + v35) as u8));
                            v42
                        };
                        0x1::vector::append<u8>(&mut v4, v36);
                        v6 = v6 + 3;
                    } else {
                        assert!(v6 + 1 < v5 && *0x1::vector::borrow<u8>(&arg1, v6 + 1) == v7, 8);
                        let v44 = ((arg0.year % 100) as u16);
                        let v45 = 48;
                        let v46 = if (v44 < 10) {
                            let v47 = 0x1::vector::empty<u8>();
                            let v48 = &mut v47;
                            0x1::vector::push_back<u8>(v48, (v45 as u8));
                            0x1::vector::push_back<u8>(v48, ((v44 + v45) as u8));
                            v47
                        } else if (v44 < 100) {
                            let v49 = 0x1::vector::empty<u8>();
                            let v50 = &mut v49;
                            0x1::vector::push_back<u8>(v50, ((v44 / 10 + v45) as u8));
                            0x1::vector::push_back<u8>(v50, ((v44 % 10 + v45) as u8));
                            v49
                        } else if (v44 < 1000) {
                            let v51 = 0x1::vector::empty<u8>();
                            let v52 = &mut v51;
                            0x1::vector::push_back<u8>(v52, ((v44 / 100 + v45) as u8));
                            0x1::vector::push_back<u8>(v52, ((v44 / 10 % 10 + v45) as u8));
                            0x1::vector::push_back<u8>(v52, ((v44 % 10 + v45) as u8));
                            v51
                        } else {
                            let v53 = 0x1::vector::empty<u8>();
                            let v54 = &mut v53;
                            0x1::vector::push_back<u8>(v54, ((v44 / 1000 + v45) as u8));
                            0x1::vector::push_back<u8>(v54, ((v44 / 100 % 10 + v45) as u8));
                            0x1::vector::push_back<u8>(v54, ((v44 / 10 % 10 + v45) as u8));
                            0x1::vector::push_back<u8>(v54, ((v44 % 10 + v45) as u8));
                            v53
                        };
                        0x1::vector::append<u8>(&mut v4, v46);
                        v6 = v6 + 1;
                    };
                } else {
                    let v55 = 77;
                    if (v8 == &v55) {
                        let v56 = if (v6 + 3 < v5) {
                            if (*0x1::vector::borrow<u8>(&arg1, v6 + 1) == 77) {
                                if (*0x1::vector::borrow<u8>(&arg1, v6 + 2) == 77) {
                                    *0x1::vector::borrow<u8>(&arg1, v6 + 3) == 77
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v56) {
                            0x1::vector::append<u8>(&mut v4, *0x1::vector::borrow<vector<u8>>(&v2, (arg0.month as u64)));
                            v6 = v6 + 3;
                        } else {
                            let v57 = if (v6 + 2 < v5) {
                                if (*0x1::vector::borrow<u8>(&arg1, v6 + 1) == 77) {
                                    *0x1::vector::borrow<u8>(&arg1, v6 + 2) == 77
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            if (v57) {
                                0x1::vector::append<u8>(&mut v4, *0x1::vector::borrow<vector<u8>>(&v0, (arg0.month as u64)));
                                v6 = v6 + 2;
                            } else if (v6 + 1 < v5 && *0x1::vector::borrow<u8>(&arg1, v6 + 1) == 77) {
                                let v58 = ((arg0.month + 1) as u16);
                                let v59 = 48;
                                let v60 = if (v58 < 10) {
                                    let v61 = 0x1::vector::empty<u8>();
                                    let v62 = &mut v61;
                                    0x1::vector::push_back<u8>(v62, (v59 as u8));
                                    0x1::vector::push_back<u8>(v62, ((v58 + v59) as u8));
                                    v61
                                } else if (v58 < 100) {
                                    let v63 = 0x1::vector::empty<u8>();
                                    let v64 = &mut v63;
                                    0x1::vector::push_back<u8>(v64, ((v58 / 10 + v59) as u8));
                                    0x1::vector::push_back<u8>(v64, ((v58 % 10 + v59) as u8));
                                    v63
                                } else if (v58 < 1000) {
                                    let v65 = 0x1::vector::empty<u8>();
                                    let v66 = &mut v65;
                                    0x1::vector::push_back<u8>(v66, ((v58 / 100 + v59) as u8));
                                    0x1::vector::push_back<u8>(v66, ((v58 / 10 % 10 + v59) as u8));
                                    0x1::vector::push_back<u8>(v66, ((v58 % 10 + v59) as u8));
                                    v65
                                } else {
                                    let v67 = 0x1::vector::empty<u8>();
                                    let v68 = &mut v67;
                                    0x1::vector::push_back<u8>(v68, ((v58 / 1000 + v59) as u8));
                                    0x1::vector::push_back<u8>(v68, ((v58 / 100 % 10 + v59) as u8));
                                    0x1::vector::push_back<u8>(v68, ((v58 / 10 % 10 + v59) as u8));
                                    0x1::vector::push_back<u8>(v68, ((v58 % 10 + v59) as u8));
                                    v67
                                };
                                0x1::vector::append<u8>(&mut v4, v60);
                                v6 = v6 + 1;
                            } else {
                                let v69 = ((arg0.month + 1) as u16);
                                let v70 = 48;
                                let v71 = if (v69 < 10) {
                                    let v72 = 0x1::vector::empty<u8>();
                                    0x1::vector::push_back<u8>(&mut v72, ((v69 + v70) as u8));
                                    v72
                                } else if (v69 < 100) {
                                    let v73 = 0x1::vector::empty<u8>();
                                    let v74 = &mut v73;
                                    0x1::vector::push_back<u8>(v74, ((v69 / 10 + v70) as u8));
                                    0x1::vector::push_back<u8>(v74, ((v69 % 10 + v70) as u8));
                                    v73
                                } else if (v69 < 1000) {
                                    let v75 = 0x1::vector::empty<u8>();
                                    let v76 = &mut v75;
                                    0x1::vector::push_back<u8>(v76, ((v69 / 100 + v70) as u8));
                                    0x1::vector::push_back<u8>(v76, ((v69 / 10 % 10 + v70) as u8));
                                    0x1::vector::push_back<u8>(v76, ((v69 % 10 + v70) as u8));
                                    v75
                                } else {
                                    let v77 = 0x1::vector::empty<u8>();
                                    let v78 = &mut v77;
                                    0x1::vector::push_back<u8>(v78, ((v69 / 1000 + v70) as u8));
                                    0x1::vector::push_back<u8>(v78, ((v69 / 100 % 10 + v70) as u8));
                                    0x1::vector::push_back<u8>(v78, ((v69 / 10 % 10 + v70) as u8));
                                    0x1::vector::push_back<u8>(v78, ((v69 % 10 + v70) as u8));
                                    v77
                                };
                                0x1::vector::append<u8>(&mut v4, v71);
                            };
                        };
                    } else {
                        let v79 = 68;
                        if (v8 == &v79) {
                            let v80 = if (v6 + 3 < v5) {
                                if (0x1::vector::borrow<u8>(&arg1, v6 + 1) == &v7) {
                                    if (0x1::vector::borrow<u8>(&arg1, v6 + 2) == &v7) {
                                        0x1::vector::borrow<u8>(&arg1, v6 + 3) == &v7
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            if (v80) {
                                0x1::vector::append<u8>(&mut v4, *0x1::vector::borrow<vector<u8>>(&v3, (arg0.day_of_week as u64)));
                                v6 = v6 + 3;
                            } else {
                                let v81 = if (v6 + 2 < v5) {
                                    if (*0x1::vector::borrow<u8>(&arg1, v6 + 1) == v7) {
                                        *0x1::vector::borrow<u8>(&arg1, v6 + 2) == v7
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v81) {
                                    0x1::vector::append<u8>(&mut v4, *0x1::vector::borrow<vector<u8>>(&v1, (arg0.day_of_week as u64)));
                                    v6 = v6 + 2;
                                } else if (v6 + 1 < v5 && *0x1::vector::borrow<u8>(&arg1, v6 + 1) == v7) {
                                    let v82 = (arg0.day as u16);
                                    let v83 = 48;
                                    let v84 = if (v82 < 10) {
                                        let v85 = 0x1::vector::empty<u8>();
                                        let v86 = &mut v85;
                                        0x1::vector::push_back<u8>(v86, (v83 as u8));
                                        0x1::vector::push_back<u8>(v86, ((v82 + v83) as u8));
                                        v85
                                    } else if (v82 < 100) {
                                        let v87 = 0x1::vector::empty<u8>();
                                        let v88 = &mut v87;
                                        0x1::vector::push_back<u8>(v88, ((v82 / 10 + v83) as u8));
                                        0x1::vector::push_back<u8>(v88, ((v82 % 10 + v83) as u8));
                                        v87
                                    } else if (v82 < 1000) {
                                        let v89 = 0x1::vector::empty<u8>();
                                        let v90 = &mut v89;
                                        0x1::vector::push_back<u8>(v90, ((v82 / 100 + v83) as u8));
                                        0x1::vector::push_back<u8>(v90, ((v82 / 10 % 10 + v83) as u8));
                                        0x1::vector::push_back<u8>(v90, ((v82 % 10 + v83) as u8));
                                        v89
                                    } else {
                                        let v91 = 0x1::vector::empty<u8>();
                                        let v92 = &mut v91;
                                        0x1::vector::push_back<u8>(v92, ((v82 / 1000 + v83) as u8));
                                        0x1::vector::push_back<u8>(v92, ((v82 / 100 % 10 + v83) as u8));
                                        0x1::vector::push_back<u8>(v92, ((v82 / 10 % 10 + v83) as u8));
                                        0x1::vector::push_back<u8>(v92, ((v82 % 10 + v83) as u8));
                                        v91
                                    };
                                    0x1::vector::append<u8>(&mut v4, v84);
                                    v6 = v6 + 1;
                                } else {
                                    let v93 = (arg0.day as u16);
                                    let v94 = 48;
                                    let v95 = if (v93 < 10) {
                                        let v96 = 0x1::vector::empty<u8>();
                                        0x1::vector::push_back<u8>(&mut v96, ((v93 + v94) as u8));
                                        v96
                                    } else if (v93 < 100) {
                                        let v97 = 0x1::vector::empty<u8>();
                                        let v98 = &mut v97;
                                        0x1::vector::push_back<u8>(v98, ((v93 / 10 + v94) as u8));
                                        0x1::vector::push_back<u8>(v98, ((v93 % 10 + v94) as u8));
                                        v97
                                    } else if (v93 < 1000) {
                                        let v99 = 0x1::vector::empty<u8>();
                                        let v100 = &mut v99;
                                        0x1::vector::push_back<u8>(v100, ((v93 / 100 + v94) as u8));
                                        0x1::vector::push_back<u8>(v100, ((v93 / 10 % 10 + v94) as u8));
                                        0x1::vector::push_back<u8>(v100, ((v93 % 10 + v94) as u8));
                                        v99
                                    } else {
                                        let v101 = 0x1::vector::empty<u8>();
                                        let v102 = &mut v101;
                                        0x1::vector::push_back<u8>(v102, ((v93 / 1000 + v94) as u8));
                                        0x1::vector::push_back<u8>(v102, ((v93 / 100 % 10 + v94) as u8));
                                        0x1::vector::push_back<u8>(v102, ((v93 / 10 % 10 + v94) as u8));
                                        0x1::vector::push_back<u8>(v102, ((v93 % 10 + v94) as u8));
                                        v101
                                    };
                                    0x1::vector::append<u8>(&mut v4, v95);
                                };
                            };
                        } else {
                            let v103 = 100;
                            if (v8 == &v103) {
                                let v104 = if (v6 + 3 < v5) {
                                    if (0x1::vector::borrow<u8>(&arg1, v6 + 1) == &v7) {
                                        if (0x1::vector::borrow<u8>(&arg1, v6 + 2) == &v7) {
                                            0x1::vector::borrow<u8>(&arg1, v6 + 3) == &v7
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v104) {
                                    0x1::vector::append<u8>(&mut v4, *0x1::vector::borrow<vector<u8>>(&v3, (arg0.day_of_week as u64)));
                                    v6 = v6 + 3;
                                } else {
                                    let v105 = if (v6 + 2 < v5) {
                                        if (*0x1::vector::borrow<u8>(&arg1, v6 + 1) == v7) {
                                            *0x1::vector::borrow<u8>(&arg1, v6 + 2) == v7
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    };
                                    if (v105) {
                                        0x1::vector::append<u8>(&mut v4, *0x1::vector::borrow<vector<u8>>(&v1, (arg0.day_of_week as u64)));
                                        v6 = v6 + 2;
                                    } else if (v6 + 1 < v5 && *0x1::vector::borrow<u8>(&arg1, v6 + 1) == v7) {
                                        let v106 = (arg0.day as u16);
                                        let v107 = 48;
                                        let v108 = if (v106 < 10) {
                                            let v109 = 0x1::vector::empty<u8>();
                                            let v110 = &mut v109;
                                            0x1::vector::push_back<u8>(v110, (v107 as u8));
                                            0x1::vector::push_back<u8>(v110, ((v106 + v107) as u8));
                                            v109
                                        } else if (v106 < 100) {
                                            let v111 = 0x1::vector::empty<u8>();
                                            let v112 = &mut v111;
                                            0x1::vector::push_back<u8>(v112, ((v106 / 10 + v107) as u8));
                                            0x1::vector::push_back<u8>(v112, ((v106 % 10 + v107) as u8));
                                            v111
                                        } else if (v106 < 1000) {
                                            let v113 = 0x1::vector::empty<u8>();
                                            let v114 = &mut v113;
                                            0x1::vector::push_back<u8>(v114, ((v106 / 100 + v107) as u8));
                                            0x1::vector::push_back<u8>(v114, ((v106 / 10 % 10 + v107) as u8));
                                            0x1::vector::push_back<u8>(v114, ((v106 % 10 + v107) as u8));
                                            v113
                                        } else {
                                            let v115 = 0x1::vector::empty<u8>();
                                            let v116 = &mut v115;
                                            0x1::vector::push_back<u8>(v116, ((v106 / 1000 + v107) as u8));
                                            0x1::vector::push_back<u8>(v116, ((v106 / 100 % 10 + v107) as u8));
                                            0x1::vector::push_back<u8>(v116, ((v106 / 10 % 10 + v107) as u8));
                                            0x1::vector::push_back<u8>(v116, ((v106 % 10 + v107) as u8));
                                            v115
                                        };
                                        0x1::vector::append<u8>(&mut v4, v108);
                                        v6 = v6 + 1;
                                    } else {
                                        let v117 = (arg0.day as u16);
                                        let v118 = 48;
                                        let v119 = if (v117 < 10) {
                                            let v120 = 0x1::vector::empty<u8>();
                                            0x1::vector::push_back<u8>(&mut v120, ((v117 + v118) as u8));
                                            v120
                                        } else if (v117 < 100) {
                                            let v121 = 0x1::vector::empty<u8>();
                                            let v122 = &mut v121;
                                            0x1::vector::push_back<u8>(v122, ((v117 / 10 + v118) as u8));
                                            0x1::vector::push_back<u8>(v122, ((v117 % 10 + v118) as u8));
                                            v121
                                        } else if (v117 < 1000) {
                                            let v123 = 0x1::vector::empty<u8>();
                                            let v124 = &mut v123;
                                            0x1::vector::push_back<u8>(v124, ((v117 / 100 + v118) as u8));
                                            0x1::vector::push_back<u8>(v124, ((v117 / 10 % 10 + v118) as u8));
                                            0x1::vector::push_back<u8>(v124, ((v117 % 10 + v118) as u8));
                                            v123
                                        } else {
                                            let v125 = 0x1::vector::empty<u8>();
                                            let v126 = &mut v125;
                                            0x1::vector::push_back<u8>(v126, ((v117 / 1000 + v118) as u8));
                                            0x1::vector::push_back<u8>(v126, ((v117 / 100 % 10 + v118) as u8));
                                            0x1::vector::push_back<u8>(v126, ((v117 / 10 % 10 + v118) as u8));
                                            0x1::vector::push_back<u8>(v126, ((v117 % 10 + v118) as u8));
                                            v125
                                        };
                                        0x1::vector::append<u8>(&mut v4, v119);
                                    };
                                };
                            } else {
                                let v127 = 72;
                                if (v8 == &v127) {
                                    if (v6 + 1 < v5 && *0x1::vector::borrow<u8>(&arg1, v6 + 1) == 72) {
                                        let v128 = (arg0.hour as u16);
                                        let v129 = 48;
                                        let v130 = if (v128 < 10) {
                                            let v131 = 0x1::vector::empty<u8>();
                                            let v132 = &mut v131;
                                            0x1::vector::push_back<u8>(v132, (v129 as u8));
                                            0x1::vector::push_back<u8>(v132, ((v128 + v129) as u8));
                                            v131
                                        } else if (v128 < 100) {
                                            let v133 = 0x1::vector::empty<u8>();
                                            let v134 = &mut v133;
                                            0x1::vector::push_back<u8>(v134, ((v128 / 10 + v129) as u8));
                                            0x1::vector::push_back<u8>(v134, ((v128 % 10 + v129) as u8));
                                            v133
                                        } else if (v128 < 1000) {
                                            let v135 = 0x1::vector::empty<u8>();
                                            let v136 = &mut v135;
                                            0x1::vector::push_back<u8>(v136, ((v128 / 100 + v129) as u8));
                                            0x1::vector::push_back<u8>(v136, ((v128 / 10 % 10 + v129) as u8));
                                            0x1::vector::push_back<u8>(v136, ((v128 % 10 + v129) as u8));
                                            v135
                                        } else {
                                            let v137 = 0x1::vector::empty<u8>();
                                            let v138 = &mut v137;
                                            0x1::vector::push_back<u8>(v138, ((v128 / 1000 + v129) as u8));
                                            0x1::vector::push_back<u8>(v138, ((v128 / 100 % 10 + v129) as u8));
                                            0x1::vector::push_back<u8>(v138, ((v128 / 10 % 10 + v129) as u8));
                                            0x1::vector::push_back<u8>(v138, ((v128 % 10 + v129) as u8));
                                            v137
                                        };
                                        0x1::vector::append<u8>(&mut v4, v130);
                                        v6 = v6 + 1;
                                    } else {
                                        let v139 = (arg0.hour as u16);
                                        let v140 = 48;
                                        let v141 = if (v139 < 10) {
                                            let v142 = 0x1::vector::empty<u8>();
                                            0x1::vector::push_back<u8>(&mut v142, ((v139 + v140) as u8));
                                            v142
                                        } else if (v139 < 100) {
                                            let v143 = 0x1::vector::empty<u8>();
                                            let v144 = &mut v143;
                                            0x1::vector::push_back<u8>(v144, ((v139 / 10 + v140) as u8));
                                            0x1::vector::push_back<u8>(v144, ((v139 % 10 + v140) as u8));
                                            v143
                                        } else if (v139 < 1000) {
                                            let v145 = 0x1::vector::empty<u8>();
                                            let v146 = &mut v145;
                                            0x1::vector::push_back<u8>(v146, ((v139 / 100 + v140) as u8));
                                            0x1::vector::push_back<u8>(v146, ((v139 / 10 % 10 + v140) as u8));
                                            0x1::vector::push_back<u8>(v146, ((v139 % 10 + v140) as u8));
                                            v145
                                        } else {
                                            let v147 = 0x1::vector::empty<u8>();
                                            let v148 = &mut v147;
                                            0x1::vector::push_back<u8>(v148, ((v139 / 1000 + v140) as u8));
                                            0x1::vector::push_back<u8>(v148, ((v139 / 100 % 10 + v140) as u8));
                                            0x1::vector::push_back<u8>(v148, ((v139 / 10 % 10 + v140) as u8));
                                            0x1::vector::push_back<u8>(v148, ((v139 % 10 + v140) as u8));
                                            v147
                                        };
                                        0x1::vector::append<u8>(&mut v4, v141);
                                    };
                                } else {
                                    let v149 = 104;
                                    if (v8 == &v149) {
                                        if (v6 + 1 < v5 && *0x1::vector::borrow<u8>(&arg1, v6 + 1) == 104) {
                                            let v150 = if (arg0.hour == 0) {
                                                12
                                            } else {
                                                arg0.hour % 12
                                            };
                                            let v151 = (v150 as u16);
                                            let v152 = 48;
                                            let v153 = if (v151 < 10) {
                                                let v154 = 0x1::vector::empty<u8>();
                                                let v155 = &mut v154;
                                                0x1::vector::push_back<u8>(v155, (v152 as u8));
                                                0x1::vector::push_back<u8>(v155, ((v151 + v152) as u8));
                                                v154
                                            } else if (v151 < 100) {
                                                let v156 = 0x1::vector::empty<u8>();
                                                let v157 = &mut v156;
                                                0x1::vector::push_back<u8>(v157, ((v151 / 10 + v152) as u8));
                                                0x1::vector::push_back<u8>(v157, ((v151 % 10 + v152) as u8));
                                                v156
                                            } else if (v151 < 1000) {
                                                let v158 = 0x1::vector::empty<u8>();
                                                let v159 = &mut v158;
                                                0x1::vector::push_back<u8>(v159, ((v151 / 100 + v152) as u8));
                                                0x1::vector::push_back<u8>(v159, ((v151 / 10 % 10 + v152) as u8));
                                                0x1::vector::push_back<u8>(v159, ((v151 % 10 + v152) as u8));
                                                v158
                                            } else {
                                                let v160 = 0x1::vector::empty<u8>();
                                                let v161 = &mut v160;
                                                0x1::vector::push_back<u8>(v161, ((v151 / 1000 + v152) as u8));
                                                0x1::vector::push_back<u8>(v161, ((v151 / 100 % 10 + v152) as u8));
                                                0x1::vector::push_back<u8>(v161, ((v151 / 10 % 10 + v152) as u8));
                                                0x1::vector::push_back<u8>(v161, ((v151 % 10 + v152) as u8));
                                                v160
                                            };
                                            0x1::vector::append<u8>(&mut v4, v153);
                                            v6 = v6 + 1;
                                        } else {
                                            let v162 = if (arg0.hour == 0) {
                                                12
                                            } else {
                                                arg0.hour % 12
                                            };
                                            let v163 = (v162 as u16);
                                            let v164 = 48;
                                            let v165 = if (v163 < 10) {
                                                let v166 = 0x1::vector::empty<u8>();
                                                0x1::vector::push_back<u8>(&mut v166, ((v163 + v164) as u8));
                                                v166
                                            } else if (v163 < 100) {
                                                let v167 = 0x1::vector::empty<u8>();
                                                let v168 = &mut v167;
                                                0x1::vector::push_back<u8>(v168, ((v163 / 10 + v164) as u8));
                                                0x1::vector::push_back<u8>(v168, ((v163 % 10 + v164) as u8));
                                                v167
                                            } else if (v163 < 1000) {
                                                let v169 = 0x1::vector::empty<u8>();
                                                let v170 = &mut v169;
                                                0x1::vector::push_back<u8>(v170, ((v163 / 100 + v164) as u8));
                                                0x1::vector::push_back<u8>(v170, ((v163 / 10 % 10 + v164) as u8));
                                                0x1::vector::push_back<u8>(v170, ((v163 % 10 + v164) as u8));
                                                v169
                                            } else {
                                                let v171 = 0x1::vector::empty<u8>();
                                                let v172 = &mut v171;
                                                0x1::vector::push_back<u8>(v172, ((v163 / 1000 + v164) as u8));
                                                0x1::vector::push_back<u8>(v172, ((v163 / 100 % 10 + v164) as u8));
                                                0x1::vector::push_back<u8>(v172, ((v163 / 10 % 10 + v164) as u8));
                                                0x1::vector::push_back<u8>(v172, ((v163 % 10 + v164) as u8));
                                                v171
                                            };
                                            0x1::vector::append<u8>(&mut v4, v165);
                                        };
                                    } else {
                                        let v173 = 109;
                                        if (v8 == &v173) {
                                            if (v6 + 1 < v5 && *0x1::vector::borrow<u8>(&arg1, v6 + 1) == 109) {
                                                let v174 = (arg0.minute as u16);
                                                let v175 = 48;
                                                let v176 = if (v174 < 10) {
                                                    let v177 = 0x1::vector::empty<u8>();
                                                    let v178 = &mut v177;
                                                    0x1::vector::push_back<u8>(v178, (v175 as u8));
                                                    0x1::vector::push_back<u8>(v178, ((v174 + v175) as u8));
                                                    v177
                                                } else if (v174 < 100) {
                                                    let v179 = 0x1::vector::empty<u8>();
                                                    let v180 = &mut v179;
                                                    0x1::vector::push_back<u8>(v180, ((v174 / 10 + v175) as u8));
                                                    0x1::vector::push_back<u8>(v180, ((v174 % 10 + v175) as u8));
                                                    v179
                                                } else if (v174 < 1000) {
                                                    let v181 = 0x1::vector::empty<u8>();
                                                    let v182 = &mut v181;
                                                    0x1::vector::push_back<u8>(v182, ((v174 / 100 + v175) as u8));
                                                    0x1::vector::push_back<u8>(v182, ((v174 / 10 % 10 + v175) as u8));
                                                    0x1::vector::push_back<u8>(v182, ((v174 % 10 + v175) as u8));
                                                    v181
                                                } else {
                                                    let v183 = 0x1::vector::empty<u8>();
                                                    let v184 = &mut v183;
                                                    0x1::vector::push_back<u8>(v184, ((v174 / 1000 + v175) as u8));
                                                    0x1::vector::push_back<u8>(v184, ((v174 / 100 % 10 + v175) as u8));
                                                    0x1::vector::push_back<u8>(v184, ((v174 / 10 % 10 + v175) as u8));
                                                    0x1::vector::push_back<u8>(v184, ((v174 % 10 + v175) as u8));
                                                    v183
                                                };
                                                0x1::vector::append<u8>(&mut v4, v176);
                                                v6 = v6 + 1;
                                            } else {
                                                let v185 = (arg0.minute as u16);
                                                let v186 = 48;
                                                let v187 = if (v185 < 10) {
                                                    let v188 = 0x1::vector::empty<u8>();
                                                    0x1::vector::push_back<u8>(&mut v188, ((v185 + v186) as u8));
                                                    v188
                                                } else if (v185 < 100) {
                                                    let v189 = 0x1::vector::empty<u8>();
                                                    let v190 = &mut v189;
                                                    0x1::vector::push_back<u8>(v190, ((v185 / 10 + v186) as u8));
                                                    0x1::vector::push_back<u8>(v190, ((v185 % 10 + v186) as u8));
                                                    v189
                                                } else if (v185 < 1000) {
                                                    let v191 = 0x1::vector::empty<u8>();
                                                    let v192 = &mut v191;
                                                    0x1::vector::push_back<u8>(v192, ((v185 / 100 + v186) as u8));
                                                    0x1::vector::push_back<u8>(v192, ((v185 / 10 % 10 + v186) as u8));
                                                    0x1::vector::push_back<u8>(v192, ((v185 % 10 + v186) as u8));
                                                    v191
                                                } else {
                                                    let v193 = 0x1::vector::empty<u8>();
                                                    let v194 = &mut v193;
                                                    0x1::vector::push_back<u8>(v194, ((v185 / 1000 + v186) as u8));
                                                    0x1::vector::push_back<u8>(v194, ((v185 / 100 % 10 + v186) as u8));
                                                    0x1::vector::push_back<u8>(v194, ((v185 / 10 % 10 + v186) as u8));
                                                    0x1::vector::push_back<u8>(v194, ((v185 % 10 + v186) as u8));
                                                    v193
                                                };
                                                0x1::vector::append<u8>(&mut v4, v187);
                                            };
                                        } else {
                                            let v195 = 115;
                                            if (v8 == &v195) {
                                                if (v6 + 1 < v5 && *0x1::vector::borrow<u8>(&arg1, v6 + 1) == 115) {
                                                    let v196 = (arg0.second as u16);
                                                    let v197 = 48;
                                                    let v198 = if (v196 < 10) {
                                                        let v199 = 0x1::vector::empty<u8>();
                                                        let v200 = &mut v199;
                                                        0x1::vector::push_back<u8>(v200, (v197 as u8));
                                                        0x1::vector::push_back<u8>(v200, ((v196 + v197) as u8));
                                                        v199
                                                    } else if (v196 < 100) {
                                                        let v201 = 0x1::vector::empty<u8>();
                                                        let v202 = &mut v201;
                                                        0x1::vector::push_back<u8>(v202, ((v196 / 10 + v197) as u8));
                                                        0x1::vector::push_back<u8>(v202, ((v196 % 10 + v197) as u8));
                                                        v201
                                                    } else if (v196 < 1000) {
                                                        let v203 = 0x1::vector::empty<u8>();
                                                        let v204 = &mut v203;
                                                        0x1::vector::push_back<u8>(v204, ((v196 / 100 + v197) as u8));
                                                        0x1::vector::push_back<u8>(v204, ((v196 / 10 % 10 + v197) as u8));
                                                        0x1::vector::push_back<u8>(v204, ((v196 % 10 + v197) as u8));
                                                        v203
                                                    } else {
                                                        let v205 = 0x1::vector::empty<u8>();
                                                        let v206 = &mut v205;
                                                        0x1::vector::push_back<u8>(v206, ((v196 / 1000 + v197) as u8));
                                                        0x1::vector::push_back<u8>(v206, ((v196 / 100 % 10 + v197) as u8));
                                                        0x1::vector::push_back<u8>(v206, ((v196 / 10 % 10 + v197) as u8));
                                                        0x1::vector::push_back<u8>(v206, ((v196 % 10 + v197) as u8));
                                                        v205
                                                    };
                                                    0x1::vector::append<u8>(&mut v4, v198);
                                                    v6 = v6 + 1;
                                                } else {
                                                    let v207 = (arg0.second as u16);
                                                    let v208 = 48;
                                                    let v209 = if (v207 < 10) {
                                                        let v210 = 0x1::vector::empty<u8>();
                                                        0x1::vector::push_back<u8>(&mut v210, ((v207 + v208) as u8));
                                                        v210
                                                    } else if (v207 < 100) {
                                                        let v211 = 0x1::vector::empty<u8>();
                                                        let v212 = &mut v211;
                                                        0x1::vector::push_back<u8>(v212, ((v207 / 10 + v208) as u8));
                                                        0x1::vector::push_back<u8>(v212, ((v207 % 10 + v208) as u8));
                                                        v211
                                                    } else if (v207 < 1000) {
                                                        let v213 = 0x1::vector::empty<u8>();
                                                        let v214 = &mut v213;
                                                        0x1::vector::push_back<u8>(v214, ((v207 / 100 + v208) as u8));
                                                        0x1::vector::push_back<u8>(v214, ((v207 / 10 % 10 + v208) as u8));
                                                        0x1::vector::push_back<u8>(v214, ((v207 % 10 + v208) as u8));
                                                        v213
                                                    } else {
                                                        let v215 = 0x1::vector::empty<u8>();
                                                        let v216 = &mut v215;
                                                        0x1::vector::push_back<u8>(v216, ((v207 / 1000 + v208) as u8));
                                                        0x1::vector::push_back<u8>(v216, ((v207 / 100 % 10 + v208) as u8));
                                                        0x1::vector::push_back<u8>(v216, ((v207 / 10 % 10 + v208) as u8));
                                                        0x1::vector::push_back<u8>(v216, ((v207 % 10 + v208) as u8));
                                                        v215
                                                    };
                                                    0x1::vector::append<u8>(&mut v4, v209);
                                                };
                                            } else {
                                                let v217 = 83;
                                                if (v8 == &v217) {
                                                    let v218 = if (v6 + 2 < v5) {
                                                        if (*0x1::vector::borrow<u8>(&arg1, v6 + 1) == 83) {
                                                            *0x1::vector::borrow<u8>(&arg1, v6 + 2) == 83
                                                        } else {
                                                            false
                                                        }
                                                    } else {
                                                        false
                                                    };
                                                    assert!(v218, 9);
                                                    if (arg0.millisecond < 100) {
                                                        0x1::vector::push_back<u8>(&mut v4, 48);
                                                    };
                                                    let v219 = (arg0.millisecond as u16);
                                                    let v220 = 48;
                                                    let v221 = if (v219 < 10) {
                                                        let v222 = 0x1::vector::empty<u8>();
                                                        let v223 = &mut v222;
                                                        0x1::vector::push_back<u8>(v223, (v220 as u8));
                                                        0x1::vector::push_back<u8>(v223, ((v219 + v220) as u8));
                                                        v222
                                                    } else if (v219 < 100) {
                                                        let v224 = 0x1::vector::empty<u8>();
                                                        let v225 = &mut v224;
                                                        0x1::vector::push_back<u8>(v225, ((v219 / 10 + v220) as u8));
                                                        0x1::vector::push_back<u8>(v225, ((v219 % 10 + v220) as u8));
                                                        v224
                                                    } else if (v219 < 1000) {
                                                        let v226 = 0x1::vector::empty<u8>();
                                                        let v227 = &mut v226;
                                                        0x1::vector::push_back<u8>(v227, ((v219 / 100 + v220) as u8));
                                                        0x1::vector::push_back<u8>(v227, ((v219 / 10 % 10 + v220) as u8));
                                                        0x1::vector::push_back<u8>(v227, ((v219 % 10 + v220) as u8));
                                                        v226
                                                    } else {
                                                        let v228 = 0x1::vector::empty<u8>();
                                                        let v229 = &mut v228;
                                                        0x1::vector::push_back<u8>(v229, ((v219 / 1000 + v220) as u8));
                                                        0x1::vector::push_back<u8>(v229, ((v219 / 100 % 10 + v220) as u8));
                                                        0x1::vector::push_back<u8>(v229, ((v219 / 10 % 10 + v220) as u8));
                                                        0x1::vector::push_back<u8>(v229, ((v219 % 10 + v220) as u8));
                                                        v228
                                                    };
                                                    0x1::vector::append<u8>(&mut v4, v221);
                                                    v6 = v6 + 2;
                                                } else {
                                                    let v230 = 116;
                                                    if (v8 == &v230) {
                                                        assert!(v6 + 1 < v5 && *0x1::vector::borrow<u8>(&arg1, v6 + 1) == 116, 7);
                                                        let v231 = if (arg0.hour < 12) {
                                                            b"AM"
                                                        } else {
                                                            b"PM"
                                                        };
                                                        0x1::vector::append<u8>(&mut v4, v231);
                                                        v6 = v6 + 1;
                                                    } else {
                                                        let v232 = 90;
                                                        if (v8 == &v232 && arg0.timezone_offset_m != 720) {
                                                            let v233 = if (arg0.timezone_offset_m == 720) {
                                                                b"Z"
                                                            } else {
                                                                let v234 = b"";
                                                                let (v235, v236) = if (arg0.timezone_offset_m > 720) {
                                                                    0x1::vector::push_back<u8>(&mut v234, 43);
                                                                    ((arg0.timezone_offset_m - 720) / 60, (arg0.timezone_offset_m - 720) % 60)
                                                                } else {
                                                                    0x1::vector::push_back<u8>(&mut v234, 45);
                                                                    ((720 - arg0.timezone_offset_m) / 60, (720 - arg0.timezone_offset_m) % 60)
                                                                };
                                                                let v237 = (v235 as u16);
                                                                let v238 = 48;
                                                                let v239 = if (v237 < 10) {
                                                                    let v240 = 0x1::vector::empty<u8>();
                                                                    let v241 = &mut v240;
                                                                    0x1::vector::push_back<u8>(v241, (v238 as u8));
                                                                    0x1::vector::push_back<u8>(v241, ((v237 + v238) as u8));
                                                                    v240
                                                                } else if (v237 < 100) {
                                                                    let v242 = 0x1::vector::empty<u8>();
                                                                    let v243 = &mut v242;
                                                                    0x1::vector::push_back<u8>(v243, ((v237 / 10 + v238) as u8));
                                                                    0x1::vector::push_back<u8>(v243, ((v237 % 10 + v238) as u8));
                                                                    v242
                                                                } else if (v237 < 1000) {
                                                                    let v244 = 0x1::vector::empty<u8>();
                                                                    let v245 = &mut v244;
                                                                    0x1::vector::push_back<u8>(v245, ((v237 / 100 + v238) as u8));
                                                                    0x1::vector::push_back<u8>(v245, ((v237 / 10 % 10 + v238) as u8));
                                                                    0x1::vector::push_back<u8>(v245, ((v237 % 10 + v238) as u8));
                                                                    v244
                                                                } else {
                                                                    let v246 = 0x1::vector::empty<u8>();
                                                                    let v247 = &mut v246;
                                                                    0x1::vector::push_back<u8>(v247, ((v237 / 1000 + v238) as u8));
                                                                    0x1::vector::push_back<u8>(v247, ((v237 / 100 % 10 + v238) as u8));
                                                                    0x1::vector::push_back<u8>(v247, ((v237 / 10 % 10 + v238) as u8));
                                                                    0x1::vector::push_back<u8>(v247, ((v237 % 10 + v238) as u8));
                                                                    v246
                                                                };
                                                                0x1::vector::append<u8>(&mut v234, v239);
                                                                0x1::vector::push_back<u8>(&mut v234, 58);
                                                                let v248 = (v236 as u16);
                                                                let v249 = 48;
                                                                let v250 = if (v248 < 10) {
                                                                    let v251 = 0x1::vector::empty<u8>();
                                                                    let v252 = &mut v251;
                                                                    0x1::vector::push_back<u8>(v252, (v249 as u8));
                                                                    0x1::vector::push_back<u8>(v252, ((v248 + v249) as u8));
                                                                    v251
                                                                } else if (v248 < 100) {
                                                                    let v253 = 0x1::vector::empty<u8>();
                                                                    let v254 = &mut v253;
                                                                    0x1::vector::push_back<u8>(v254, ((v248 / 10 + v249) as u8));
                                                                    0x1::vector::push_back<u8>(v254, ((v248 % 10 + v249) as u8));
                                                                    v253
                                                                } else if (v248 < 1000) {
                                                                    let v255 = 0x1::vector::empty<u8>();
                                                                    let v256 = &mut v255;
                                                                    0x1::vector::push_back<u8>(v256, ((v248 / 100 + v249) as u8));
                                                                    0x1::vector::push_back<u8>(v256, ((v248 / 10 % 10 + v249) as u8));
                                                                    0x1::vector::push_back<u8>(v256, ((v248 % 10 + v249) as u8));
                                                                    v255
                                                                } else {
                                                                    let v257 = 0x1::vector::empty<u8>();
                                                                    let v258 = &mut v257;
                                                                    0x1::vector::push_back<u8>(v258, ((v248 / 1000 + v249) as u8));
                                                                    0x1::vector::push_back<u8>(v258, ((v248 / 100 % 10 + v249) as u8));
                                                                    0x1::vector::push_back<u8>(v258, ((v248 / 10 % 10 + v249) as u8));
                                                                    0x1::vector::push_back<u8>(v258, ((v248 % 10 + v249) as u8));
                                                                    v257
                                                                };
                                                                0x1::vector::append<u8>(&mut v234, v250);
                                                                v234
                                                            };
                                                            0x1::vector::append<u8>(&mut v4, v233);
                                                        } else {
                                                            let v259 = 39;
                                                            if (v8 == &v259) {
                                                                let v260 = b"";
                                                                let v261 = v6 + 1;
                                                                while (v261 < v5) {
                                                                    if (*0x1::vector::borrow<u8>(&arg1, v261) == 39) {
                                                                        v6 = v261;
                                                                        0x1::vector::append<u8>(&mut v4, v260);
                                                                        break
                                                                    };
                                                                    0x1::vector::push_back<u8>(&mut v260, *0x1::vector::borrow<u8>(&arg1, v261));
                                                                    v261 = v261 + 1;
                                                                };
                                                            } else {
                                                                let v262 = 0x1::vector::empty<u8>();
                                                                0x1::vector::push_back<u8>(&mut v262, *0x1::vector::borrow<u8>(&arg1, v6));
                                                                0x1::vector::append<u8>(&mut v4, v262);
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            v6 = v6 + 1;
        };
        0x1::string::utf8(v4)
    }

    public fun from_clock(arg0: &0x2::clock::Clock) : Date {
        new(0x2::clock::timestamp_ms(arg0))
    }

    public fun from_utc_string(arg0: 0x1::string::String) : Date {
        let v0 = vector[b"Sun", b"Mon", b"Tue", b"Wed", b"Thu", b"Fri", b"Sat"];
        let v1 = vector[b"Jan", b"Feb", b"Mar", b"Apr", b"May", b"Jun", b"Jul", b"Aug", b"Sep", b"Oct", b"Nov", b"Dec"];
        let v2 = vector[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        let v3 = 0x1::string::into_bytes(arg0);
        assert!(0x1::vector::length<u8>(&v3) == 29, 6);
        0x1::vector::reverse<u8>(&mut v3);
        let v4 = b"";
        let v5 = 0;
        while (v5 < 3) {
            0x1::vector::push_back<u8>(&mut v4, 0x1::vector::pop_back<u8>(&mut v3));
            v5 = v5 + 1;
        };
        let v6 = &v0;
        let v7 = 0;
        let v8;
        while (v7 < 0x1::vector::length<vector<u8>>(v6)) {
            if (0x1::vector::borrow<vector<u8>>(v6, v7) == &v4) {
                v8 = 0x1::option::some<u64>(v7);
                /* label 10 */
                if (0x1::option::is_some<u64>(&v8)) {
                    assert!(0x1::vector::pop_back<u8>(&mut v3) == 44, 2);
                    assert!(0x1::vector::pop_back<u8>(&mut v3) == 32, 3);
                    let v9 = b"";
                    let v10 = 0;
                    while (v10 < 2) {
                        0x1::vector::push_back<u8>(&mut v9, 0x1::vector::pop_back<u8>(&mut v3));
                        v10 = v10 + 1;
                    };
                    0x1::vector::reverse<u8>(&mut v9);
                    let v11 = 0x1::vector::length<u8>(&v9);
                    let v12 = 0;
                    let v13 = 0;
                    while (v13 < v11) {
                        let v14 = 0x1::vector::pop_back<u8>(&mut v9);
                        let v15 = &v14;
                        assert!(*v15 >= 48 && *v15 <= 57, 13906835226610368511);
                        v12 = v12 + ((v14 as u16) - 48) * 0x1::u16::pow(10, ((v11 - 1 - v13) as u8));
                        v13 = v13 + 1;
                    };
                    let v16 = (v12 as u8);
                    assert!(0x1::vector::pop_back<u8>(&mut v3) == 32, 3);
                    let v17 = b"";
                    let v18 = 0;
                    while (v18 < 3) {
                        0x1::vector::push_back<u8>(&mut v17, 0x1::vector::pop_back<u8>(&mut v3));
                        v18 = v18 + 1;
                    };
                    let v19 = &v1;
                    let v20 = 0;
                    let v21;
                    while (v20 < 0x1::vector::length<vector<u8>>(v19)) {
                        if (0x1::vector::borrow<vector<u8>>(v19, v20) == &v17) {
                            v21 = 0x1::option::some<u64>(v20);
                            /* label 35 */
                            if (0x1::option::is_some<u64>(&v21)) {
                                let v22 = (0x1::option::destroy_some<u64>(v21) as u8);
                                assert!(0x1::vector::pop_back<u8>(&mut v3) == 32, 3);
                                let v23 = b"";
                                let v24 = 0;
                                while (v24 < 4) {
                                    0x1::vector::push_back<u8>(&mut v23, 0x1::vector::pop_back<u8>(&mut v3));
                                    v24 = v24 + 1;
                                };
                                0x1::vector::reverse<u8>(&mut v23);
                                let v25 = 0x1::vector::length<u8>(&v23);
                                let v26 = 0;
                                let v27 = 0;
                                while (v27 < v25) {
                                    let v28 = 0x1::vector::pop_back<u8>(&mut v23);
                                    let v29 = &v28;
                                    assert!(*v29 >= 48 && *v29 <= 57, 13906835256675139583);
                                    v26 = v26 + ((v28 as u16) - 48) * 0x1::u16::pow(10, ((v25 - 1 - v27) as u8));
                                    v27 = v27 + 1;
                                };
                                assert!(0x1::vector::pop_back<u8>(&mut v3) == 32, 3);
                                let v30 = b"";
                                let v31 = 0;
                                while (v31 < 2) {
                                    0x1::vector::push_back<u8>(&mut v30, 0x1::vector::pop_back<u8>(&mut v3));
                                    v31 = v31 + 1;
                                };
                                0x1::vector::reverse<u8>(&mut v30);
                                let v32 = 0x1::vector::length<u8>(&v30);
                                let v33 = 0;
                                let v34 = 0;
                                while (v34 < v32) {
                                    let v35 = 0x1::vector::pop_back<u8>(&mut v30);
                                    let v36 = &v35;
                                    assert!(*v36 >= 48 && *v36 <= 57, 13906835269560041471);
                                    v33 = v33 + ((v35 as u16) - 48) * 0x1::u16::pow(10, ((v32 - 1 - v34) as u8));
                                    v34 = v34 + 1;
                                };
                                let v37 = (v33 as u8);
                                assert!(0x1::vector::pop_back<u8>(&mut v3) == 58, 4);
                                let v38 = b"";
                                let v39 = 0;
                                while (v39 < 2) {
                                    0x1::vector::push_back<u8>(&mut v38, 0x1::vector::pop_back<u8>(&mut v3));
                                    v39 = v39 + 1;
                                };
                                0x1::vector::reverse<u8>(&mut v38);
                                let v40 = 0x1::vector::length<u8>(&v38);
                                let v41 = 0;
                                let v42 = 0;
                                while (v42 < v40) {
                                    let v43 = 0x1::vector::pop_back<u8>(&mut v38);
                                    let v44 = &v43;
                                    assert!(*v44 >= 48 && *v44 <= 57, 13906835282444943359);
                                    v41 = v41 + ((v43 as u16) - 48) * 0x1::u16::pow(10, ((v40 - 1 - v42) as u8));
                                    v42 = v42 + 1;
                                };
                                let v45 = (v41 as u8);
                                assert!(0x1::vector::pop_back<u8>(&mut v3) == 58, 4);
                                let v46 = b"";
                                let v47 = 0;
                                while (v47 < 2) {
                                    0x1::vector::push_back<u8>(&mut v46, 0x1::vector::pop_back<u8>(&mut v3));
                                    v47 = v47 + 1;
                                };
                                0x1::vector::reverse<u8>(&mut v46);
                                let v48 = 0x1::vector::length<u8>(&v46);
                                let v49 = 0;
                                let v50 = 0;
                                while (v50 < v48) {
                                    let v51 = 0x1::vector::pop_back<u8>(&mut v46);
                                    let v52 = &v51;
                                    assert!(*v52 >= 48 && *v52 <= 57, 13906835295329845247);
                                    v49 = v49 + ((v51 as u16) - 48) * 0x1::u16::pow(10, ((v48 - 1 - v50) as u8));
                                    v50 = v50 + 1;
                                };
                                let v53 = (v49 as u8);
                                assert!(0x1::vector::pop_back<u8>(&mut v3) == 32, 3);
                                let v54 = b"";
                                let v55 = 0;
                                while (v55 < 3) {
                                    0x1::vector::push_back<u8>(&mut v54, 0x1::vector::pop_back<u8>(&mut v3));
                                    v55 = v55 + 1;
                                };
                                assert!(v54 == b"GMT", 5);
                                let v56 = 0;
                                let v57 = 1970;
                                while (v57 < v26) {
                                    let v58 = v56 + 365;
                                    v56 = v58;
                                    if (v57 % 4 == 0 && v57 % 100 != 0 || v57 % 400 == 0) {
                                        v56 = v58 + 1;
                                    };
                                    v57 = v57 + 1;
                                };
                                let v59 = 0;
                                while (v59 < v22) {
                                    let v60 = v56 + *0x1::vector::borrow<u64>(&v2, (v59 as u64));
                                    v56 = v60;
                                    if (v59 == 1 && (v26 % 4 == 0 && v26 % 100 != 0 || v26 % 400 == 0)) {
                                        v56 = v60 + 1;
                                    };
                                    v59 = v59 + 1;
                                };
                                return Date{
                                    year              : v26,
                                    month             : v22,
                                    day               : v16,
                                    day_of_week       : (0x1::option::destroy_some<u64>(v8) as u8),
                                    hour              : v37,
                                    minute            : v45,
                                    second            : v53,
                                    millisecond       : 0,
                                    timezone_offset_m : 0,
                                    timestamp_ms      : ((v56 + (v16 as u64) - 1) * 24 * 60 * 60 + (v37 as u64) * 60 * 60 + (v45 as u64) * 60 + (v53 as u64)) * 1000,
                                }
                            } else {
                                0x1::option::destroy_none<u64>(v21);
                                abort 0
                            };
                        };
                        v20 = v20 + 1;
                    };
                    v21 = 0x1::option::none<u64>();
                    /* goto 35 */
                } else {
                    0x1::option::destroy_none<u64>(v8);
                    abort 1
                };
            } else {
                v7 = v7 + 1;
            };
        };
        v8 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    public fun hour(arg0: &Date) : u8 {
        arg0.hour
    }

    public fun minute(arg0: &Date) : u8 {
        arg0.minute
    }

    public fun month(arg0: &Date) : u8 {
        arg0.month
    }

    public fun new(arg0: u64) : Date {
        let v0 = arg0 / 1000;
        let v1 = v0 / 60;
        let v2 = v0 / 86400;
        let v3 = 1970;
        loop {
            let v4 = if (v3 % 4 == 0 && v3 % 100 != 0 || v3 % 400 == 0) {
                366
            } else {
                365
            };
            if (v2 < v4) {
                break
            };
            v3 = v3 + 1;
            v2 = v2 - v4;
        };
        let v5 = 0;
        let v6 = vector[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        loop {
            let v7 = if ((v3 % 4 == 0 && v3 % 100 != 0 || v3 % 400 == 0) && v5 == 1) {
                29
            } else {
                *0x1::vector::borrow<u64>(&v6, v5)
            };
            if (v2 < v7) {
                break
            };
            v5 = v5 + 1;
            v2 = v2 - v7;
        };
        Date{
            year              : v3,
            month             : (v5 as u8),
            day               : ((v2 + 1) as u8),
            day_of_week       : (((v0 / 86400 + 4) % 7) as u8),
            hour              : ((v1 / 60 % 24) as u8),
            minute            : ((v1 % 60) as u8),
            second            : ((v0 % 60) as u8),
            millisecond       : ((arg0 % 1000) as u16),
            timezone_offset_m : 720,
            timestamp_ms      : arg0,
        }
    }

    public fun second(arg0: &Date) : u8 {
        arg0.second
    }

    public fun to_iso_string(arg0: &Date) : 0x1::string::String {
        let v0 = *arg0;
        let v1 = (v0.timezone_offset_m as u64);
        if (v1 != 720) {
            if (v1 > 720) {
                v0.timestamp_ms = v0.timestamp_ms + (v1 - 720) * 60 * 1000;
                let v2 = v0.timestamp_ms;
                v0 = new(v2);
                v0.timezone_offset_m = (v1 as u16);
            } else {
                v0.timestamp_ms = v0.timestamp_ms - (720 - v1) * 60 * 1000;
                let v3 = v0.timestamp_ms;
                v0 = new(v3);
                v0.timezone_offset_m = (v1 as u16);
            };
        };
        let v4 = b"";
        let v5 = (v0.year as u16);
        let v6 = 48;
        let v7 = if (v5 < 10) {
            let v8 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v8, ((v5 + v6) as u8));
            v8
        } else if (v5 < 100) {
            let v9 = 0x1::vector::empty<u8>();
            let v10 = &mut v9;
            0x1::vector::push_back<u8>(v10, ((v5 / 10 + v6) as u8));
            0x1::vector::push_back<u8>(v10, ((v5 % 10 + v6) as u8));
            v9
        } else if (v5 < 1000) {
            let v11 = 0x1::vector::empty<u8>();
            let v12 = &mut v11;
            0x1::vector::push_back<u8>(v12, ((v5 / 100 + v6) as u8));
            0x1::vector::push_back<u8>(v12, ((v5 / 10 % 10 + v6) as u8));
            0x1::vector::push_back<u8>(v12, ((v5 % 10 + v6) as u8));
            v11
        } else {
            let v13 = 0x1::vector::empty<u8>();
            let v14 = &mut v13;
            0x1::vector::push_back<u8>(v14, ((v5 / 1000 + v6) as u8));
            0x1::vector::push_back<u8>(v14, ((v5 / 100 % 10 + v6) as u8));
            0x1::vector::push_back<u8>(v14, ((v5 / 10 % 10 + v6) as u8));
            0x1::vector::push_back<u8>(v14, ((v5 % 10 + v6) as u8));
            v13
        };
        0x1::vector::append<u8>(&mut v4, v7);
        0x1::vector::push_back<u8>(&mut v4, 45);
        let v15 = ((v0.month + 1) as u16);
        let v16 = 48;
        let v17 = if (v15 < 10) {
            let v18 = 0x1::vector::empty<u8>();
            let v19 = &mut v18;
            0x1::vector::push_back<u8>(v19, (v16 as u8));
            0x1::vector::push_back<u8>(v19, ((v15 + v16) as u8));
            v18
        } else if (v15 < 100) {
            let v20 = 0x1::vector::empty<u8>();
            let v21 = &mut v20;
            0x1::vector::push_back<u8>(v21, ((v15 / 10 + v16) as u8));
            0x1::vector::push_back<u8>(v21, ((v15 % 10 + v16) as u8));
            v20
        } else if (v15 < 1000) {
            let v22 = 0x1::vector::empty<u8>();
            let v23 = &mut v22;
            0x1::vector::push_back<u8>(v23, ((v15 / 100 + v16) as u8));
            0x1::vector::push_back<u8>(v23, ((v15 / 10 % 10 + v16) as u8));
            0x1::vector::push_back<u8>(v23, ((v15 % 10 + v16) as u8));
            v22
        } else {
            let v24 = 0x1::vector::empty<u8>();
            let v25 = &mut v24;
            0x1::vector::push_back<u8>(v25, ((v15 / 1000 + v16) as u8));
            0x1::vector::push_back<u8>(v25, ((v15 / 100 % 10 + v16) as u8));
            0x1::vector::push_back<u8>(v25, ((v15 / 10 % 10 + v16) as u8));
            0x1::vector::push_back<u8>(v25, ((v15 % 10 + v16) as u8));
            v24
        };
        0x1::vector::append<u8>(&mut v4, v17);
        0x1::vector::push_back<u8>(&mut v4, 45);
        let v26 = (v0.day as u16);
        let v27 = 48;
        let v28 = if (v26 < 10) {
            let v29 = 0x1::vector::empty<u8>();
            let v30 = &mut v29;
            0x1::vector::push_back<u8>(v30, (v27 as u8));
            0x1::vector::push_back<u8>(v30, ((v26 + v27) as u8));
            v29
        } else if (v26 < 100) {
            let v31 = 0x1::vector::empty<u8>();
            let v32 = &mut v31;
            0x1::vector::push_back<u8>(v32, ((v26 / 10 + v27) as u8));
            0x1::vector::push_back<u8>(v32, ((v26 % 10 + v27) as u8));
            v31
        } else if (v26 < 1000) {
            let v33 = 0x1::vector::empty<u8>();
            let v34 = &mut v33;
            0x1::vector::push_back<u8>(v34, ((v26 / 100 + v27) as u8));
            0x1::vector::push_back<u8>(v34, ((v26 / 10 % 10 + v27) as u8));
            0x1::vector::push_back<u8>(v34, ((v26 % 10 + v27) as u8));
            v33
        } else {
            let v35 = 0x1::vector::empty<u8>();
            let v36 = &mut v35;
            0x1::vector::push_back<u8>(v36, ((v26 / 1000 + v27) as u8));
            0x1::vector::push_back<u8>(v36, ((v26 / 100 % 10 + v27) as u8));
            0x1::vector::push_back<u8>(v36, ((v26 / 10 % 10 + v27) as u8));
            0x1::vector::push_back<u8>(v36, ((v26 % 10 + v27) as u8));
            v35
        };
        0x1::vector::append<u8>(&mut v4, v28);
        0x1::vector::push_back<u8>(&mut v4, 84);
        let v37 = (v0.hour as u16);
        let v38 = 48;
        let v39 = if (v37 < 10) {
            let v40 = 0x1::vector::empty<u8>();
            let v41 = &mut v40;
            0x1::vector::push_back<u8>(v41, (v38 as u8));
            0x1::vector::push_back<u8>(v41, ((v37 + v38) as u8));
            v40
        } else if (v37 < 100) {
            let v42 = 0x1::vector::empty<u8>();
            let v43 = &mut v42;
            0x1::vector::push_back<u8>(v43, ((v37 / 10 + v38) as u8));
            0x1::vector::push_back<u8>(v43, ((v37 % 10 + v38) as u8));
            v42
        } else if (v37 < 1000) {
            let v44 = 0x1::vector::empty<u8>();
            let v45 = &mut v44;
            0x1::vector::push_back<u8>(v45, ((v37 / 100 + v38) as u8));
            0x1::vector::push_back<u8>(v45, ((v37 / 10 % 10 + v38) as u8));
            0x1::vector::push_back<u8>(v45, ((v37 % 10 + v38) as u8));
            v44
        } else {
            let v46 = 0x1::vector::empty<u8>();
            let v47 = &mut v46;
            0x1::vector::push_back<u8>(v47, ((v37 / 1000 + v38) as u8));
            0x1::vector::push_back<u8>(v47, ((v37 / 100 % 10 + v38) as u8));
            0x1::vector::push_back<u8>(v47, ((v37 / 10 % 10 + v38) as u8));
            0x1::vector::push_back<u8>(v47, ((v37 % 10 + v38) as u8));
            v46
        };
        0x1::vector::append<u8>(&mut v4, v39);
        0x1::vector::push_back<u8>(&mut v4, 58);
        let v48 = (v0.minute as u16);
        let v49 = 48;
        let v50 = if (v48 < 10) {
            let v51 = 0x1::vector::empty<u8>();
            let v52 = &mut v51;
            0x1::vector::push_back<u8>(v52, (v49 as u8));
            0x1::vector::push_back<u8>(v52, ((v48 + v49) as u8));
            v51
        } else if (v48 < 100) {
            let v53 = 0x1::vector::empty<u8>();
            let v54 = &mut v53;
            0x1::vector::push_back<u8>(v54, ((v48 / 10 + v49) as u8));
            0x1::vector::push_back<u8>(v54, ((v48 % 10 + v49) as u8));
            v53
        } else if (v48 < 1000) {
            let v55 = 0x1::vector::empty<u8>();
            let v56 = &mut v55;
            0x1::vector::push_back<u8>(v56, ((v48 / 100 + v49) as u8));
            0x1::vector::push_back<u8>(v56, ((v48 / 10 % 10 + v49) as u8));
            0x1::vector::push_back<u8>(v56, ((v48 % 10 + v49) as u8));
            v55
        } else {
            let v57 = 0x1::vector::empty<u8>();
            let v58 = &mut v57;
            0x1::vector::push_back<u8>(v58, ((v48 / 1000 + v49) as u8));
            0x1::vector::push_back<u8>(v58, ((v48 / 100 % 10 + v49) as u8));
            0x1::vector::push_back<u8>(v58, ((v48 / 10 % 10 + v49) as u8));
            0x1::vector::push_back<u8>(v58, ((v48 % 10 + v49) as u8));
            v57
        };
        0x1::vector::append<u8>(&mut v4, v50);
        0x1::vector::push_back<u8>(&mut v4, 58);
        let v59 = (v0.second as u16);
        let v60 = 48;
        let v61 = if (v59 < 10) {
            let v62 = 0x1::vector::empty<u8>();
            let v63 = &mut v62;
            0x1::vector::push_back<u8>(v63, (v60 as u8));
            0x1::vector::push_back<u8>(v63, ((v59 + v60) as u8));
            v62
        } else if (v59 < 100) {
            let v64 = 0x1::vector::empty<u8>();
            let v65 = &mut v64;
            0x1::vector::push_back<u8>(v65, ((v59 / 10 + v60) as u8));
            0x1::vector::push_back<u8>(v65, ((v59 % 10 + v60) as u8));
            v64
        } else if (v59 < 1000) {
            let v66 = 0x1::vector::empty<u8>();
            let v67 = &mut v66;
            0x1::vector::push_back<u8>(v67, ((v59 / 100 + v60) as u8));
            0x1::vector::push_back<u8>(v67, ((v59 / 10 % 10 + v60) as u8));
            0x1::vector::push_back<u8>(v67, ((v59 % 10 + v60) as u8));
            v66
        } else {
            let v68 = 0x1::vector::empty<u8>();
            let v69 = &mut v68;
            0x1::vector::push_back<u8>(v69, ((v59 / 1000 + v60) as u8));
            0x1::vector::push_back<u8>(v69, ((v59 / 100 % 10 + v60) as u8));
            0x1::vector::push_back<u8>(v69, ((v59 / 10 % 10 + v60) as u8));
            0x1::vector::push_back<u8>(v69, ((v59 % 10 + v60) as u8));
            v68
        };
        0x1::vector::append<u8>(&mut v4, v61);
        0x1::vector::push_back<u8>(&mut v4, 46);
        if (v0.millisecond < 100) {
            0x1::vector::push_back<u8>(&mut v4, 48);
        };
        let v70 = (v0.millisecond as u16);
        let v71 = 48;
        let v72 = if (v70 < 10) {
            let v73 = 0x1::vector::empty<u8>();
            let v74 = &mut v73;
            0x1::vector::push_back<u8>(v74, (v71 as u8));
            0x1::vector::push_back<u8>(v74, ((v70 + v71) as u8));
            v73
        } else if (v70 < 100) {
            let v75 = 0x1::vector::empty<u8>();
            let v76 = &mut v75;
            0x1::vector::push_back<u8>(v76, ((v70 / 10 + v71) as u8));
            0x1::vector::push_back<u8>(v76, ((v70 % 10 + v71) as u8));
            v75
        } else if (v70 < 1000) {
            let v77 = 0x1::vector::empty<u8>();
            let v78 = &mut v77;
            0x1::vector::push_back<u8>(v78, ((v70 / 100 + v71) as u8));
            0x1::vector::push_back<u8>(v78, ((v70 / 10 % 10 + v71) as u8));
            0x1::vector::push_back<u8>(v78, ((v70 % 10 + v71) as u8));
            v77
        } else {
            let v79 = 0x1::vector::empty<u8>();
            let v80 = &mut v79;
            0x1::vector::push_back<u8>(v80, ((v70 / 1000 + v71) as u8));
            0x1::vector::push_back<u8>(v80, ((v70 / 100 % 10 + v71) as u8));
            0x1::vector::push_back<u8>(v80, ((v70 / 10 % 10 + v71) as u8));
            0x1::vector::push_back<u8>(v80, ((v70 % 10 + v71) as u8));
            v79
        };
        0x1::vector::append<u8>(&mut v4, v72);
        let v81 = if (v0.timezone_offset_m == 720) {
            b"Z"
        } else {
            let v82 = b"";
            let (v83, v84) = if (v0.timezone_offset_m > 720) {
                0x1::vector::push_back<u8>(&mut v82, 43);
                ((v0.timezone_offset_m - 720) / 60, (v0.timezone_offset_m - 720) % 60)
            } else {
                0x1::vector::push_back<u8>(&mut v82, 45);
                ((720 - v0.timezone_offset_m) / 60, (720 - v0.timezone_offset_m) % 60)
            };
            let v85 = (v83 as u16);
            let v86 = 48;
            let v87 = if (v85 < 10) {
                let v88 = 0x1::vector::empty<u8>();
                let v89 = &mut v88;
                0x1::vector::push_back<u8>(v89, (v86 as u8));
                0x1::vector::push_back<u8>(v89, ((v85 + v86) as u8));
                v88
            } else if (v85 < 100) {
                let v90 = 0x1::vector::empty<u8>();
                let v91 = &mut v90;
                0x1::vector::push_back<u8>(v91, ((v85 / 10 + v86) as u8));
                0x1::vector::push_back<u8>(v91, ((v85 % 10 + v86) as u8));
                v90
            } else if (v85 < 1000) {
                let v92 = 0x1::vector::empty<u8>();
                let v93 = &mut v92;
                0x1::vector::push_back<u8>(v93, ((v85 / 100 + v86) as u8));
                0x1::vector::push_back<u8>(v93, ((v85 / 10 % 10 + v86) as u8));
                0x1::vector::push_back<u8>(v93, ((v85 % 10 + v86) as u8));
                v92
            } else {
                let v94 = 0x1::vector::empty<u8>();
                let v95 = &mut v94;
                0x1::vector::push_back<u8>(v95, ((v85 / 1000 + v86) as u8));
                0x1::vector::push_back<u8>(v95, ((v85 / 100 % 10 + v86) as u8));
                0x1::vector::push_back<u8>(v95, ((v85 / 10 % 10 + v86) as u8));
                0x1::vector::push_back<u8>(v95, ((v85 % 10 + v86) as u8));
                v94
            };
            0x1::vector::append<u8>(&mut v82, v87);
            0x1::vector::push_back<u8>(&mut v82, 58);
            let v96 = (v84 as u16);
            let v97 = 48;
            let v98 = if (v96 < 10) {
                let v99 = 0x1::vector::empty<u8>();
                let v100 = &mut v99;
                0x1::vector::push_back<u8>(v100, (v97 as u8));
                0x1::vector::push_back<u8>(v100, ((v96 + v97) as u8));
                v99
            } else if (v96 < 100) {
                let v101 = 0x1::vector::empty<u8>();
                let v102 = &mut v101;
                0x1::vector::push_back<u8>(v102, ((v96 / 10 + v97) as u8));
                0x1::vector::push_back<u8>(v102, ((v96 % 10 + v97) as u8));
                v101
            } else if (v96 < 1000) {
                let v103 = 0x1::vector::empty<u8>();
                let v104 = &mut v103;
                0x1::vector::push_back<u8>(v104, ((v96 / 100 + v97) as u8));
                0x1::vector::push_back<u8>(v104, ((v96 / 10 % 10 + v97) as u8));
                0x1::vector::push_back<u8>(v104, ((v96 % 10 + v97) as u8));
                v103
            } else {
                let v105 = 0x1::vector::empty<u8>();
                let v106 = &mut v105;
                0x1::vector::push_back<u8>(v106, ((v96 / 1000 + v97) as u8));
                0x1::vector::push_back<u8>(v106, ((v96 / 100 % 10 + v97) as u8));
                0x1::vector::push_back<u8>(v106, ((v96 / 10 % 10 + v97) as u8));
                0x1::vector::push_back<u8>(v106, ((v96 % 10 + v97) as u8));
                v105
            };
            0x1::vector::append<u8>(&mut v82, v98);
            v82
        };
        0x1::vector::append<u8>(&mut v4, v81);
        0x1::string::utf8(v4)
    }

    public fun to_utc_string(arg0: &Date) : 0x1::string::String {
        let v0 = vector[b"Jan", b"Feb", b"Mar", b"Apr", b"May", b"Jun", b"Jul", b"Aug", b"Sep", b"Oct", b"Nov", b"Dec"];
        let v1 = vector[b"Sun", b"Mon", b"Tue", b"Wed", b"Thu", b"Fri", b"Sat"];
        let v2 = b"";
        0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&v1, (arg0.day_of_week as u64)));
        0x1::vector::push_back<u8>(&mut v2, 44);
        0x1::vector::push_back<u8>(&mut v2, 32);
        let v3 = (arg0.day as u16);
        let v4 = 48;
        let v5 = if (v3 < 10) {
            let v6 = 0x1::vector::empty<u8>();
            let v7 = &mut v6;
            0x1::vector::push_back<u8>(v7, (v4 as u8));
            0x1::vector::push_back<u8>(v7, ((v3 + v4) as u8));
            v6
        } else if (v3 < 100) {
            let v8 = 0x1::vector::empty<u8>();
            let v9 = &mut v8;
            0x1::vector::push_back<u8>(v9, ((v3 / 10 + v4) as u8));
            0x1::vector::push_back<u8>(v9, ((v3 % 10 + v4) as u8));
            v8
        } else if (v3 < 1000) {
            let v10 = 0x1::vector::empty<u8>();
            let v11 = &mut v10;
            0x1::vector::push_back<u8>(v11, ((v3 / 100 + v4) as u8));
            0x1::vector::push_back<u8>(v11, ((v3 / 10 % 10 + v4) as u8));
            0x1::vector::push_back<u8>(v11, ((v3 % 10 + v4) as u8));
            v10
        } else {
            let v12 = 0x1::vector::empty<u8>();
            let v13 = &mut v12;
            0x1::vector::push_back<u8>(v13, ((v3 / 1000 + v4) as u8));
            0x1::vector::push_back<u8>(v13, ((v3 / 100 % 10 + v4) as u8));
            0x1::vector::push_back<u8>(v13, ((v3 / 10 % 10 + v4) as u8));
            0x1::vector::push_back<u8>(v13, ((v3 % 10 + v4) as u8));
            v12
        };
        0x1::vector::append<u8>(&mut v2, v5);
        0x1::vector::push_back<u8>(&mut v2, 32);
        0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&v0, (arg0.month as u64)));
        0x1::vector::push_back<u8>(&mut v2, 32);
        let v14 = (arg0.year as u16);
        let v15 = 48;
        let v16 = if (v14 < 10) {
            let v17 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v17, ((v14 + v15) as u8));
            v17
        } else if (v14 < 100) {
            let v18 = 0x1::vector::empty<u8>();
            let v19 = &mut v18;
            0x1::vector::push_back<u8>(v19, ((v14 / 10 + v15) as u8));
            0x1::vector::push_back<u8>(v19, ((v14 % 10 + v15) as u8));
            v18
        } else if (v14 < 1000) {
            let v20 = 0x1::vector::empty<u8>();
            let v21 = &mut v20;
            0x1::vector::push_back<u8>(v21, ((v14 / 100 + v15) as u8));
            0x1::vector::push_back<u8>(v21, ((v14 / 10 % 10 + v15) as u8));
            0x1::vector::push_back<u8>(v21, ((v14 % 10 + v15) as u8));
            v20
        } else {
            let v22 = 0x1::vector::empty<u8>();
            let v23 = &mut v22;
            0x1::vector::push_back<u8>(v23, ((v14 / 1000 + v15) as u8));
            0x1::vector::push_back<u8>(v23, ((v14 / 100 % 10 + v15) as u8));
            0x1::vector::push_back<u8>(v23, ((v14 / 10 % 10 + v15) as u8));
            0x1::vector::push_back<u8>(v23, ((v14 % 10 + v15) as u8));
            v22
        };
        0x1::vector::append<u8>(&mut v2, v16);
        0x1::vector::push_back<u8>(&mut v2, 32);
        let v24 = (arg0.hour as u16);
        let v25 = 48;
        let v26 = if (v24 < 10) {
            let v27 = 0x1::vector::empty<u8>();
            let v28 = &mut v27;
            0x1::vector::push_back<u8>(v28, (v25 as u8));
            0x1::vector::push_back<u8>(v28, ((v24 + v25) as u8));
            v27
        } else if (v24 < 100) {
            let v29 = 0x1::vector::empty<u8>();
            let v30 = &mut v29;
            0x1::vector::push_back<u8>(v30, ((v24 / 10 + v25) as u8));
            0x1::vector::push_back<u8>(v30, ((v24 % 10 + v25) as u8));
            v29
        } else if (v24 < 1000) {
            let v31 = 0x1::vector::empty<u8>();
            let v32 = &mut v31;
            0x1::vector::push_back<u8>(v32, ((v24 / 100 + v25) as u8));
            0x1::vector::push_back<u8>(v32, ((v24 / 10 % 10 + v25) as u8));
            0x1::vector::push_back<u8>(v32, ((v24 % 10 + v25) as u8));
            v31
        } else {
            let v33 = 0x1::vector::empty<u8>();
            let v34 = &mut v33;
            0x1::vector::push_back<u8>(v34, ((v24 / 1000 + v25) as u8));
            0x1::vector::push_back<u8>(v34, ((v24 / 100 % 10 + v25) as u8));
            0x1::vector::push_back<u8>(v34, ((v24 / 10 % 10 + v25) as u8));
            0x1::vector::push_back<u8>(v34, ((v24 % 10 + v25) as u8));
            v33
        };
        0x1::vector::append<u8>(&mut v2, v26);
        0x1::vector::push_back<u8>(&mut v2, 58);
        let v35 = (arg0.minute as u16);
        let v36 = 48;
        let v37 = if (v35 < 10) {
            let v38 = 0x1::vector::empty<u8>();
            let v39 = &mut v38;
            0x1::vector::push_back<u8>(v39, (v36 as u8));
            0x1::vector::push_back<u8>(v39, ((v35 + v36) as u8));
            v38
        } else if (v35 < 100) {
            let v40 = 0x1::vector::empty<u8>();
            let v41 = &mut v40;
            0x1::vector::push_back<u8>(v41, ((v35 / 10 + v36) as u8));
            0x1::vector::push_back<u8>(v41, ((v35 % 10 + v36) as u8));
            v40
        } else if (v35 < 1000) {
            let v42 = 0x1::vector::empty<u8>();
            let v43 = &mut v42;
            0x1::vector::push_back<u8>(v43, ((v35 / 100 + v36) as u8));
            0x1::vector::push_back<u8>(v43, ((v35 / 10 % 10 + v36) as u8));
            0x1::vector::push_back<u8>(v43, ((v35 % 10 + v36) as u8));
            v42
        } else {
            let v44 = 0x1::vector::empty<u8>();
            let v45 = &mut v44;
            0x1::vector::push_back<u8>(v45, ((v35 / 1000 + v36) as u8));
            0x1::vector::push_back<u8>(v45, ((v35 / 100 % 10 + v36) as u8));
            0x1::vector::push_back<u8>(v45, ((v35 / 10 % 10 + v36) as u8));
            0x1::vector::push_back<u8>(v45, ((v35 % 10 + v36) as u8));
            v44
        };
        0x1::vector::append<u8>(&mut v2, v37);
        0x1::vector::push_back<u8>(&mut v2, 58);
        let v46 = (arg0.second as u16);
        let v47 = 48;
        let v48 = if (v46 < 10) {
            let v49 = 0x1::vector::empty<u8>();
            let v50 = &mut v49;
            0x1::vector::push_back<u8>(v50, (v47 as u8));
            0x1::vector::push_back<u8>(v50, ((v46 + v47) as u8));
            v49
        } else if (v46 < 100) {
            let v51 = 0x1::vector::empty<u8>();
            let v52 = &mut v51;
            0x1::vector::push_back<u8>(v52, ((v46 / 10 + v47) as u8));
            0x1::vector::push_back<u8>(v52, ((v46 % 10 + v47) as u8));
            v51
        } else if (v46 < 1000) {
            let v53 = 0x1::vector::empty<u8>();
            let v54 = &mut v53;
            0x1::vector::push_back<u8>(v54, ((v46 / 100 + v47) as u8));
            0x1::vector::push_back<u8>(v54, ((v46 / 10 % 10 + v47) as u8));
            0x1::vector::push_back<u8>(v54, ((v46 % 10 + v47) as u8));
            v53
        } else {
            let v55 = 0x1::vector::empty<u8>();
            let v56 = &mut v55;
            0x1::vector::push_back<u8>(v56, ((v46 / 1000 + v47) as u8));
            0x1::vector::push_back<u8>(v56, ((v46 / 100 % 10 + v47) as u8));
            0x1::vector::push_back<u8>(v56, ((v46 / 10 % 10 + v47) as u8));
            0x1::vector::push_back<u8>(v56, ((v46 % 10 + v47) as u8));
            v55
        };
        0x1::vector::append<u8>(&mut v2, v48);
        0x1::vector::append<u8>(&mut v2, b" GMT");
        0x1::string::utf8(v2)
    }

    public fun year(arg0: &Date) : u16 {
        arg0.year
    }

    // decompiled from Move bytecode v6
}

