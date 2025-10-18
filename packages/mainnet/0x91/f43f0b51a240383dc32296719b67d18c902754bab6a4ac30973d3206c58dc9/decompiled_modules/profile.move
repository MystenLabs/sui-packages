module 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile {
    struct PROFILE has drop {
        dummy_field: bool,
    }

    struct PlayerRegistry has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct PlayerProfile has store, key {
        id: 0x2::object::UID,
        ttt_wins: u64,
        ttt_losses: u64,
        ttt_draws: u64,
    }

    fun draw(arg0: &mut PlayerProfile) {
        arg0.ttt_draws = arg0.ttt_draws + 1;
    }

    public(friend) fun get_or_create_profile(arg0: &mut PlayerRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, v0)) {
            *0x2::table::borrow<address, 0x2::object::ID>(&arg0.profiles, v0)
        } else {
            let v2 = PlayerProfile{
                id         : 0x2::object::new(arg1),
                ttt_wins   : 0,
                ttt_losses : 0,
                ttt_draws  : 0,
            };
            0x2::dynamic_field::add<address, PlayerProfile>(&mut arg0.id, v0, v2);
            let v3 = 0x2::object::id<PlayerProfile>(0x2::dynamic_field::borrow<address, PlayerProfile>(&arg0.id, v0));
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.profiles, v0, v3);
            v3
        }
    }

    public(friend) fun get_profile_id(arg0: &PlayerRegistry, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.profiles, arg1)
    }

    fun init(arg0: PROFILE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerRegistry{
            id       : 0x2::object::new(arg1),
            profiles : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<PlayerRegistry>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PROFILE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun loss(arg0: &mut PlayerProfile) {
        arg0.ttt_losses = arg0.ttt_losses + 1;
    }

    public(friend) fun register_draw(arg0: &mut PlayerRegistry, arg1: address, arg2: address) {
        let v0 = 0x2::dynamic_field::borrow_mut<address, PlayerProfile>(&mut arg0.id, arg1);
        draw(v0);
        let v1 = 0x2::dynamic_field::borrow_mut<address, PlayerProfile>(&mut arg0.id, arg2);
        draw(v1);
    }

    public(friend) fun register_loss(arg0: &mut PlayerRegistry, arg1: address) {
        let v0 = 0x2::dynamic_field::borrow_mut<address, PlayerProfile>(&mut arg0.id, arg1);
        loss(v0);
    }

    public(friend) fun register_win(arg0: &mut PlayerRegistry, arg1: address) {
        let v0 = 0x2::dynamic_field::borrow_mut<address, PlayerProfile>(&mut arg0.id, arg1);
        win(v0);
    }

    fun win(arg0: &mut PlayerProfile) {
        arg0.ttt_wins = arg0.ttt_wins + 1;
    }

    // decompiled from Move bytecode v6
}

