module 0x6fa140257b64ce019f1665230807d98042270b464ee04f961bb29431d090ce28::leaderboard {
    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        chakras: 0x6fa140257b64ce019f1665230807d98042270b464ee04f961bb29431d090ce28::big_vector::BigVector<ChakraID>,
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

    struct ChakraID has drop, store {
        points: u64,
    }

    public fun remove(arg0: u64, arg1: &mut Leaderboard) {
        assert!(arg1.is_frozen == false, 3);
        0x6fa140257b64ce019f1665230807d98042270b464ee04f961bb29431d090ce28::big_vector::remove<ChakraID>(&mut arg1.chakras, (arg0 as u128));
    }

    public fun add(arg0: &0x6fa140257b64ce019f1665230807d98042270b464ee04f961bb29431d090ce28::chakra::Chakra, arg1: &mut Leaderboard) {
        assert!(arg1.is_frozen == false, 3);
        let v0 = 0x6fa140257b64ce019f1665230807d98042270b464ee04f961bb29431d090ce28::chakra::points(arg0);
        let v1 = ChakraID{points: v0};
        0x6fa140257b64ce019f1665230807d98042270b464ee04f961bb29431d090ce28::big_vector::insert<ChakraID>(&mut arg1.chakras, (v0 as u128), v1);
    }

    public fun admin_freeze_leaderboard(arg0: &0x6fa140257b64ce019f1665230807d98042270b464ee04f961bb29431d090ce28::admin::AdminCap, arg1: Leaderboard, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.is_frozen == false, 2);
        assert!(arg1.is_initialized == true, 1);
        arg1.is_frozen = true;
        0x2::transfer::freeze_object<Leaderboard>(arg1);
    }

    public fun count(arg0: &Leaderboard) : u16 {
        (0x6fa140257b64ce019f1665230807d98042270b464ee04f961bb29431d090ce28::big_vector::length<ChakraID>(&arg0.chakras) as u16)
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
            chakras        : 0x6fa140257b64ce019f1665230807d98042270b464ee04f961bb29431d090ce28::big_vector::empty<ChakraID>(10, 10, arg0),
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

