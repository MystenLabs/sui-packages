module 0xc0ea90069c3024874f679ce3b4e04fdd4738339ce7d96462081ccd7dfeb84bad::keepers {
    struct KeeperRewards has key {
        id: 0x2::object::UID,
        basicPercent: u64,
        awardCount: u64,
        stats: vector<KeeperStats>,
    }

    struct KeeperStats has drop, store {
        wallet: address,
        availabilityPct: u8,
        pingsReceived: u32,
        pingsTransmitted: u32,
        dataUplink: u32,
        dataDownlink: u32,
        regionalCoeff: u8,
        seniority: u8,
    }

    struct KeepersLogRecord has drop, store {
        w: address,
        a: u64,
    }

    struct KeepersLog has store, key {
        id: 0x2::object::UID,
        date: 0x1::string::String,
        awards: vector<KeepersLogRecord>,
    }

    public entry fun award(arg0: &mut KeeperRewards, arg1: &mut 0x2::coin::Coin<0xe3be18c1ff0d2e24d6225f88e50ae3e4c7c24cb148d7082c91e84379b0f70bc4::chirptkn::CHIRPTKN>, arg2: &mut 0xe3be18c1ff0d2e24d6225f88e50ae3e4c7c24cb148d7082c91e84379b0f70bc4::chirptkn::ChirpMinterAmounts, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun award_and_log(arg0: &mut KeeperRewards, arg1: &mut 0x2::coin::Coin<0xe3be18c1ff0d2e24d6225f88e50ae3e4c7c24cb148d7082c91e84379b0f70bc4::chirptkn::CHIRPTKN>, arg2: &mut 0xe3be18c1ff0d2e24d6225f88e50ae3e4c7c24cb148d7082c91e84379b0f70bc4::chirptkn::ChirpMinterAmounts, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<KeepersLogRecord>();
        let v1 = 0xe3be18c1ff0d2e24d6225f88e50ae3e4c7c24cb148d7082c91e84379b0f70bc4::chirptkn::next_amount(arg2) * 1000000;
        if (v1 == 0) {
            return
        };
        let v2 = calc_rewards(&arg0.stats, arg0.basicPercent, v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<KeeperStats>(&arg0.stats)) {
            let v4 = *0x1::vector::borrow<u64>(&v2, v3);
            let v5 = 0x1::vector::borrow<KeeperStats>(&arg0.stats, v3).wallet;
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe3be18c1ff0d2e24d6225f88e50ae3e4c7c24cb148d7082c91e84379b0f70bc4::chirptkn::CHIRPTKN>>(0x2::coin::split<0xe3be18c1ff0d2e24d6225f88e50ae3e4c7c24cb148d7082c91e84379b0f70bc4::chirptkn::CHIRPTKN>(arg1, v4, arg4), v5);
            let v6 = KeepersLogRecord{
                w : v5,
                a : v4,
            };
            0x1::vector::push_back<KeepersLogRecord>(&mut v0, v6);
            v3 = v3 + 1;
        };
        let v7 = KeepersLog{
            id     : 0x2::object::new(arg4),
            date   : arg3,
            awards : v0,
        };
        0x2::transfer::public_transfer<KeepersLog>(v7, 0x2::tx_context::sender(arg4));
        arg0.awardCount = arg0.awardCount + 1;
    }

    fun calc_rewards(arg0: &vector<KeeperStats>, arg1: u64, arg2: u64) : vector<u64> {
        let v0 = 0x1::vector::length<KeeperStats>(arg0);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<KeeperStats>(arg0, v3);
            let v5 = ((v4.pingsReceived as u64) + arg1) * (v4.availabilityPct as u64);
            0x1::vector::push_back<u64>(&mut v1, v5);
            v2 = v2 + v5;
            v3 = v3 + 1;
        };
        v3 = 0;
        while (v3 < v0) {
            let v6 = 0x1::vector::borrow_mut<u64>(&mut v1, v3);
            *v6 = arg2 * *v6 / (v2 as u64);
            v3 = v3 + 1;
        };
        v1
    }

    public entry fun change_basic_points(arg0: &mut KeeperRewards, arg1: u64) {
        arg0.basicPercent = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KeeperRewards{
            id           : 0x2::object::new(arg0),
            basicPercent : 50,
            awardCount   : 0,
            stats        : 0x1::vector::empty<KeeperStats>(),
        };
        0x2::transfer::transfer<KeeperRewards>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun prepare_data(arg0: &mut KeeperRewards, arg1: vector<address>, arg2: vector<u8>, arg3: vector<u32>) {
        while (0x1::vector::length<KeeperStats>(&arg0.stats) > 0) {
            0x1::vector::pop_back<KeeperStats>(&mut arg0.stats);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = KeeperStats{
                wallet           : *0x1::vector::borrow<address>(&arg1, v0),
                availabilityPct  : *0x1::vector::borrow<u8>(&arg2, v0),
                pingsReceived    : *0x1::vector::borrow<u32>(&arg3, v0),
                pingsTransmitted : 0,
                dataUplink       : 0,
                dataDownlink     : 0,
                regionalCoeff    : 1,
                seniority        : 1,
            };
            0x1::vector::push_back<KeeperStats>(&mut arg0.stats, v1);
            v0 = v0 + 1;
        };
    }

    fun push_test_stats(arg0: &mut vector<KeeperStats>, arg1: address, arg2: u32) {
        let v0 = KeeperStats{
            wallet           : arg1,
            availabilityPct  : 100,
            pingsReceived    : arg2,
            pingsTransmitted : 0,
            dataUplink       : 0,
            dataDownlink     : 0,
            regionalCoeff    : 1,
            seniority        : 1,
        };
        0x1::vector::push_back<KeeperStats>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

