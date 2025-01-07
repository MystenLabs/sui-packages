module 0xe660721816716404814888c577c4dde60567aca15cdc020cca1fc0504116455a::fomove3d_game {
    struct FOMOVEGame has store, key {
        id: 0x2::object::UID,
        tick: 0x1::ascii::String,
        version: u64,
        unit_ticket_amt: u64,
        max_reward_epoch: u64,
        fee: u64,
        finnal_reward_rate: u64,
        beneficiary: address,
        current_index: u64,
        game_record: 0x2::table::Table<u64, FOMOVERecord>,
        timestamp_ms: u64,
        epoch_time_ms: u64,
    }

    struct FOMOVEReward has store, key {
        id: 0x2::object::UID,
        game_index: u64,
        ticket_index: u64,
        player: address,
        is_winner: bool,
    }

    struct FOMOVERecord has store, key {
        id: 0x2::object::UID,
        ticket_count: u64,
        winner: address,
        reward_amt: u64,
        claimed_ticket: u64,
    }

    struct FOMOVERecordEvent has copy, drop {
        ticket_count: u64,
        winner: address,
        reward_amt: u64,
        claimed_ticket: u64,
    }

    struct ClaimRewardEvent has copy, drop {
        game_index: u64,
        ticket_index: u64,
        player: address,
        reward: u64,
    }

    struct TicketPurchaseEvent has copy, drop {
        game_index: u64,
        ticket_index: u64,
        player: address,
        timestamp: u64,
    }

    struct FOMOVE3D_GAME has drop {
        dummy_field: bool,
    }

    public entry fun claim_fomove_reward(arg0: &mut FOMOVEGame, arg1: FOMOVEReward, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.game_index < arg0.current_index, 2);
        let v0 = compute_fomove_reward(arg0, &arg1);
        let FOMOVEReward {
            id           : v1,
            game_index   : v2,
            ticket_index : v3,
            player       : _,
            is_winner    : _,
        } = arg1;
        0x2::object::delete(v1);
        let v6 = 0x2::table::borrow_mut<u64, FOMOVERecord>(&mut arg0.game_record, v2);
        v6.claimed_ticket = v6.claimed_ticket + 1;
        let v7 = ClaimRewardEvent{
            game_index   : v2,
            ticket_index : v3,
            player       : 0x2::tx_context::sender(arg2),
            reward       : v0,
        };
        0x2::event::emit<ClaimRewardEvent>(v7);
        if (v0 == 0) {
            return
        };
        let v8 = 0x2::dynamic_object_field::borrow_mut<u64, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut v6.id, 0);
        if (v0 >= 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(v8)) {
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x2::dynamic_object_field::remove<u64, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut v6.id, 0), 0x2::tx_context::sender(arg2));
            return
        };
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(v8, v0, arg2), 0x2::tx_context::sender(arg2));
        if (v6.claimed_ticket > arg0.max_reward_epoch || v6.claimed_ticket == v6.ticket_count) {
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x2::dynamic_object_field::remove<u64, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut v6.id, 0), arg0.beneficiary);
        };
    }

    public fun compute_fomove_reward(arg0: &FOMOVEGame, arg1: &FOMOVEReward) : u64 {
        let v0 = 0x2::table::borrow<u64, FOMOVERecord>(&arg0.game_record, arg1.game_index);
        let v1 = if (arg1.is_winner) {
            if (v0.ticket_count > 1) {
                v0.reward_amt * arg0.finnal_reward_rate / 1000
            } else {
                v0.reward_amt
            }
        } else {
            let v2 = 0x2::math::min(arg0.max_reward_epoch, v0.ticket_count);
            let v3 = 0;
            let v4 = arg1.ticket_index;
            while (v4 < v2) {
                v3 = 10000 / v4 + v3;
                v4 = v4 + 1;
            };
            v3 * arg0.unit_ticket_amt * (1000 - arg0.finnal_reward_rate - arg0.fee) / 1000 / 10000
        };
        if (v0.ticket_count > arg0.max_reward_epoch && arg1.ticket_index <= arg0.max_reward_epoch) {
            v1 = v1 + (v0.ticket_count - arg0.max_reward_epoch) * arg0.unit_ticket_amt * (1000 - arg0.fee - arg0.finnal_reward_rate) / 1000 / arg0.max_reward_epoch;
        };
        v1
    }

    public fun get_fomove_record(arg0: &FOMOVEGame, arg1: u64) : &FOMOVERecord {
        let v0 = 0x2::table::borrow<u64, FOMOVERecord>(&arg0.game_record, arg1);
        let v1 = FOMOVERecordEvent{
            ticket_count   : v0.ticket_count,
            winner         : v0.winner,
            reward_amt     : v0.reward_amt,
            claimed_ticket : v0.claimed_ticket,
        };
        0x2::event::emit<FOMOVERecordEvent>(v1);
        v0
    }

    fun init(arg0: FOMOVE3D_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FOMOVERecord{
            id             : 0x2::object::new(arg1),
            ticket_count   : 0,
            winner         : @0x2,
            reward_amt     : 0,
            claimed_ticket : 0,
        };
        let v1 = FOMOVEGame{
            id                 : 0x2::object::new(arg1),
            tick               : 0x1::ascii::string(b"MOVE"),
            version            : 1,
            unit_ticket_amt    : 10000,
            max_reward_epoch   : 200,
            fee                : 50,
            finnal_reward_rate : 570,
            beneficiary        : 0x2::tx_context::sender(arg1),
            current_index      : 0,
            game_record        : 0x2::table::new<u64, FOMOVERecord>(arg1),
            timestamp_ms       : 1705802400000,
            epoch_time_ms      : 30000,
        };
        0x2::table::add<u64, FOMOVERecord>(&mut v1.game_record, v1.current_index, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<FOMOVE3D_GAME>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<FOMOVEGame>(v1);
    }

    public entry fun play_fomove_game(arg0: &mut FOMOVEGame, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.tick == 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick(&arg1), 0);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1) == arg0.unit_ticket_amt, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 1705802400000, 3);
        let v1 = if (0x2::table::borrow<u64, FOMOVERecord>(&arg0.game_record, arg0.current_index).ticket_count > arg0.max_reward_epoch) {
            arg0.epoch_time_ms
        } else {
            arg0.epoch_time_ms * 2
        };
        if (v0 > arg0.timestamp_ms + v1 && arg0.timestamp_ms > 1705802400000) {
            let v2 = 0x2::table::borrow_mut<u64, FOMOVERecord>(&mut arg0.game_record, arg0.current_index);
            if (v2.ticket_count > 1) {
                let v3 = 0x2::dynamic_object_field::borrow_mut<u64, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut v2.id, 0);
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(v3, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(v3) * arg0.fee / 1000, arg3), arg0.beneficiary);
            };
            let v4 = FOMOVEReward{
                id           : 0x2::object::new(arg3),
                game_index   : arg0.current_index,
                ticket_index : v2.ticket_count,
                player       : v2.winner,
                is_winner    : true,
            };
            0x2::transfer::public_transfer<FOMOVEReward>(v4, v2.winner);
            arg0.current_index = arg0.current_index + 1;
            let v5 = FOMOVERecord{
                id             : 0x2::object::new(arg3),
                ticket_count   : 0,
                winner         : 0x2::tx_context::sender(arg3),
                reward_amt     : 0,
                claimed_ticket : 0,
            };
            0x2::table::add<u64, FOMOVERecord>(&mut arg0.game_record, arg0.current_index, v5);
        };
        arg0.timestamp_ms = v0;
        let v6 = 0x2::table::borrow_mut<u64, FOMOVERecord>(&mut arg0.game_record, arg0.current_index);
        v6.reward_amt = v6.reward_amt + arg0.unit_ticket_amt;
        if (0x2::dynamic_object_field::exists_<u64>(&v6.id, 0)) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::merge(0x2::dynamic_object_field::borrow_mut<u64, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut v6.id, 0), arg1);
        } else {
            0x2::dynamic_object_field::add<u64, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut v6.id, 0, arg1);
        };
        v6.ticket_count = v6.ticket_count + 1;
        v6.winner = 0x2::tx_context::sender(arg3);
        if (v6.ticket_count <= arg0.max_reward_epoch) {
            let v7 = FOMOVEReward{
                id           : 0x2::object::new(arg3),
                game_index   : arg0.current_index,
                ticket_index : v6.ticket_count,
                player       : 0x2::tx_context::sender(arg3),
                is_winner    : false,
            };
            0x2::transfer::public_transfer<FOMOVEReward>(v7, 0x2::tx_context::sender(arg3));
        };
        let v8 = TicketPurchaseEvent{
            game_index   : arg0.current_index,
            ticket_index : v6.ticket_count,
            player       : 0x2::tx_context::sender(arg3),
            timestamp    : v0,
        };
        0x2::event::emit<TicketPurchaseEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

