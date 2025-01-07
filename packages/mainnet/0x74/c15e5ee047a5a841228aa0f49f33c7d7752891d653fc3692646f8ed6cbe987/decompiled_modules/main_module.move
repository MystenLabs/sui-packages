module 0x74c15e5ee047a5a841228aa0f49f33c7d7752891d653fc3692646f8ed6cbe987::main_module {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TheTreasury has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SeatingChart has key {
        id: 0x2::object::UID,
        version: u64,
        current_row: u64,
        current_floor: u64,
        seating: vector<vector<address>>,
    }

    struct InviteArchieves has key {
        id: 0x2::object::UID,
        version: u64,
        team_addresses: vector<address>,
        cabinet: 0x2::table::Table<address, InviteFiles>,
    }

    struct InviteFiles has store {
        id: 0x2::object::UID,
        affCode: address,
        position_of_aff: u64,
        total_effective_invite_number: u64,
        invite_addresses: vector<address>,
        position_row_of_seating: u64,
        position_floor_of_seating: u64,
        has_stake_number: u64,
        could_reward: u64,
        has_reward: u64,
    }

    struct Registers has copy, drop {
        from: address,
        ref: address,
    }

    struct Participates has copy, drop {
        from: address,
        num: u64,
    }

    public fun getPositionInfo(arg0: &SeatingChart) : (u64, u64) {
        (arg0.current_floor, arg0.current_row)
    }

    public fun getPrice() : u64 {
        100000000000
    }

    public fun getUsrInfo(arg0: &InviteArchieves, arg1: address) : (address, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<address, InviteFiles>(&arg0.cabinet, arg1);
        (v0.affCode, v0.position_of_aff, v0.total_effective_invite_number, v0.position_row_of_seating, v0.position_floor_of_seating, v0.has_stake_number, v0.could_reward, v0.has_reward)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = TheTreasury{
            id      : 0x2::object::new(arg0),
            version : 1,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = 0x1::vector::empty<vector<address>>();
        let v3 = &mut v2;
        0x1::vector::push_back<vector<address>>(v3, 0x1::vector::empty<address>());
        0x1::vector::push_back<vector<address>>(v3, 0x1::vector::empty<address>());
        let v4 = SeatingChart{
            id            : 0x2::object::new(arg0),
            version       : 1,
            current_row   : 0,
            current_floor : 1,
            seating       : v2,
        };
        let v5 = InviteArchieves{
            id             : 0x2::object::new(arg0),
            version        : 1,
            team_addresses : 0x1::vector::empty<address>(),
            cabinet        : 0x2::table::new<address, InviteFiles>(arg0),
        };
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xa08ab22f1ff46c22d8eabb756dca197ad5fcdf99ee15d2e9bfedb03b7c775f63);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x4a2e9ef72460cd6083a5e0140adea92e7e2c3b122fa72b54f76f582a8feaab90);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xc6e9356cc2dc791fd31d5166389998e74728551f8dcb91bb6ff21c41f587cf18);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x7e4abc5fff7a2da40bb88bcd1990c5b9c262b384fbbb028b4e8b8bf583a58a02);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xa7804d9ddadf739fc0b609488bbe41e6d1b8ee0a3e434a1be4c26ea9e38ae2c1);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xf519fa589ce33e35e76ac5742fa5368dacf170f4659e9e9fe5e022de7293bd7e);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xc5e69a9652a6667600b8665325f04b9e94b2908e218d562a63b5850a18c5d225);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xf129f533c3bd98098bb9af4dbe280405de28d6bc49ba01bf6fadce3d3f421e60);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x1c64330427838283303aac7bf89925f18e2ef5f91c8ebbec1efb7efd2ea7f7a5);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x1c2cce3c28b0353b13539509d9198da074e3039a59049266b0e458907c4f61f3);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xeed93632fbb72c6e7a5e14beac661b1b035d1c27601d091312ee612c5b910f9c);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xb65e0a711dec0600abed907c7859c1bb60a2b7422af05af15908ac3167011196);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xbf19e932836730c0e147f45ca3af775052a04851cc705dba8d456c221f00b5d1);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x9ec9b962abc34202b8fbfbb0c69b462a39397398b6712de6b04c883b8bc6207d);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xcb2f57fe41639dce0d1901ba392412d837ea8e43a021552314008e41b1a962de);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x441d0fab7441621130248cd6c814ea467bb6a0f2318a75fd025e787c573b9d6e);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xa71e5ee74865dacc149cbeb7d61ead8b5261a55fd248432cbecdff885fd2ae9a);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xcfdb30f78753e73dd096b69360c75a9f018acecce10e50dee4885a6114b6ab05);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x91ea37704b3086400d6c0089e293092b998a6ca394de46ee720d9d2d93faee9f);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x7e486da4ff28b352ce08b905a9dfe2aaca5d46da8f6c6fd9dac7060df5cc7c78);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x1bf11e5a88a8b5666eefecb6aef64f118bb52754cde9ad6ab9e73dda647bb2c1);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x2ef8158093dfc1c0d448a6afd9cec58491cc051b92363b1fe299f9a170ecada8);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xe67c8e56c9713241f16e879ee708010d8b453673a49146e042c8182698d5a6a4);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x66560dc6d6f4bd36378cc29a44830edf0939222b5c482546c7671f3aae0e5a1f);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x57f560335c54a360886b5391196feb0c9bff7603a57f0b3e93f0987aa6f5fbeb);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x9914e78d8cf37d010643befe850a1ff16adfeda83ee6f8137e9aad4decea19f3);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x16cba2c4b4d3ea08cdd2a53fe200cc7e8c48d16d3e7b455c8fbbd9068e49bf4);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x3ea44f405b16ae740076fe2bed23e85b7a8bdfbb98cd6c02ad78862000c4b801);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xac6503079f272fe55926d53a674c8c0d106c9cdf57f950324bf9b101646cecf7);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x416a00b15f2ff5f801f631d4fcc87bc363cde63b00d0fe860b768d37038193a3);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x71cd2bcc99b01441a274013032ce460955cf4040c7245e96d77a7da6338434d2);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xd0b222f02ade5f045a5d4aa05e5a64c00db222040ef0e9647752dabb52e6a9f1);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x63fffbab15d5ec2cfd0bbba07e90b179fc502be19723d0bf3a8f34b5e5d0b209);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x241005f4a99a6cb0317dd2a198883355e1178003b361e2f3a02ddbdce7eeb140);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x617317ba9ae8a16add6377b1ecc8846606551ade326411e08b7fff4384e4b11);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x2a358e440c1c1bb9cbf61af0b8cf9439bd55881b5d59d9f727c26fa9750baede);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x87570c900db56d7cab2eee36f71ae126b68a255e7c4c924030c14f4a78922767);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xbd1f357df3690102fd52b242c68c78b3556292f42be94dafd86760e52ea6830c);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xcbc7e368e8e7451c080b3173e1c7d80bed8027cff44dc1a46d2d6c82432ae68);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xfe82664299ad9fed47b05d52188a0a76c1fe9e7c016a575265d9ce5e82d6c537);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x1c7b063b7153c5028245d68b7a17e7bc6f0b42d32cecef8855db8caf1b60e65d);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x159e4b0be6f2a4a00f5e969ee03df10b319a1b5a2dbb9857425be5731f8f3395);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xf6d46393c6f7e8ee616d3fd561a8ce670960d85d7c9b3c0e804041592a1f41cc);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xc76b9e37be199309f165ab427c0ec7f7c606d04d6a1ff30c6a96dc742bd75965);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x5c139d091a43799cb9d9380c0403d1facd4c7455ba98e820b0d9b02c2d6d1bee);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xc52de91dcdfdd022ba325d29d98a6d95e839ac1aa828aa29e2e256ca680c5be0);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x420ea98f61db88b3e1a9a113ac3ac1a87471ad80b139f03d9e981538930ce2c);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xa84fc50a8d5c083c219cbf5073344d26f8b43442100ea8c164783f7526ba664e);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x215bb61bff0d6c19b16ee4150e8998a329161b7c9e9281028f964f35d7401a6b);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xfc1d0ddfd36d18ab2c24d2bf0d1d6b3451475b9c17f45da5d01570e173b1433c);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x19a15b0d746361955459f4fb25a22411ac74e3eb9a6dfc7607db29591e4eab2a);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x93a6bca1cef6ab4b0dfedd306f04eae9e110775ca33d7f6e3e6b11ee5d0927a6);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0xd48e8f2aa4a30df60d2ff388bda6d948c3417f23a0c00881b5ca79949a72644c);
        0x1::vector::push_back<address>(&mut v5.team_addresses, @0x70c1f17727ec112571e97d3512a37f1320b5414ee3ca2a88adc94c2661742e2);
        let v6 = InviteFiles{
            id                            : 0x2::object::new(arg0),
            affCode                       : @0x0,
            position_of_aff               : 0,
            total_effective_invite_number : 0,
            invite_addresses              : 0x1::vector::empty<address>(),
            position_row_of_seating       : 0,
            position_floor_of_seating     : 0,
            has_stake_number              : 0,
            could_reward                  : 0,
            has_reward                    : 0,
        };
        0x2::table::add<address, InviteFiles>(&mut v5.cabinet, 0x2::tx_context::sender(arg0), v6);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<TheTreasury>(v1);
        0x2::transfer::share_object<SeatingChart>(v4);
        0x2::transfer::share_object<InviteArchieves>(v5);
    }

    public entry fun participate(arg0: &mut InviteArchieves, arg1: &mut SeatingChart, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x74c15e5ee047a5a841228aa0f49f33c7d7752891d653fc3692646f8ed6cbe987::sbt::Own, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, InviteFiles>(&arg0.cabinet, v0), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= 100000000000 * arg2, 5);
        let v1 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v0);
        let v2 = v1;
        assert!(arg2 > 0 && v1.has_stake_number + arg2 <= 50, 4);
        v1.has_stake_number = v1.has_stake_number + arg2;
        let v3 = false;
        if (v1.position_floor_of_seating == 0) {
            v3 = true;
            0x1::vector::push_back<address>(0x1::vector::borrow_mut<vector<address>>(&mut arg1.seating, arg1.current_floor), v0);
            v1.position_row_of_seating = arg1.current_row;
            v1.position_floor_of_seating = arg1.current_floor;
            if (arg1.current_row + 1 > 2) {
                arg1.current_row = 0;
                arg1.current_floor = arg1.current_floor + 1;
                0x1::vector::push_back<vector<address>>(&mut arg1.seating, 0x1::vector::empty<address>());
            } else {
                arg1.current_row = arg1.current_row + 1;
            };
            let v4 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v1.affCode);
            v4.total_effective_invite_number = v4.total_effective_invite_number + 1;
            0x1::vector::push_back<address>(&mut v4.invite_addresses, v0);
            let v5 = v4.total_effective_invite_number;
            let v6 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v0);
            v2 = v6;
            v6.position_of_aff = v5;
        };
        0x74c15e5ee047a5a841228aa0f49f33c7d7752891d653fc3692646f8ed6cbe987::sbt::mint(arg4, v0, arg5);
        let v7 = Participates{
            from : v0,
            num  : arg2,
        };
        0x2::event::emit<Participates>(v7);
        let v8 = 100000000000 * arg2;
        let v9 = if (v3 == true) {
            v8 * 3
        } else {
            v8 * 22 / 10
        };
        v2.could_reward = v2.could_reward + v9;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v8 * 6 / 100, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, 53));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v8 * 4 / 100, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, 52));
        let v10 = v8 * 90 / 100;
        let v11 = v10 * 50 / 100;
        let v12 = v2.affCode;
        if (v2.position_of_aff % 3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v10 * 40 / 100, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, 0));
            v11 = v10 * 10 / 100;
        };
        let v13 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v12);
        if (v13.could_reward <= v11) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v11 - v13.could_reward, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, 0));
            v11 = v13.could_reward;
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v11, arg5), v12);
            v13.could_reward = v13.could_reward - v11;
            v13.has_reward = v13.has_reward + v11;
        };
        let v14 = 0;
        let v15 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v0).affCode);
        while (v14 < 10) {
            let v16 = v10 / 100;
            let v17 = v16;
            let v18 = v15.affCode;
            let v19 = v14;
            if (v15.affCode == @0x0) {
                while (v19 < 10) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v16, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, v19 + 1));
                    v19 = v19 + 1;
                };
            } else {
                let v20 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v15.affCode);
                v15 = v20;
                if (v20.total_effective_invite_number >= 3) {
                    if (v20.could_reward <= v16) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v16 - v20.could_reward, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, v14 + 1));
                        v17 = v20.could_reward;
                    };
                    if (v17 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v17, arg5), v18);
                        v20.could_reward = v20.could_reward - v17;
                        v20.has_reward = v20.has_reward + v17;
                    };
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v16, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, v14 + 1));
                };
                v14 = v14 + 1;
            };
        };
        v14 = 0;
        while (v14 < 5) {
            let v21 = v10 / 100;
            let v22 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v0);
            v0 = v22.affCode;
            let v23 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v22.affCode);
            let v24 = v14;
            if (v23.affCode == @0x0) {
                while (v24 < 5) {
                    let v25 = 0;
                    if (v24 < 3) {
                        while (v25 < 9) {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v21, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, v24 * 9 + 11 + v25));
                            v25 = v25 + 1;
                        };
                    } else {
                        while (v25 < 6) {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v21, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, (v24 - 3) * 6 + 38 + v25));
                            v25 = v25 + 1;
                        };
                    };
                    v24 = v24 + 1;
                };
            } else {
                let v26 = v23.position_floor_of_seating;
                if (v26 == 0) {
                    let v27 = 0;
                    while (v27 < 3) {
                        if (v14 < 3) {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v10 / 100, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, v14 * 9 + 11 + v27));
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v10 / 100, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, v14 * 9 + 14 + v27));
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v10 / 100, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, v14 * 9 + 17 + v27));
                        } else {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v10 / 100, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, (v14 - 3) * 6 + 38 + v27));
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v10 / 100, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, (v14 - 3) * 6 + 41 + v27));
                        };
                        v27 = v27 + 1;
                    };
                    v14 = v14 + 1;
                    continue
                };
                v24 = 0;
                while (v24 < 3) {
                    let v28 = if (arg1.current_floor > v26 + 1 || arg1.current_floor == v26 + 1 && arg1.current_row > v24) {
                        *0x1::vector::borrow<address>(0x1::vector::borrow<vector<address>>(&arg1.seating, v26 + 1), v24)
                    } else {
                        @0x0
                    };
                    let v29 = if (arg1.current_floor > v26 + 2 || arg1.current_floor == v26 + 2 && arg1.current_row > v24) {
                        *0x1::vector::borrow<address>(0x1::vector::borrow<vector<address>>(&arg1.seating, v26 + 2), v24)
                    } else {
                        @0x0
                    };
                    let v30 = if (v14 < 3) {
                        *0x1::vector::borrow<address>(&arg0.team_addresses, v14 * 9 + 11 + v24)
                    } else {
                        *0x1::vector::borrow<address>(&arg0.team_addresses, (v14 - 3) * 6 + 38 + v24)
                    };
                    let v31 = if (v14 < 3) {
                        *0x1::vector::borrow<address>(&arg0.team_addresses, v14 * 9 + 14 + v24)
                    } else {
                        *0x1::vector::borrow<address>(&arg0.team_addresses, (v14 - 3) * 6 + 41 + v24)
                    };
                    if (v28 != @0x0) {
                        let v32 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v28);
                        let v33 = if (v32.could_reward <= v21) {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v21 - v32.could_reward, arg5), v30);
                            v32.could_reward
                        } else {
                            v21
                        };
                        if (v33 > 0) {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v33, arg5), v28);
                            v32.could_reward = v32.could_reward - v33;
                            v32.has_reward = v32.has_reward + v33;
                        };
                    } else {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v21, arg5), v30);
                    };
                    if (v29 != @0x0) {
                        let v34 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v29);
                        let v35 = if (v34.could_reward <= v21) {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v21 - v34.could_reward, arg5), v31);
                            v34.could_reward
                        } else {
                            v21
                        };
                        if (v35 > 0) {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v35, arg5), v29);
                            v34.could_reward = v34.could_reward - v35;
                            v34.has_reward = v34.has_reward + v35;
                        };
                    } else {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v21, arg5), v31);
                    };
                    if (v14 < 3) {
                        let v36 = if (v26 - 1 > 0) {
                            *0x1::vector::borrow<address>(0x1::vector::borrow<vector<address>>(&arg1.seating, v26 - 1), v24)
                        } else {
                            @0x0
                        };
                        if (v36 != @0x0) {
                            let v37 = 0x2::table::borrow_mut<address, InviteFiles>(&mut arg0.cabinet, v36);
                            let v38 = if (v37.could_reward <= v21) {
                                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v21 - v37.could_reward, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, v14 * 9 + 17 + v24));
                                v37.could_reward
                            } else {
                                v21
                            };
                            if (v38 > 0) {
                                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v38, arg5), v36);
                                v37.could_reward = v37.could_reward - v38;
                                v37.has_reward = v37.has_reward + v38;
                            };
                        } else {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v21, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, v14 * 9 + 17 + v24));
                        };
                    };
                    v24 = v24 + 1;
                };
                v14 = v14 + 1;
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v10 / 100, arg5), *0x1::vector::borrow<address>(&arg0.team_addresses, 0));
    }

    public entry fun register(arg0: &mut InviteArchieves, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, InviteFiles>(&arg0.cabinet, arg1), 1);
        assert!(v0 != arg1, 3);
        assert!(!0x2::table::contains<address, InviteFiles>(&arg0.cabinet, v0), 2);
        let v1 = InviteFiles{
            id                            : 0x2::object::new(arg2),
            affCode                       : arg1,
            position_of_aff               : 0,
            total_effective_invite_number : 0,
            invite_addresses              : 0x1::vector::empty<address>(),
            position_row_of_seating       : 0,
            position_floor_of_seating     : 0,
            has_stake_number              : 0,
            could_reward                  : 0,
            has_reward                    : 0,
        };
        0x2::table::add<address, InviteFiles>(&mut arg0.cabinet, v0, v1);
        let v2 = Registers{
            from : v0,
            ref  : arg1,
        };
        0x2::event::emit<Registers>(v2);
    }

    public entry fun whiteList(arg0: vector<address>, arg1: vector<u64>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        loop {
            if (0x1::vector::is_empty<address>(&arg0)) {
                break
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, 0x1::vector::pop_back<u64>(&mut arg1), arg3), 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun withdraw(arg0: &mut TheTreasury, arg1: &AdminCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            let v1 = 0x1::option::destroy_some<u64>(arg2);
            assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 0);
            v1
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

