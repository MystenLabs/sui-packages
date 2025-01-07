module 0x1d00c4e5e826da48a70de76f2da7be4a9a818d65e191c86a6f2399f603f2565c::game {
    struct DeployRecord has key {
        id: 0x2::object::UID,
        version: u64,
        finished: 0x2::table_vec::TableVec<0x2::object::ID>,
        open: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct VotingRecord has key {
        id: 0x2::object::UID,
        version: u64,
        description: 0x1::string::String,
        option_a: vector<u8>,
        option_b: vector<u8>,
        description_a: 0x1::string::String,
        description_b: 0x1::string::String,
        deadline: u64,
        settled: bool,
        winner: bool,
        burn: bool,
        uncertain: bool,
        a_queue: 0x2::table_vec::TableVec<address>,
        b_queue: 0x2::table_vec::TableVec<address>,
        a_ins_table: 0x2::table::Table<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
        b_ins_table: 0x2::table::Table<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
        a_amt_table: 0x2::table::Table<address, u64>,
        b_amt_table: 0x2::table::Table<address, u64>,
        reward_ins: vector<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
        reward_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        a_sum: u128,
        b_sum: u128,
    }

    struct VotingSettleCap has store, key {
        id: 0x2::object::UID,
        to: 0x2::object::ID,
    }

    struct ProtocalBank has key {
        id: 0x2::object::UID,
        ms_type: 0x2::table_vec::TableVec<0x1::ascii::String>,
        ms_balance: 0x2::table::Table<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ProtocalBankCap has store, key {
        id: 0x2::object::UID,
    }

    struct UpgradeBank has key {
        id: 0x2::object::UID,
        ms_type: 0x2::table_vec::TableVec<0x1::ascii::String>,
        ms_balance: 0x2::table::Table<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct UpgradeBankCap has store, key {
        id: 0x2::object::UID,
    }

    struct Voting has copy, drop {
        vote_to: 0x2::object::ID,
        voter: address,
        amount: u64,
        type: 0x1::ascii::String,
    }

    struct DeployVoting has copy, drop {
        voting_id: 0x2::object::ID,
        sender: address,
    }

    struct SettleVote has copy, drop {
        set_to: 0x2::object::ID,
        sender: address,
        result: 0x1::ascii::String,
    }

    struct Withdraw has copy, drop {
        voting_id: 0x2::object::ID,
        receiver: address,
        amount: u64,
        type: 0x1::ascii::String,
    }

    struct ClaimReward has copy, drop {
        voting_id: 0x2::object::ID,
        receiver: address,
        amount: u64,
        type: 0x1::ascii::String,
    }

    public fun a_sum(arg0: &VotingRecord) : u64 {
        (arg0.a_sum as u64)
    }

    public fun amount_in_a(arg0: &VotingRecord, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.a_amt_table, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.a_amt_table, arg1)
        } else {
            0
        }
    }

    public fun amount_in_b(arg0: &VotingRecord, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.b_amt_table, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.b_amt_table, arg1)
        } else {
            0
        }
    }

    public fun b_sum(arg0: &VotingRecord) : u64 {
        (arg0.b_sum as u64)
    }

    public entry fun claim_reward_a(arg0: &mut VotingRecord, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline, 0);
        assert!(arg0.version <= 1, 2);
        assert!(arg0.settled, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<VotingRecord>(arg0);
        if (arg0.winner || arg0.uncertain) {
            let v2 = 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.a_ins_table, v0);
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v2, v0);
            if (arg0.uncertain) {
                0x2::table::remove<address, u64>(&mut arg0.a_amt_table, v0);
            };
            let v3 = Withdraw{
                voting_id : v1,
                receiver  : v0,
                amount    : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v2),
                type      : 0x1::ascii::string(arg0.option_a),
            };
            0x2::event::emit<Withdraw>(v3);
        };
        if (arg0.winner && !arg0.uncertain) {
            let v4 = 0x2::table::remove<address, u64>(&mut arg0.a_amt_table, v0);
            if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x1::vector::borrow<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.reward_ins, 0)) == v4) {
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x1::vector::pop_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.reward_ins), v0);
            } else {
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(0x1::vector::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.reward_ins, 0), v4, arg2), v0);
            };
            let v5 = ClaimReward{
                voting_id : v1,
                receiver  : v0,
                amount    : v4,
                type      : 0x1::ascii::string(arg0.option_b),
            };
            0x2::event::emit<ClaimReward>(v5);
        };
    }

    public entry fun claim_reward_b(arg0: &mut VotingRecord, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline, 0);
        assert!(arg0.version <= 1, 2);
        assert!(arg0.settled, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<VotingRecord>(arg0);
        if (!arg0.winner || arg0.uncertain) {
            let v2 = 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.b_ins_table, v0);
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v2, v0);
            if (arg0.uncertain) {
                0x2::table::remove<address, u64>(&mut arg0.b_amt_table, v0);
            };
            let v3 = Withdraw{
                voting_id : v1,
                receiver  : v0,
                amount    : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v2),
                type      : 0x1::ascii::string(arg0.option_b),
            };
            0x2::event::emit<Withdraw>(v3);
        };
        if (!arg0.winner && !arg0.uncertain) {
            let v4 = 0x2::table::remove<address, u64>(&mut arg0.b_amt_table, v0);
            if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x1::vector::borrow<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.reward_ins, 0)) == v4) {
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x1::vector::pop_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.reward_ins), v0);
            } else {
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(0x1::vector::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.reward_ins, 0), v4, arg2), v0);
            };
            let v5 = ClaimReward{
                voting_id : v1,
                receiver  : v0,
                amount    : v4,
                type      : 0x1::ascii::string(arg0.option_a),
            };
            0x2::event::emit<ClaimReward>(v5);
        };
    }

    public fun ddl(arg0: &VotingRecord) : u64 {
        arg0.deadline
    }

    public entry fun deploy_w_kc(arg0: &mut 0x2::coin::Coin<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>, arg1: &mut 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::stake::StakePool, arg2: &mut DeployRecord, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::stake::pay_w_kartcoin(arg0, 100000000000, arg1, arg10);
        do_deploy(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun deploy_w_ks(arg0: &mut 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription, arg1: &mut 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::stake::StakePool, arg2: &mut DeployRecord, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::stake::pay_w_kartscription(arg0, 100000000000, arg1, arg10);
        do_deploy(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun description(arg0: &VotingRecord) : 0x1::string::String {
        arg0.description
    }

    public fun description_a(arg0: &VotingRecord) : 0x1::string::String {
        arg0.description_a
    }

    public fun description_b(arg0: &VotingRecord) : 0x1::string::String {
        arg0.description_b
    }

    fun do_deploy(arg0: &mut DeployRecord, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = new_voting_record(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = 0x2::object::id<VotingRecord>(&v1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.open, v2, true);
        let v3 = VotingSettleCap{
            id : 0x2::object::new(arg8),
            to : v2,
        };
        0x2::transfer::public_transfer<VotingSettleCap>(v3, v0);
        let v4 = DeployVoting{
            voting_id : v2,
            sender    : v0,
        };
        0x2::event::emit<DeployVoting>(v4);
        0x2::transfer::share_object<VotingRecord>(v1);
    }

    fun do_set_uncertain(arg0: &mut DeployRecord, arg1: &mut VotingRecord, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version <= 1, 2);
        let v0 = 0x2::table_vec::length<address>(&arg1.a_queue);
        while (v0 > 0) {
            0x2::table_vec::pop_back<address>(&mut arg1.a_queue);
            v0 = v0 - 1;
        };
        let v1 = 0x2::table_vec::length<address>(&arg1.b_queue);
        while (v1 > 0) {
            0x2::table_vec::pop_back<address>(&mut arg1.b_queue);
            v1 = v1 - 1;
        };
        let v2 = 0x2::object::id<VotingRecord>(arg1);
        arg1.settled = true;
        arg1.uncertain = true;
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.open, v2);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg0.finished, v2);
        let v3 = SettleVote{
            set_to : v2,
            sender : 0x2::tx_context::sender(arg2),
            result : 0x1::ascii::string(b"UnCertain"),
        };
        0x2::event::emit<SettleVote>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = DeployRecord{
            id       : 0x2::object::new(arg0),
            version  : 1,
            finished : 0x2::table_vec::empty<0x2::object::ID>(arg0),
            open     : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<DeployRecord>(v1);
        let v2 = ProtocalBank{
            id          : 0x2::object::new(arg0),
            ms_type     : 0x2::table_vec::empty<0x1::ascii::String>(arg0),
            ms_balance  : 0x2::table::new<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg0),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<ProtocalBank>(v2);
        let v3 = ProtocalBankCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ProtocalBankCap>(v3, v0);
        let v4 = UpgradeBank{
            id          : 0x2::object::new(arg0),
            ms_type     : 0x2::table_vec::empty<0x1::ascii::String>(arg0),
            ms_balance  : 0x2::table::new<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg0),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<UpgradeBank>(v4);
        let v5 = UpgradeBankCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<UpgradeBankCap>(v5, v0);
    }

    fun inject_ms_to_protocalbank(arg0: &mut ProtocalBank, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription) {
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick(&arg1);
        if (!0x2::table::contains<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.ms_balance, v0)) {
            0x2::table::add<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.ms_balance, v0, arg1);
            0x2::table_vec::push_back<0x1::ascii::String>(&mut arg0.ms_type, v0);
        } else {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(0x2::table::borrow_mut<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.ms_balance, v0), arg1);
        };
    }

    fun inject_ms_to_upgradebank(arg0: &mut UpgradeBank, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription) {
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick(&arg1);
        if (!0x2::table::contains<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.ms_balance, v0)) {
            0x2::table::add<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.ms_balance, v0, arg1);
            0x2::table_vec::push_back<0x1::ascii::String>(&mut arg0.ms_type, v0);
        } else {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(0x2::table::borrow_mut<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.ms_balance, v0), arg1);
        };
    }

    fun new_voting_record(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : VotingRecord {
        assert!(arg5 - 0x2::clock::timestamp_ms(arg6) > 86400000, 0);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg1);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg2);
        VotingRecord{
            id            : 0x2::object::new(arg7),
            version       : 1,
            description   : 0x1::string::utf8(arg0),
            option_a      : arg1,
            option_b      : arg2,
            description_a : 0x1::string::utf8(arg3),
            description_b : 0x1::string::utf8(arg4),
            deadline      : arg5,
            settled       : false,
            winner        : false,
            burn          : false,
            uncertain     : false,
            a_queue       : 0x2::table_vec::empty<address>(arg7),
            b_queue       : 0x2::table_vec::empty<address>(arg7),
            a_ins_table   : 0x2::table::new<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg7),
            b_ins_table   : 0x2::table::new<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg7),
            a_amt_table   : 0x2::table::new<address, u64>(arg7),
            b_amt_table   : 0x2::table::new<address, u64>(arg7),
            reward_ins    : 0x1::vector::empty<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(),
            reward_sui    : 0x2::balance::zero<0x2::sui::SUI>(),
            a_sum         : 0,
            b_sum         : 0,
        }
    }

    public fun option_a(arg0: &VotingRecord) : vector<u8> {
        arg0.option_a
    }

    public fun option_b(arg0: &VotingRecord) : vector<u8> {
        arg0.option_b
    }

    public entry fun set_uncertain_cap(arg0: VotingSettleCap, arg1: &mut DeployRecord, arg2: &mut VotingRecord, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.deadline, 0);
        assert!(arg0.to == 0x2::object::id<VotingRecord>(arg2), 4);
        assert!(!arg2.settled, 5);
        let VotingSettleCap {
            id : v0,
            to : _,
        } = arg0;
        0x2::object::delete(v0);
        do_set_uncertain(arg1, arg2, arg4);
    }

    public entry fun set_uncertain_public(arg0: &mut DeployRecord, arg1: &mut VotingRecord, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.deadline + 2592000000, 0);
        assert!(!arg1.settled, 5);
        do_set_uncertain(arg0, arg1, arg3);
    }

    public entry fun settle_a_as_winner(arg0: VotingSettleCap, arg1: &mut DeployRecord, arg2: &mut VotingRecord, arg3: &mut ProtocalBank, arg4: &mut UpgradeBank, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.to == 0x2::object::id<VotingRecord>(arg2), 4);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg2.deadline, 0);
        assert!(arg2.version <= 1, 2);
        let VotingSettleCap {
            id : v0,
            to : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = 0x2::table_vec::length<address>(&arg2.b_queue);
        if (v2 > 0) {
            let v3 = 0x2::table_vec::pop_back<address>(&mut arg2.b_queue);
            let v4 = 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg2.b_ins_table, v3);
            0x2::table::remove<address, u64>(&mut arg2.b_amt_table, v3);
            let v5 = v2 - 1;
            while (v5 > 0) {
                let v6 = 0x2::table_vec::pop_back<address>(&mut arg2.b_queue);
                0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(&mut v4, 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg2.b_ins_table, v6));
                0x2::table::remove<address, u64>(&mut arg2.b_amt_table, v6);
                v5 = v5 - 1;
            };
            0x1::vector::push_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg2.reward_ins, v4);
        };
        if (arg2.b_sum > 0) {
            let v7 = arg2.b_sum * 25 / 1000;
            arg2.b_sum = arg2.b_sum - 2 * v7;
            let v8 = 0;
            let v9 = 0x2::table_vec::length<address>(&arg2.a_queue);
            while (v9 > 0) {
                let v10 = 0x2::table::borrow_mut<address, u64>(&mut arg2.a_amt_table, 0x2::table_vec::pop_back<address>(&mut arg2.a_queue));
                *v10 = (((*v10 as u128) * arg2.b_sum / arg2.a_sum) as u64);
                v8 = v8 + *v10;
                v9 = v9 - 1;
            };
            let v11 = (v7 as u64);
            let v12 = (arg2.b_sum as u64) - v8;
            let v13 = 0x1::vector::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg2.reward_ins, 0);
            if (v11 > 0) {
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(v13, v11, arg6), 0x2::tx_context::sender(arg6));
                inject_ms_to_protocalbank(arg3, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(v13, v11, arg6));
            };
            if (v12 > 0) {
                inject_ms_to_upgradebank(arg4, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(v13, v12, arg6));
            };
        };
        arg2.settled = true;
        arg2.winner = true;
        arg2.uncertain = false;
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.open, v1);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg1.finished, v1);
        let v14 = SettleVote{
            set_to : v1,
            sender : 0x2::tx_context::sender(arg6),
            result : 0x1::ascii::string(arg2.option_a),
        };
        0x2::event::emit<SettleVote>(v14);
    }

    public entry fun settle_b_as_winner(arg0: VotingSettleCap, arg1: &mut DeployRecord, arg2: &mut VotingRecord, arg3: &mut ProtocalBank, arg4: &mut UpgradeBank, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.to == 0x2::object::id<VotingRecord>(arg2), 4);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg2.deadline, 0);
        assert!(arg2.version <= 1, 2);
        let VotingSettleCap {
            id : v0,
            to : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = 0x2::table_vec::length<address>(&arg2.a_queue);
        if (v2 > 0) {
            let v3 = 0x2::table_vec::pop_back<address>(&mut arg2.a_queue);
            let v4 = 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg2.a_ins_table, v3);
            0x2::table::remove<address, u64>(&mut arg2.a_amt_table, v3);
            let v5 = v2 - 1;
            while (v5 > 0) {
                let v6 = 0x2::table_vec::pop_back<address>(&mut arg2.a_queue);
                0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(&mut v4, 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg2.a_ins_table, v6));
                0x2::table::remove<address, u64>(&mut arg2.a_amt_table, v6);
                v5 = v5 - 1;
            };
            0x1::vector::push_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg2.reward_ins, v4);
        };
        if (arg2.a_sum > 0) {
            let v7 = arg2.a_sum * 25 / 1000;
            arg2.a_sum = arg2.a_sum - 2 * v7;
            let v8 = 0;
            let v9 = 0x2::table_vec::length<address>(&arg2.b_queue);
            while (v9 > 0) {
                let v10 = 0x2::table::borrow_mut<address, u64>(&mut arg2.b_amt_table, 0x2::table_vec::pop_back<address>(&mut arg2.b_queue));
                *v10 = (((*v10 as u128) * arg2.a_sum / arg2.b_sum) as u64);
                v8 = v8 + *v10;
                v9 = v9 - 1;
            };
            let v11 = (v7 as u64);
            let v12 = (arg2.a_sum as u64) - v8;
            let v13 = 0x1::vector::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg2.reward_ins, 0);
            if (v11 > 0) {
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(v13, v11, arg6), 0x2::tx_context::sender(arg6));
                inject_ms_to_protocalbank(arg3, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(v13, v11, arg6));
            };
            if (v12 > 0) {
                inject_ms_to_upgradebank(arg4, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(v13, v12, arg6));
            };
        };
        arg2.settled = true;
        arg2.winner = false;
        arg2.uncertain = false;
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.open, v1);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg1.finished, v1);
        let v14 = SettleVote{
            set_to : v1,
            sender : 0x2::tx_context::sender(arg6),
            result : 0x1::ascii::string(arg2.option_b),
        };
        0x2::event::emit<SettleVote>(v14);
    }

    public entry fun vote_a(arg0: &mut VotingRecord, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deadline >= 0x2::clock::timestamp_ms(arg2), 0);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::check_tick(&arg1, arg0.option_a), 1);
        assert!(arg0.version <= 1, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1);
        let v2 = Voting{
            vote_to : 0x2::object::id<VotingRecord>(arg0),
            voter   : v0,
            amount  : v1,
            type    : 0x1::ascii::string(arg0.option_a),
        };
        0x2::event::emit<Voting>(v2);
        if (0x2::table::contains<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.a_ins_table, v0)) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(0x2::table::borrow_mut<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.a_ins_table, v0), arg1);
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.a_amt_table, v0);
            *v3 = *v3 + v1;
        } else {
            0x2::table_vec::push_back<address>(&mut arg0.a_queue, v0);
            0x2::table::add<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.a_ins_table, v0, arg1);
            0x2::table::add<address, u64>(&mut arg0.a_amt_table, v0, v1);
        };
        arg0.a_sum = arg0.a_sum + (v1 as u128);
    }

    public entry fun vote_b(arg0: &mut VotingRecord, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deadline >= 0x2::clock::timestamp_ms(arg2), 0);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::check_tick(&arg1, arg0.option_b), 1);
        assert!(arg0.version <= 1, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1);
        let v2 = Voting{
            vote_to : 0x2::object::id<VotingRecord>(arg0),
            voter   : v0,
            amount  : v1,
            type    : 0x1::ascii::string(arg0.option_b),
        };
        0x2::event::emit<Voting>(v2);
        if (0x2::table::contains<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.b_ins_table, v0)) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(0x2::table::borrow_mut<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.b_ins_table, v0), arg1);
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.b_amt_table, v0);
            *v3 = *v3 + v1;
        } else {
            0x2::table_vec::push_back<address>(&mut arg0.b_queue, v0);
            0x2::table::add<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.b_ins_table, v0, arg1);
            0x2::table::add<address, u64>(&mut arg0.b_amt_table, v0, v1);
        };
        arg0.b_sum = arg0.b_sum + (v1 as u128);
    }

    public fun vote_in_a(arg0: &VotingRecord, arg1: address) : u64 {
        if (0x2::table::contains<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.a_ins_table, arg1)) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x2::table::borrow<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.a_ins_table, arg1))
        } else {
            0
        }
    }

    public fun vote_in_b(arg0: &VotingRecord, arg1: address) : u64 {
        if (0x2::table::contains<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.b_ins_table, arg1)) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x2::table::borrow<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.b_ins_table, arg1))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

