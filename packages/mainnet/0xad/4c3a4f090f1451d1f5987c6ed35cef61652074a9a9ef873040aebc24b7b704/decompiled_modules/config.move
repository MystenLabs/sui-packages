module 0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        current_season: u8,
        whitelist: 0x2::vec_map::VecMap<address, 0x2::object::ID>,
    }

    public fun current_season(arg0: &Config) : u8 {
        arg0.current_season
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id             : 0x2::object::new(arg0),
            current_season : 0,
            whitelist      : 0x2::vec_map::empty<address, 0x2::object::ID>(),
        };
        0x2::transfer::public_share_object<Config>(v0);
    }

    public(friend) fun next_season(arg0: &mut Config) {
        arg0.current_season = arg0.current_season + 1;
    }

    // decompiled from Move bytecode v6
}

