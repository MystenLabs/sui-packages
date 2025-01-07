module 0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::leaderboard {
    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        chakras: 0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::big_vector::BigVector<ChakraItem>,
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
        0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::big_vector::remove<ChakraItem>(&mut arg1.chakras, (arg0 as u128));
    }

    public fun add(arg0: &0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::chakra::Chakra, arg1: &mut Leaderboard) {
        assert!(arg1.is_frozen == false, 3);
        let v0 = 0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::chakra::points(arg0);
        let v1 = 0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::chakra::number(arg0);
        let v2 = ChakraItem{
            chakra_number : v1,
            points        : v0,
        };
        0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::big_vector::insert<ChakraItem>(&mut arg1.chakras, 0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::utils::encode_chakra_id(v0, v1), v2);
    }

    public fun admin_freeze_leaderboard(arg0: &0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::admin::AdminCap, arg1: Leaderboard, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.is_frozen == false, 2);
        assert!(arg1.is_initialized == true, 1);
        arg1.is_frozen = true;
        0x2::transfer::freeze_object<Leaderboard>(arg1);
    }

    public fun count(arg0: &Leaderboard) : u16 {
        (0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::big_vector::length<ChakraItem>(&arg0.chakras) as u16)
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
            chakras        : 0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::big_vector::empty<ChakraItem>(10, 10, arg0),
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

