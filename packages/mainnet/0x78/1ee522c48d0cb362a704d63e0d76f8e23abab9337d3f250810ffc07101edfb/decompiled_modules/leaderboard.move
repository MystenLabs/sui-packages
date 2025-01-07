module 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard {
    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        chakras: 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::BigVector<ChakraItem>,
        config: Config,
        is_initialized: bool,
        is_frozen: bool,
    }

    struct Config has store {
        total_users: u64,
        chakra_7: u8,
        chakra_6: u8,
        chakra_5: u8,
        chakra_4: u8,
        chakra_3: u8,
        chakra_2: u8,
        chakra_1: u8,
    }

    struct ChakraItem has drop, store {
        chakra_number: u64,
        points: u64,
    }

    public fun remove(arg0: u64, arg1: &mut Leaderboard) {
        assert!(arg1.is_frozen == false, 3);
        0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::remove<ChakraItem>(&mut arg1.chakras, 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::utils::encode_chakra_id(arg0, arg0));
    }

    public fun add(arg0: &0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::chakra::Chakra, arg1: &mut Leaderboard) {
        assert!(arg1.is_frozen == false, 3);
        let v0 = 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::chakra::points(arg0);
        let v1 = 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::chakra::number(arg0);
        let v2 = ChakraItem{
            chakra_number : v1,
            points        : v0,
        };
        0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::insert<ChakraItem>(&mut arg1.chakras, 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::utils::encode_chakra_id(v0, v1), v2);
    }

    public fun admin_freeze_leaderboard(arg0: &0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::admin::AdminCap, arg1: Leaderboard, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.is_frozen == false, 2);
        assert!(arg1.is_initialized == true, 1);
        arg1.is_frozen = true;
        0x2::transfer::freeze_object<Leaderboard>(arg1);
    }

    public fun count(arg0: &Leaderboard) : u16 {
        (0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::length<ChakraItem>(&arg0.chakras) as u16)
    }

    public fun find_rank(arg0: &Leaderboard, arg1: u64, arg2: u64) : u64 {
        assert!(arg0.is_initialized == true, 1);
        let v0 = 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::utils::encode_chakra_id(arg1, arg2);
        let (v1, v2) = 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::slice_following<ChakraItem>(&arg0.chakras, v0);
        let v3 = v2;
        let v4 = v1;
        if (0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::slice_is_null(&v4)) {
            return 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::length<ChakraItem>(&arg0.chakras) + 1
        };
        let v5 = 1;
        loop {
            let v6 = 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::borrow_slice<ChakraItem>(&arg0.chakras, v4);
            while (v3 < 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::slice_length<ChakraItem>(v6)) {
                if (0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::slice_key<ChakraItem>(v6, v3) == v0) {
                    return v5
                };
                v5 = v5 + 1;
                v3 = v3 + 1;
            };
            let v7 = 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::slice_next<ChakraItem>(v6);
            if (0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::slice_is_null(&v7)) {
                break
            };
            let (v8, v9) = 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::next_slice<ChakraItem>(&arg0.chakras, v4, v3);
            v4 = v8;
            v3 = v9;
        };
        v5
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            total_users : 0,
            chakra_7    : 1,
            chakra_6    : 3,
            chakra_5    : 6,
            chakra_4    : 10,
            chakra_3    : 15,
            chakra_2    : 25,
            chakra_1    : 40,
        };
        let v1 = Leaderboard{
            id             : 0x2::object::new(arg0),
            chakras        : 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::big_vector::empty<ChakraItem>(10, 10, arg0),
            config         : v0,
            is_initialized : true,
            is_frozen      : false,
        };
        0x2::transfer::public_share_object<Leaderboard>(v1);
    }

    public fun is_frozen(arg0: &Leaderboard) : bool {
        arg0.is_frozen
    }

    public fun is_initialized(arg0: &Leaderboard) : bool {
        arg0.is_initialized
    }

    // decompiled from Move bytecode v6
}

