module 0xd2aa087e42a7c18e3b1dabdf141025d73ee3422e4442a93c64b4f7a34d8b7cf3::player_profile {
    struct GameAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NautilusProfile has key {
        id: 0x2::object::UID,
        owner: address,
        stars_balance: u64,
        lifetime_stars: u64,
    }

    public fun add_stars(arg0: &GameAdminCap, arg1: &mut NautilusProfile, arg2: u64) {
        arg1.stars_balance = arg1.stars_balance + arg2;
        arg1.lifetime_stars = arg1.lifetime_stars + arg2;
    }

    public entry fun burn_profile(arg0: NautilusProfile, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let NautilusProfile {
            id             : v0,
            owner          : _,
            stars_balance  : _,
            lifetime_stars : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<GameAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_profile(arg0: &GameAdminCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NautilusProfile{
            id             : 0x2::object::new(arg3),
            owner          : arg1,
            stars_balance  : arg2,
            lifetime_stars : arg2,
        };
        0x2::transfer::transfer<NautilusProfile>(v0, arg1);
    }

    public fun spend_stars_for_crate(arg0: &mut NautilusProfile, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.stars_balance >= arg1, 0);
        arg0.stars_balance = arg0.stars_balance - arg1;
    }

    // decompiled from Move bytecode v7
}

