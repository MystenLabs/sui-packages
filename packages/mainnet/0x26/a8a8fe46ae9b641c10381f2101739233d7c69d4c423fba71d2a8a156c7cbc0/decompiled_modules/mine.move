module 0x26a8a8fe46ae9b641c10381f2101739233d7c69d4c423fba71d2a8a156c7cbc0::mine {
    struct Miner has key {
        id: 0x2::object::UID,
        Genesis: u64,
    }

    struct MinerData has store, key {
        id: 0x2::object::UID,
        reward_Epochs: vector<u64>,
    }

    struct Rewardata has store, key {
        id: 0x2::object::UID,
        share: u64,
        unlock: u64,
        eid: u64,
        euid: vector<u8>,
    }

    struct Epochs has key {
        id: 0x2::object::UID,
    }

    struct EpochData has store, key {
        id: 0x2::object::UID,
        shares_miners: vector<u64>,
    }

    struct EpochRst has copy, drop {
        uid: vector<u8>,
        share: u64,
    }

    struct RstEvet has copy, drop {
        epoch: u64,
        share: u64,
        ext_share: u64,
        unlock: u64,
        euid: vector<u8>,
    }

    public entry fun mine(arg0: &mut Miner, arg1: &mut Epochs, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(v0 >= arg2, 1020);
        assert!(v0 - arg2 <= 20, 1021);
        assert!(arg3 <= 60, 1040);
        assert!(v0 > arg0.Genesis, 10);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(0x2::tx_context::sender(arg5)));
        0x1::vector::append<u8>(&mut v1, u64_to_ascii(arg2));
        let v2 = 0x2::hash::blake2b256(&v1);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 32) {
            let v5 = v3 << 8;
            v3 = v5 | (*0x1::vector::borrow<u8>(&v2, v4) as u128);
            v4 = v4 + 1;
        };
        let v6 = 10 + arg3;
        let v7 = getorcreat_epoch_shares_miner(arg1, arg2 - 30, v6, arg5);
        let v8 = ((*0x1::vector::borrow<u64>(&v7, 1) / 1000 + 24) as u128);
        assert!(v3 % v8 == 0, 1050);
        if (v3 % v8 == 0) {
            let v9 = updateorcreat_epoch_shares_miner(arg1, arg2, v6, arg5);
            hit(arg0, arg2, v6 + v9.share, arg2 + arg3 * 86400, v9.uid, arg5);
            let v10 = RstEvet{
                epoch     : arg2,
                share     : v6 + v9.share,
                ext_share : v9.share,
                unlock    : arg3,
                euid      : v9.uid,
            };
            0x2::event::emit<RstEvet>(v10);
        };
    }

    public(friend) fun claim(arg0: &mut Miner, arg1: &Epochs, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u128 {
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg3)), 2);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, MinerData>(&mut arg0.id, 0x2::tx_context::sender(arg3));
        let v2 = 0x1::vector::length<u64>(&v1.reward_Epochs);
        let v3 = 0;
        let v4 = 100;
        while (v2 > 0) {
            v2 = v2 - 1;
            let v5 = *0x1::vector::borrow<u64>(&v1.reward_Epochs, v2);
            if ((v5 as u128) <= ((v0 - 30) as u128)) {
                if (0x2::dynamic_object_field::exists_with_type<u64, Rewardata>(&mut v1.id, v5)) {
                    let v6 = 0x2::dynamic_object_field::borrow_mut<u64, Rewardata>(&mut v1.id, v5);
                    if (v6.unlock <= v0) {
                        v3 = v3 + 277777778 * (v6.share as u128) * 1000000000000 / (*0x1::vector::borrow<u64>(&0x2::dynamic_object_field::borrow<u64, EpochData>(&arg1.id, v5).shares_miners, 0) as u128) * 1000000000000;
                        0x1::vector::remove<u64>(&mut v1.reward_Epochs, v2);
                        let Rewardata {
                            id     : v7,
                            share  : _,
                            unlock : _,
                            eid    : _,
                            euid   : _,
                        } = 0x2::dynamic_object_field::remove<u64, Rewardata>(&mut v1.id, v5);
                        0x2::object::delete(v7);
                        let v12 = v4 - 1;
                        v4 = v12;
                        if (v12 <= 0) {
                            v2 = 0;
                            continue
                        } else {
                            continue
                        };
                    };
                    continue
                };
                0x1::vector::remove<u64>(&mut v1.reward_Epochs, v2);
                let v13 = v4 - 1;
                v4 = v13;
                if (v13 <= 0) {
                    v2 = 0;
                };
            };
        };
        v3
    }

    fun creat_epoch_shares_miner(arg0: &mut Epochs, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(!0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1), 2);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg2);
        0x1::vector::push_back<u64>(v1, 1);
        let v2 = EpochData{
            id            : 0x2::object::new(arg3),
            shares_miners : v0,
        };
        0x2::dynamic_object_field::add<u64, EpochData>(&mut arg0.id, arg1, v2);
        v2.shares_miners
    }

    fun getorcreat_epoch_shares_miner(arg0: &mut Epochs, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<u64> {
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1)) {
            0x2::dynamic_object_field::borrow<u64, EpochData>(&arg0.id, arg1).shares_miners
        } else {
            vector[0, 1]
        }
    }

    fun hit(arg0: &mut Miner, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg5)), 1010);
        if (0x2::dynamic_object_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg5))) {
            let v0 = Rewardata{
                id     : 0x2::object::new(arg5),
                share  : arg2,
                unlock : arg3,
                eid    : arg1,
                euid   : arg4,
            };
            let v1 = 0x2::dynamic_object_field::borrow_mut<address, MinerData>(&mut arg0.id, 0x2::tx_context::sender(arg5));
            assert!(!0x2::dynamic_object_field::exists_<u64>(&v1.id, arg1), 1030);
            0x1::vector::push_back<u64>(&mut v1.reward_Epochs, arg1);
            0x2::dynamic_object_field::add<u64, Rewardata>(&mut v1.id, arg1, v0);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Epochs{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Epochs>(v0);
        let v1 = Miner{
            id      : 0x2::object::new(arg0),
            Genesis : 1728450000,
        };
        0x2::transfer::share_object<Miner>(v1);
    }

    public entry fun regist_miner(arg0: &mut Miner, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg1)), 1000);
        if (!0x2::dynamic_object_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg1))) {
            let v0 = MinerData{
                id            : 0x2::object::new(arg1),
                reward_Epochs : 0x1::vector::empty<u64>(),
            };
            0x2::dynamic_object_field::add<address, MinerData>(&mut arg0.id, 0x2::tx_context::sender(arg1), v0);
        };
    }

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun updateorcreat_epoch_shares_miner(arg0: &mut Epochs, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : EpochRst {
        let v0 = EpochRst{
            uid   : 0x1::vector::empty<u8>(),
            share : 0,
        };
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<u64, EpochData>(&mut arg0.id, arg1);
            let v2 = 0x1::vector::empty<u64>();
            let v3 = &mut v2;
            0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v1.shares_miners, 0) + arg2);
            0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v1.shares_miners, 1) + 1);
            v1.shares_miners = v2;
            v0.share = 0;
            v0.uid = 0x2::object::uid_to_bytes(&v1.id);
            v0
        } else {
            creat_epoch_shares_miner(arg0, arg1, arg2 + 1, arg3);
            v0.share = 1;
            v0.uid = 0x2::object::uid_to_bytes(&0x2::dynamic_object_field::borrow<u64, EpochData>(&arg0.id, arg1).id);
            v0
        }
    }

    // decompiled from Move bytecode v6
}

