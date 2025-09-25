module 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::distribute_cap {
    struct DISTRIBUTE_CAP has drop {
        dummy_field: bool,
    }

    struct DistributeCap has store, key {
        id: 0x2::object::UID,
        voter_id: 0x2::object::ID,
        who: 0x2::object::ID,
    }

    public fun create(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : DistributeCap {
        assert!(0x2::package::from_module<DISTRIBUTE_CAP>(arg0), 43646573017044340);
        DistributeCap{
            id       : 0x2::object::new(arg3),
            voter_id : arg1,
            who      : arg2,
        }
    }

    public(friend) fun create_internal(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : DistributeCap {
        DistributeCap{
            id       : 0x2::object::new(arg1),
            voter_id : arg0,
            who      : 0x2::object::id_from_address(0x2::tx_context::sender(arg1)),
        }
    }

    fun init(arg0: DISTRIBUTE_CAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DISTRIBUTE_CAP>(arg0, arg1);
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun validate_distribute_voter_id(arg0: &DistributeCap, arg1: 0x2::object::ID) {
        assert!(arg0.voter_id == arg1, 421990001503268030);
    }

    public fun voter_id(arg0: &DistributeCap) : 0x2::object::ID {
        arg0.voter_id
    }

    public fun who(arg0: &DistributeCap) : 0x2::object::ID {
        arg0.who
    }

    // decompiled from Move bytecode v6
}

