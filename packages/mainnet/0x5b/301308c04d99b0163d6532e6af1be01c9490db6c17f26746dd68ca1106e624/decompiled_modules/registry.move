module 0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry {
    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        data_cap: 0x1::option::Option<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap>,
    }

    public fun assert_version(arg0: &GameRegistry) {
        assert!(arg0.version == 1, 2);
    }

    public(friend) fun borrow_data_cap(arg0: &GameRegistry) : &0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap {
        assert!(0x1::option::is_some<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap>(&arg0.data_cap), 1);
        0x1::option::borrow<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap>(&arg0.data_cap)
    }

    entry fun extract_data_cap(arg0: &RegistryAdminCap, arg1: &mut GameRegistry, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap>(&arg1.data_cap), 1);
        0x2::transfer::public_transfer<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap>(0x1::option::extract<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap>(&mut arg1.data_cap), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameRegistry{
            id       : 0x2::object::new(arg0),
            version  : 1,
            data_cap : 0x1::option::none<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap>(),
        };
        0x2::transfer::share_object<GameRegistry>(v0);
        let v1 = RegistryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RegistryAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun load_data_cap(arg0: &RegistryAdminCap, arg1: &mut GameRegistry, arg2: 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap) {
        assert!(0x1::option::is_none<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap>(&arg1.data_cap), 0);
        0x1::option::fill<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::GameAdminCap>(&mut arg1.data_cap, arg2);
    }

    entry fun set_version(arg0: &RegistryAdminCap, arg1: &mut GameRegistry, arg2: u64) {
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

