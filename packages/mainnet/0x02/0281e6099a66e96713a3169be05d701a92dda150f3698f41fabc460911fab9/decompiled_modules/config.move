module 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        treasury: address,
        players: 0x2::table::Table<address, bool>,
        public_key: vector<u8>,
    }

    public fun admin_set_public_key(arg0: &0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::admin::AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    public fun admin_set_treasury(arg0: &0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::admin::AdminCap, arg1: &mut Config, arg2: address) {
        arg1.treasury = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id         : 0x2::object::new(arg0),
            treasury   : @0x92ffef1604c7be3724993867b02879532fa7f30539d8da9237c0294efae6ff5b,
            players    : 0x2::table::new<address, bool>(arg0),
            public_key : x"bf5e76731e5dfc3e59cf38edfdf6949722be6d3a12cbb7ea50e02584fff945c0",
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun players(arg0: &Config) : &0x2::table::Table<address, bool> {
        &arg0.players
    }

    public(friend) fun players_mut(arg0: &mut Config) : &mut 0x2::table::Table<address, bool> {
        &mut arg0.players
    }

    public fun public_key(arg0: &Config) : vector<u8> {
        arg0.public_key
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v6
}

