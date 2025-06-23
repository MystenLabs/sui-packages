module 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint {
    struct Phase has store {
        start: u64,
        end: u64,
        list: 0x2::table::Table<address, bool>,
        minted_list: 0x2::table::Table<address, bool>,
        mint_count: u64,
    }

    struct BurnPhase has store {
        start: u64,
        end: u64,
        mint_count: u64,
    }

    struct PublicPhase has store {
        start: u64,
        end: u64,
        non_tablet_minted_list: 0x2::table::Table<address, u64>,
        tablet_minted_list: 0x2::table::Table<address, u64>,
        tablet_mint_count: u64,
        non_tablet_mint_count: u64,
    }

    struct Mint has store, key {
        id: 0x2::object::UID,
        nfts: 0x2::table_vec::TableVec<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Data>,
        phases: vector<Phase>,
        burn_phase: BurnPhase,
        public_phase: PublicPhase,
        receiver_address: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<Phase>();
        let v1 = 0;
        while (v1 < 2) {
            let v2 = &v1;
            let v3 = if (*v2 == 0) {
                1747947600000
            } else if (*v2 == 1) {
                1747949400000
            } else if (*v2 == 2) {
                1747947600000
            } else if (*v2 == 31) {
                1747951200000
            } else if (*v2 == 32) {
                1747951200000
            } else {
                0
            };
            let v4 = &v1;
            let v5 = if (*v4 == 0) {
                1747951200000
            } else if (*v4 == 1) {
                1747951200000
            } else if (*v4 == 2) {
                1748124000000
            } else if (*v4 == 31) {
                1748124000000
            } else if (*v4 == 32) {
                1748124000000
            } else {
                0
            };
            let v6 = &v1;
            let v7 = if (*v6 == 0) {
                3
            } else if (*v6 == 1) {
                2
            } else if (*v6 == 2) {
                2
            } else if (*v6 == 31) {
                10
            } else if (*v6 == 32) {
                5
            } else {
                0
            };
            let v8 = Phase{
                start       : v3,
                end         : v5,
                list        : 0x2::table::new<address, bool>(arg0),
                minted_list : 0x2::table::new<address, bool>(arg0),
                mint_count  : v7,
            };
            0x1::vector::push_back<Phase>(&mut v0, v8);
            v1 = v1 + 1;
        };
        let v9 = 2;
        let v10 = &v9;
        let v11 = if (*v10 == 0) {
            1747947600000
        } else if (*v10 == 1) {
            1747949400000
        } else if (*v10 == 2) {
            1747947600000
        } else if (*v10 == 31) {
            1747951200000
        } else if (*v10 == 32) {
            1747951200000
        } else {
            0
        };
        let v12 = 2;
        let v13 = &v12;
        let v14 = if (*v13 == 0) {
            1747951200000
        } else if (*v13 == 1) {
            1747951200000
        } else if (*v13 == 2) {
            1748124000000
        } else if (*v13 == 31) {
            1748124000000
        } else if (*v13 == 32) {
            1748124000000
        } else {
            0
        };
        let v15 = 2;
        let v16 = &v15;
        let v17 = if (*v16 == 0) {
            3
        } else if (*v16 == 1) {
            2
        } else if (*v16 == 2) {
            2
        } else if (*v16 == 31) {
            10
        } else if (*v16 == 32) {
            5
        } else {
            0
        };
        let v18 = BurnPhase{
            start      : v11,
            end        : v14,
            mint_count : v17,
        };
        let v19 = 31;
        let v20 = &v19;
        let v21 = if (*v20 == 0) {
            1747947600000
        } else if (*v20 == 1) {
            1747949400000
        } else if (*v20 == 2) {
            1747947600000
        } else if (*v20 == 31) {
            1747951200000
        } else if (*v20 == 32) {
            1747951200000
        } else {
            0
        };
        let v22 = 31;
        let v23 = &v22;
        let v24 = if (*v23 == 0) {
            1747951200000
        } else if (*v23 == 1) {
            1747951200000
        } else if (*v23 == 2) {
            1748124000000
        } else if (*v23 == 31) {
            1748124000000
        } else if (*v23 == 32) {
            1748124000000
        } else {
            0
        };
        let v25 = 31;
        let v26 = &v25;
        let v27 = if (*v26 == 0) {
            3
        } else if (*v26 == 1) {
            2
        } else if (*v26 == 2) {
            2
        } else if (*v26 == 31) {
            10
        } else if (*v26 == 32) {
            5
        } else {
            0
        };
        let v28 = 32;
        let v29 = &v28;
        let v30 = if (*v29 == 0) {
            3
        } else if (*v29 == 1) {
            2
        } else if (*v29 == 2) {
            2
        } else if (*v29 == 31) {
            10
        } else if (*v29 == 32) {
            5
        } else {
            0
        };
        let v31 = PublicPhase{
            start                  : v21,
            end                    : v24,
            non_tablet_minted_list : 0x2::table::new<address, u64>(arg0),
            tablet_minted_list     : 0x2::table::new<address, u64>(arg0),
            tablet_mint_count      : v27,
            non_tablet_mint_count  : v30,
        };
        let v32 = Mint{
            id               : 0x2::object::new(arg0),
            nfts             : 0x2::table_vec::empty<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Data>(arg0),
            phases           : v0,
            burn_phase       : v18,
            public_phase     : v31,
            receiver_address : @0x54736e238008f713d2c9c1796c9d120a4e96081a0bdbab12b731d456c372c0e6,
        };
        0x2::transfer::public_share_object<Mint>(v32);
    }

    public(friend) fun add_data(arg0: &mut Mint, arg1: 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Data) {
        0x2::table_vec::push_back<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Data>(&mut arg0.nfts, arg1);
    }

    public(friend) fun add_group_minted_list(arg0: &mut Mint, arg1: u64, arg2: address, arg3: bool) {
        0x2::table::add<address, bool>(&mut 0x1::vector::borrow_mut<Phase>(&mut arg0.phases, arg1).minted_list, arg2, arg3);
    }

    public(friend) fun add_minted_list(arg0: &mut Mint, arg1: u64, arg2: address, arg3: u64) {
        let v0 = &arg1;
        if (*v0 == 0) {
            add_group_minted_list(arg0, 0, arg2, true);
        } else if (*v0 == 1) {
            add_group_minted_list(arg0, 1, arg2, true);
        } else if (*v0 == 2) {
        } else if (*v0 == 31) {
            add_public_tablet_minted_list(arg0, arg2, arg3);
        } else {
            assert!(*v0 == 32, 71);
            add_public_non_tablet_minted_list(arg0, arg2, arg3);
        };
    }

    public(friend) fun add_minter_list(arg0: &mut Mint, arg1: u64, arg2: vector<address>) {
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = &arg1;
            if (*v2 == 0) {
                if (!0x2::table::contains<address, bool>(&0x1::vector::borrow<Phase>(&arg0.phases, 0).list, v1)) {
                    0x2::table::add<address, bool>(&mut 0x1::vector::borrow_mut<Phase>(&mut arg0.phases, 0).list, v1, true);
                };
            } else if (*v2 == 1) {
                if (!0x2::table::contains<address, bool>(&0x1::vector::borrow<Phase>(&arg0.phases, 1).list, v1)) {
                    0x2::table::add<address, bool>(&mut 0x1::vector::borrow_mut<Phase>(&mut arg0.phases, 1).list, v1, true);
                };
            } else if (*v2 == 2) {
            } else if (*v2 == 31) {
            } else {
                assert!(*v2 == 32, 71);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public(friend) fun add_public_non_tablet_minted_list(arg0: &mut Mint, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.public_phase.non_tablet_minted_list, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.public_phase.non_tablet_minted_list, arg1);
            *v0 = *v0 + arg2;
            assert!(*v0 <= arg0.public_phase.non_tablet_mint_count, 13906834539415601151);
        } else {
            0x2::table::add<address, u64>(&mut arg0.public_phase.non_tablet_minted_list, arg1, arg2);
            assert!(arg2 <= arg0.public_phase.non_tablet_mint_count, 13906834556595470335);
        };
    }

    public(friend) fun add_public_tablet_minted_list(arg0: &mut Mint, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.public_phase.tablet_minted_list, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.public_phase.tablet_minted_list, arg1);
            *v0 = *v0 + arg2;
            assert!(*v0 <= arg0.public_phase.tablet_mint_count, 13906834612430045183);
        } else {
            0x2::table::add<address, u64>(&mut arg0.public_phase.tablet_minted_list, arg1, arg2);
            assert!(arg2 <= arg0.public_phase.tablet_mint_count, 13906834629609914367);
        };
    }

    public(friend) fun can_phase_mint(arg0: &Mint, arg1: &0x2::clock::Clock, arg2: u64) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = &arg2;
        let (v2, v3) = if (*v1 == 0) {
            (0x1::vector::borrow<Phase>(&arg0.phases, 0).start, 0x1::vector::borrow<Phase>(&arg0.phases, 0).end)
        } else {
            let (v4, v5) = if (*v1 == 1) {
                (0x1::vector::borrow<Phase>(&arg0.phases, 1).end, 0x1::vector::borrow<Phase>(&arg0.phases, 1).start)
            } else {
                let (v6, v7) = if (*v1 == 2) {
                    (arg0.burn_phase.start, arg0.burn_phase.end)
                } else if (*v1 == 31) {
                    (arg0.public_phase.start, arg0.public_phase.end)
                } else {
                    assert!(*v1 == 32, 71);
                    (arg0.public_phase.start, arg0.public_phase.end)
                };
                (v7, v6)
            };
            (v5, v4)
        };
        v0 >= v2 && v0 <= v3
    }

    public(friend) fun can_user_mint_phase(arg0: &Mint, arg1: u64, arg2: address) : bool {
        let v0 = &arg1;
        if (*v0 == 0) {
            0x2::table::contains<address, bool>(&0x1::vector::borrow<Phase>(&arg0.phases, 0).list, arg2)
        } else if (*v0 == 1) {
            0x2::table::contains<address, bool>(&0x1::vector::borrow<Phase>(&arg0.phases, 1).list, arg2)
        } else if (*v0 == 2) {
            true
        } else if (*v0 == 31) {
            true
        } else {
            assert!(*v0 == 32, 71);
            true
        }
    }

    public(friend) fun data_length(arg0: &Mint) : u64 {
        0x2::table_vec::length<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Data>(&arg0.nfts)
    }

    public(friend) fun data_pop_back(arg0: &mut Mint) : 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Data {
        0x2::table_vec::pop_back<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Data>(&mut arg0.nfts)
    }

    public(friend) fun data_swap_remove(arg0: &mut Mint, arg1: u64) : 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Data {
        0x2::table_vec::swap_remove<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Data>(&mut arg0.nfts, arg1)
    }

    public(friend) fun did_burn_phase_end(arg0: &Mint, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.burn_phase.end
    }

    public(friend) fun did_mint(arg0: &Mint, arg1: u64, arg2: address) : bool {
        let v0 = &arg1;
        if (*v0 == 0) {
            0x2::table::contains<address, bool>(&0x1::vector::borrow<Phase>(&arg0.phases, 0).minted_list, arg2)
        } else if (*v0 == 1) {
            0x2::table::contains<address, bool>(&0x1::vector::borrow<Phase>(&arg0.phases, 1).minted_list, arg2)
        } else if (*v0 == 2) {
            false
        } else if (*v0 == 31) {
            false
        } else {
            assert!(*v0 == 32, 71);
            false
        }
    }

    public(friend) fun how_much_can_mint_public_with_tablet(arg0: &Mint, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = arg0.public_phase.tablet_mint_count;
        let v1 = v0;
        if (0x2::table::contains<address, u64>(&arg0.public_phase.tablet_minted_list, 0x2::tx_context::sender(arg1))) {
            v1 = v0 - *0x2::table::borrow<address, u64>(&arg0.public_phase.tablet_minted_list, 0x2::tx_context::sender(arg1));
        };
        v1
    }

    public(friend) fun how_much_can_mint_public_without_tablet(arg0: &Mint, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = arg0.public_phase.non_tablet_mint_count;
        let v1 = v0;
        if (0x2::table::contains<address, u64>(&arg0.public_phase.non_tablet_minted_list, 0x2::tx_context::sender(arg1))) {
            v1 = v0 - *0x2::table::borrow<address, u64>(&arg0.public_phase.non_tablet_minted_list, 0x2::tx_context::sender(arg1));
        };
        v1
    }

    public(friend) fun mint_count(arg0: &Mint, arg1: u64) : u64 {
        let v0 = &arg1;
        if (*v0 == 0) {
            0x1::vector::borrow<Phase>(&arg0.phases, 0).mint_count
        } else if (*v0 == 1) {
            0x1::vector::borrow<Phase>(&arg0.phases, 1).mint_count
        } else if (*v0 == 2) {
            arg0.burn_phase.mint_count
        } else if (*v0 == 31) {
            0
        } else {
            assert!(*v0 == 32, 71);
            0
        }
    }

    public(friend) fun receiver_address(arg0: &Mint) : address {
        arg0.receiver_address
    }

    // decompiled from Move bytecode v6
}

