module 0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::leaderboard {
    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        chakras: 0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::skip_list::SkipList<ChakraID>,
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
        chakra_id: 0x2::object::ID,
    }

    public(friend) fun add(arg0: &0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::chakra::Chakra, arg1: &mut Leaderboard) {
        assert!(arg1.is_frozen == false, 3);
        let v0 = 0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::chakra::points(arg0);
        let v1 = ChakraID{chakra_id: 0x2::object::id<0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::chakra::Chakra>(arg0)};
        if (0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::skip_list::contains<ChakraID>(&arg1.chakras, v0)) {
            0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::skip_list::remove<ChakraID>(&mut arg1.chakras, v0);
        };
        0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::skip_list::insert<ChakraID>(&mut arg1.chakras, v0, v1);
    }

    public fun admin_freeze_leaderboard(arg0: &0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::admin::AdminCap, arg1: Leaderboard, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.is_frozen == false, 2);
        assert!(arg1.is_initialized == true, 1);
        arg1.is_frozen = true;
        0x2::transfer::freeze_object<Leaderboard>(arg1);
    }

    public(friend) fun count(arg0: &Leaderboard) : u16 {
        (0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::skip_list::length<ChakraID>(&arg0.chakras) as u16)
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
            chakras        : 0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::skip_list::new<ChakraID>(20, 40, 1243618, arg0),
            config         : v0,
            is_initialized : true,
            is_frozen      : false,
        };
        0x2::transfer::public_share_object<Leaderboard>(v1);
    }

    public(friend) fun is_frozen(arg0: &Leaderboard) : bool {
        arg0.is_frozen
    }

    public(friend) fun is_initialized(arg0: &Leaderboard) : bool {
        arg0.is_initialized
    }

    // decompiled from Move bytecode v6
}

