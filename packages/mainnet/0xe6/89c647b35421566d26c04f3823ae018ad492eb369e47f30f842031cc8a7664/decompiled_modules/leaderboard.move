module 0xe689c647b35421566d26c04f3823ae018ad492eb369e47f30f842031cc8a7664::leaderboard {
    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        chakras: 0xe689c647b35421566d26c04f3823ae018ad492eb369e47f30f842031cc8a7664::big_vector::BigVector<ChakraID>,
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
        points: u64,
    }

    public fun add(arg0: &0xe689c647b35421566d26c04f3823ae018ad492eb369e47f30f842031cc8a7664::chakra::Chakra, arg1: &mut Leaderboard) {
        assert!(arg1.is_frozen == false, 3);
        let v0 = 0xe689c647b35421566d26c04f3823ae018ad492eb369e47f30f842031cc8a7664::chakra::points(arg0);
        let v1 = ChakraID{
            chakra_id : 0x2::object::id<0xe689c647b35421566d26c04f3823ae018ad492eb369e47f30f842031cc8a7664::chakra::Chakra>(arg0),
            points    : v0,
        };
        0xe689c647b35421566d26c04f3823ae018ad492eb369e47f30f842031cc8a7664::big_vector::insert<ChakraID>(&mut arg1.chakras, (v0 as u128), v1);
    }

    public fun admin_freeze_leaderboard(arg0: &0xe689c647b35421566d26c04f3823ae018ad492eb369e47f30f842031cc8a7664::admin::AdminCap, arg1: Leaderboard, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.is_frozen == false, 2);
        assert!(arg1.is_initialized == true, 1);
        arg1.is_frozen = true;
        0x2::transfer::freeze_object<Leaderboard>(arg1);
    }

    public fun count(arg0: &Leaderboard) : u16 {
        (0xe689c647b35421566d26c04f3823ae018ad492eb369e47f30f842031cc8a7664::big_vector::length<ChakraID>(&arg0.chakras) as u16)
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
            chakras        : 0xe689c647b35421566d26c04f3823ae018ad492eb369e47f30f842031cc8a7664::big_vector::empty<ChakraID>(10, 10, arg0),
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

