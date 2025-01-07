module 0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::mining {
    struct Block has store, key {
        id: 0x2::object::UID,
        previous_hash: vector<u8>,
        salt: u64,
        meta: vector<u8>,
        payload: vector<u8>,
        timestamp: u64,
        target: u256,
        nonce: u64,
        miner: address,
        hash: vector<u8>,
    }

    struct BlockInfo has store {
        previous_hash: vector<u8>,
        salt: u64,
        target: u256,
    }

    struct BlockStore has store, key {
        id: 0x2::object::UID,
        blocks: 0x2::table::Table<u64, Block>,
        current_height: u64,
        current_salt: u64,
        current_target: u256,
    }

    struct BlockMinted has copy, drop {
        block_id: 0x2::object::ID,
        height: u64,
    }

    struct DifficultyAdjusted has copy, drop {
        height: u64,
        target: u256,
        previous_time: u64,
        previous_target: u256,
    }

    entry fun mint(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut BlockStore, arg3: &mut 0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::meta::Treasury, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        mint_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, true, arg8);
    }

    fun adjust_difficulty(arg0: &mut BlockStore) {
        if (arg0.current_height % 256 == 0) {
            let v0 = 0x2::table::borrow<u64, Block>(&arg0.blocks, arg0.current_height - 1).timestamp - 0x2::table::borrow<u64, Block>(&arg0.blocks, arg0.current_height - 256).timestamp;
            arg0.current_target = 0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::utils::median_to_max(arg0.current_target, 0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::utils::adjust_difficulty_by_diff(arg0.current_target, (256 as u256) * (600000 as u256), (v0 as u256)));
            let (_, v2) = 0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::utils::u256_try_divide_and_round_up((v0 as u256), (256 as u256));
            let v3 = DifficultyAdjusted{
                height          : arg0.current_height,
                target          : arg0.current_target,
                previous_time   : (v2 as u64),
                previous_target : arg0.current_target,
            };
            0x2::event::emit<DifficultyAdjusted>(v3);
        };
    }

    public fun borrow_block_by_height(arg0: &BlockStore, arg1: u64) : &Block {
        0x2::table::borrow<u64, Block>(&arg0.blocks, arg1)
    }

    fun distribute_reward(arg0: &BlockStore, arg1: &mut 0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::meta::Treasury, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::meta::mint(arg1, arg2, (0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::utils::u256_try_mul_div_down(50, 0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::utils::u256_pow(10, 0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::meta::decimals()), 0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::utils::u256_pow(2, ((arg0.current_height / 210000) as u8))) as u64), arg3);
    }

    public fun get_block_hash(arg0: &Block) : vector<u8> {
        arg0.hash
    }

    public fun get_block_info(arg0: &BlockStore) : BlockInfo {
        BlockInfo{
            previous_hash : get_previous_hash(arg0),
            salt          : get_current_salt(arg0),
            target        : get_current_target(arg0),
        }
    }

    public fun get_block_meta(arg0: &Block) : vector<u8> {
        arg0.meta
    }

    public fun get_block_nonce(arg0: &Block) : u64 {
        arg0.nonce
    }

    public fun get_block_payload(arg0: &Block) : vector<u8> {
        arg0.payload
    }

    public fun get_block_previous_hash(arg0: &Block) : vector<u8> {
        arg0.previous_hash
    }

    public fun get_block_salt(arg0: &Block) : u64 {
        arg0.salt
    }

    public fun get_block_target(arg0: &Block) : u256 {
        arg0.target
    }

    public fun get_current_height(arg0: &BlockStore) : u64 {
        arg0.current_height
    }

    fun get_current_salt(arg0: &BlockStore) : u64 {
        arg0.current_salt
    }

    public fun get_current_target(arg0: &BlockStore) : u256 {
        arg0.current_target
    }

    public fun get_initial_target() : u256 {
        20562864055434932597950784049314941701042710049789887045981025561189558
    }

    fun get_previous_hash(arg0: &BlockStore) : vector<u8> {
        if (arg0.current_height == 0) {
            return 0x1::vector::empty<u8>()
        };
        borrow_block_by_height(arg0, arg0.current_height - 1).hash
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockStore{
            id             : 0x2::object::new(arg0),
            blocks         : 0x2::table::new<u64, Block>(arg0),
            current_height : 0,
            current_salt   : 0,
            current_target : 20562864055434932597950784049314941701042710049789887045981025561189558,
        };
        0x2::transfer::public_share_object<BlockStore>(v0);
        let v1 = DifficultyAdjusted{
            height          : 0,
            target          : 20562864055434932597950784049314941701042710049789887045981025561189558,
            previous_time   : 0,
            previous_target : 20562864055434932597950784049314941701042710049789887045981025561189558,
        };
        0x2::event::emit<DifficultyAdjusted>(v1);
    }

    public entry fun init_genesis(arg0: &0x2::clock::Clock, arg1: &mut BlockStore, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.current_height == 0, 1);
        let v0 = Block{
            id            : 0x2::object::new(arg2),
            previous_hash : b"genesis_previous_hash",
            salt          : 0,
            meta          : 0x1::vector::empty<u8>(),
            payload       : b"initial_merkle_root",
            timestamp     : 0x2::clock::timestamp_ms(arg0),
            target        : arg1.current_target,
            nonce         : 0,
            miner         : 0x2::tx_context::sender(arg2),
            hash          : b"genesis_hash",
        };
        0x2::table::add<u64, Block>(&mut arg1.blocks, 0, v0);
        arg1.current_height = 1;
    }

    public fun is_valid_hash(arg0: vector<u8>, arg1: u256) : bool {
        0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::utils::vector_to_u256(arg0) <= arg1
    }

    fun mint_internal(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut BlockStore, arg3: &mut 0x62a49d18e8e9e386b353926dd567a96fe4e68adf2b835d8cee5114bd97a1f64::meta::Treasury, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: address, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg4) <= 4096, 2);
        assert!(0x1::vector::length<u8>(&arg5) <= 4194304, 3);
        let BlockInfo {
            previous_hash : v0,
            salt          : v1,
            target        : v2,
        } = get_block_info(arg2);
        let v3 = v1;
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v4, v0);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v3));
        0x1::vector::append<u8>(&mut v4, arg4);
        0x1::vector::append<u8>(&mut v4, arg5);
        let v5 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v5, 0x2::hash::keccak256(&v4));
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<u64>(&arg6));
        let v6 = 0x2::hash::keccak256(&v5);
        if (arg8) {
            assert!(is_valid_hash(v6, v2), 1);
        };
        let v7 = Block{
            id            : 0x2::object::new(arg9),
            previous_hash : v0,
            salt          : v3,
            meta          : arg4,
            payload       : arg5,
            timestamp     : 0x2::clock::timestamp_ms(arg0),
            target        : v2,
            nonce         : arg6,
            miner         : arg7,
            hash          : v6,
        };
        let v8 = BlockMinted{
            block_id : 0x2::object::uid_to_inner(&v7.id),
            height   : arg2.current_height,
        };
        0x2::event::emit<BlockMinted>(v8);
        0x2::table::add<u64, Block>(&mut arg2.blocks, arg2.current_height, v7);
        arg2.current_height = arg2.current_height + 1;
        distribute_reward(arg2, arg3, arg7, arg9);
        adjust_difficulty(arg2);
        update_next_block_salt(arg2, arg1, arg9);
    }

    fun update_next_block_salt(arg0: &mut BlockStore, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        arg0.current_salt = 0x2::random::generate_u64(&mut v0);
    }

    // decompiled from Move bytecode v6
}

