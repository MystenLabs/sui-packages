module 0xf243a874cf162ddfb36ed2418cbb1a1bab3b048c8549c85a16fdef8c6019b7a7::mining {
    struct MiningState<phantom T0> has key {
        id: 0x2::object::UID,
        height: u64,
        last_hash: vector<u8>,
        last_timestamp_ms: u64,
        difficulty: u256,
        total_mined: u64,
        genesis_timestamp_ms: u64,
        epoch_start_height: u64,
        epoch_start_timestamp_ms: u64,
        treasury: 0x2::coin::TreasuryCap<T0>,
    }

    struct Block has copy, drop, store {
        height: u64,
        prev_hash: vector<u8>,
        hash: vector<u8>,
        timestamp_ms: u64,
        miner: address,
        nonce: u64,
        difficulty: u256,
        reward: u64,
    }

    struct BlockMined has copy, drop {
        height: u64,
        hash: vector<u8>,
        miner: address,
        nonce: u64,
        difficulty: u256,
        timestamp_ms: u64,
        reward: u64,
    }

    public fun adjustment_interval() : u64 {
        60
    }

    fun be_bytes_to_u256(arg0: &vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(arg0) == 32, 5);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun block_difficulty(arg0: &Block) : u256 {
        arg0.difficulty
    }

    public fun block_hash(arg0: &Block) : vector<u8> {
        arg0.hash
    }

    public fun block_height(arg0: &Block) : u64 {
        arg0.height
    }

    public fun block_miner(arg0: &Block) : address {
        arg0.miner
    }

    public fun block_nonce(arg0: &Block) : u64 {
        arg0.nonce
    }

    public fun block_preimage(arg0: u64, arg1: &vector<u8>, arg2: u64, arg3: address, arg4: u64, arg5: u256) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg1) == 32, 6);
        let v0 = u64_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg4));
        0x1::vector::append<u8>(&mut v0, u256_to_be_bytes(arg5));
        v0
    }

    public fun block_prev_hash(arg0: &Block) : vector<u8> {
        arg0.prev_hash
    }

    public fun block_reward(arg0: &Block) : u64 {
        arg0.reward
    }

    public fun block_timestamp_ms(arg0: &Block) : u64 {
        arg0.timestamp_ms
    }

    public fun blocks_until_adjustment<T0>(arg0: &MiningState<T0>) : u64 {
        60 - arg0.height % 60
    }

    public fun compute_hash(arg0: u64, arg1: &vector<u8>, arg2: u64, arg3: address, arg4: u64, arg5: u256) : vector<u8> {
        0x1::hash::sha2_256(0x1::hash::sha2_256(block_preimage(arg0, arg1, arg2, arg3, arg4, arg5)))
    }

    public fun compute_next_difficulty(arg0: u256, arg1: u64) : u256 {
        assert!(arg0 >= 1, 0);
        let v0 = if (arg1 == 0) {
            1
        } else {
            arg1
        };
        let v1 = (3600000 as u256);
        let v2 = if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 * v1 / (v0 as u256)
        };
        let v3 = v2;
        let v4 = arg0 / 4;
        let v5 = if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / 4) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 * 4
        };
        if (v2 < v4) {
            v3 = v4;
        };
        if (v3 > v5) {
            v3 = v5;
        };
        if (v3 < 1) {
            v3 = 1;
        };
        v3
    }

    public(friend) fun create_and_share<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = @0x0;
        let v2 = zero_hash();
        let v3 = 0;
        let v4 = 4295032833;
        let v5 = compute_hash(0, &v2, v0, v1, v3, v4);
        let v6 = MiningState<T0>{
            id                       : 0x2::object::new(arg1),
            height                   : 0,
            last_hash                : v5,
            last_timestamp_ms        : v0,
            difficulty               : v4,
            total_mined              : 0,
            genesis_timestamp_ms     : v0,
            epoch_start_height       : 0,
            epoch_start_timestamp_ms : v0,
            treasury                 : arg0,
        };
        let v7 = Block{
            height       : 0,
            prev_hash    : v2,
            hash         : v5,
            timestamp_ms : v0,
            miner        : v1,
            nonce        : v3,
            difficulty   : v4,
            reward       : 0,
        };
        0x2::dynamic_field::add<u64, Block>(&mut v6.id, 0, v7);
        0x2::transfer::share_object<MiningState<T0>>(v6);
    }

    public fun current_reward<T0>(arg0: &MiningState<T0>) : u64 {
        reward_capped(arg0.height + 1, arg0.total_mined)
    }

    public fun difficulty<T0>(arg0: &MiningState<T0>) : u256 {
        arg0.difficulty
    }

    public fun epoch_start_height<T0>(arg0: &MiningState<T0>) : u64 {
        arg0.epoch_start_height
    }

    public fun epoch_start_timestamp_ms<T0>(arg0: &MiningState<T0>) : u64 {
        arg0.epoch_start_timestamp_ms
    }

    public fun genesis_timestamp_ms<T0>(arg0: &MiningState<T0>) : u64 {
        arg0.genesis_timestamp_ms
    }

    public fun get_block<T0>(arg0: &MiningState<T0>, arg1: u64) : Block {
        assert!(has_block<T0>(arg0, arg1), 7);
        *0x2::dynamic_field::borrow<u64, Block>(&arg0.id, arg1)
    }

    public fun has_block<T0>(arg0: &MiningState<T0>, arg1: u64) : bool {
        0x2::dynamic_field::exists_with_type<u64, Block>(&arg0.id, arg1)
    }

    public fun height<T0>(arg0: &MiningState<T0>) : u64 {
        arg0.height
    }

    public fun initial_difficulty() : u256 {
        4295032833
    }

    public fun initial_reward() : u64 {
        5000000000
    }

    public fun is_valid_hash(arg0: &vector<u8>, arg1: u256) : bool {
        if (arg1 == 0) {
            return false
        };
        if (0x1::vector::length<u8>(arg0) != 32) {
            return false
        };
        be_bytes_to_u256(arg0) <= pow_target(arg1)
    }

    public fun last_hash<T0>(arg0: &MiningState<T0>) : vector<u8> {
        arg0.last_hash
    }

    public fun last_timestamp_ms<T0>(arg0: &MiningState<T0>) : u64 {
        arg0.last_timestamp_ms
    }

    public fun max_supply() : u64 {
        2100000000000000
    }

    public fun pow_target(arg0: u256) : u256 {
        assert!(arg0 > 0, 0);
        115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg0
    }

    fun reward_capped(arg0: u64, arg1: u64) : u64 {
        let v0 = reward_for_height(arg0);
        let v1 = v0;
        if (arg1 >= 2100000000000000) {
            return 0
        };
        let v2 = 2100000000000000 - arg1;
        if (v0 > v2) {
            v1 = v2;
        };
        v1
    }

    public fun reward_for_height(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 - 1) / 210000;
        if (v0 >= 64) {
            0
        } else {
            5000000000 >> (v0 as u8)
        }
    }

    public fun submit<T0>(arg0: &mut MiningState<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg3 >= arg0.last_timestamp_ms, 2);
        assert!(arg3 <= v1 + 15000, 3);
        assert!(v1 <= arg3 + 120000, 4);
        assert!(arg0.difficulty > 0, 0);
        assert!(0x1::vector::length<u8>(&arg0.last_hash) == 32, 6);
        let v2 = arg0.height + 1;
        let v3 = arg0.last_hash;
        let v4 = arg0.difficulty;
        let v5 = compute_hash(v2, &v3, arg3, v0, arg2, v4);
        assert!(is_valid_hash(&v5, v4), 1);
        let v6 = reward_capped(v2, arg0.total_mined);
        let v7 = Block{
            height       : v2,
            prev_hash    : v3,
            hash         : v5,
            timestamp_ms : arg3,
            miner        : v0,
            nonce        : arg2,
            difficulty   : v4,
            reward       : v6,
        };
        0x2::dynamic_field::add<u64, Block>(&mut arg0.id, v2, v7);
        let v8 = BlockMined{
            height       : v2,
            hash         : v5,
            miner        : v0,
            nonce        : arg2,
            difficulty   : v4,
            timestamp_ms : arg3,
            reward       : v6,
        };
        0x2::event::emit<BlockMined>(v8);
        arg0.height = v2;
        arg0.last_hash = v5;
        arg0.last_timestamp_ms = arg3;
        arg0.total_mined = arg0.total_mined + v6;
        if (v2 % 60 == 0) {
            arg0.difficulty = compute_next_difficulty(v4, arg3 - arg0.epoch_start_timestamp_ms);
            arg0.epoch_start_height = v2;
            arg0.epoch_start_timestamp_ms = arg3;
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury, v6, arg4), v0);
        };
    }

    public fun target_block_time_ms() : u64 {
        60000
    }

    public fun total_mined<T0>(arg0: &MiningState<T0>) : u64 {
        arg0.total_mined
    }

    public fun treasury_supply<T0>(arg0: &MiningState<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury)
    }

    fun u256_to_be_bytes(arg0: u256) : vector<u8> {
        let v0 = b"";
        let v1 = 32;
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> ((v1 * 8) as u8) & 255) as u8));
        };
        v0
    }

    fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 & 255) as u8));
        v0
    }

    fun zero_hash() : vector<u8> {
        x"0000000000000000000000000000000000000000000000000000000000000000"
    }

    // decompiled from Move bytecode v7
}

