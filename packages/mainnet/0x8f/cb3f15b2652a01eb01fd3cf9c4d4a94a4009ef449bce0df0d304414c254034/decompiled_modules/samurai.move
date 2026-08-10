module 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai {
    struct GameCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        samurai: 0x2::table::Table<address, 0x2::object::ID>,
        enlisted: u64,
    }

    struct Samurai has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        honor: u64,
        forge_xp: u64,
        duel_xp: u64,
        wins: u64,
        losses: u64,
        blades_forged: u64,
        enlisted_epoch: u64,
    }

    struct Enlisted has copy, drop {
        samurai: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    struct Trained has copy, drop {
        samurai: 0x2::object::ID,
        xp: u64,
        score: u64,
    }

    struct DuelRecorded has copy, drop {
        winner: 0x2::object::ID,
        loser: 0x2::object::ID,
        honor_gain: u64,
    }

    public fun enlist(arg0: &mut Registry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg2);
        enlist_internal(arg0, v0, arg1, arg2)
    }

    public fun enlist_for(arg0: &GameCap, arg1: &mut Registry, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        enlist_internal(arg1, arg2, arg3, arg4)
    }

    fun enlist_internal(arg0: &mut Registry, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.samurai, arg1), 0);
        let v0 = Samurai{
            id             : 0x2::object::new(arg3),
            owner          : arg1,
            name           : arg2,
            honor          : 0,
            forge_xp       : 0,
            duel_xp        : 0,
            wins           : 0,
            losses         : 0,
            blades_forged  : 0,
            enlisted_epoch : 0x2::tx_context::epoch(arg3),
        };
        let v1 = 0x2::object::id<Samurai>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.samurai, arg1, v1);
        arg0.enlisted = arg0.enlisted + 1;
        let v2 = Enlisted{
            samurai : v1,
            owner   : arg1,
            name    : v0.name,
        };
        0x2::event::emit<Enlisted>(v2);
        0x2::transfer::share_object<Samurai>(v0);
        v1
    }

    public fun enlisted_count(arg0: &Registry) : u64 {
        arg0.enlisted
    }

    public fun forge_xp(arg0: &Samurai) : u64 {
        arg0.forge_xp
    }

    public fun grant_training(arg0: &GameCap, arg1: &mut Samurai, arg2: u64, arg3: u64) {
        arg1.forge_xp = arg1.forge_xp + arg2;
        let v0 = Trained{
            samurai : 0x2::object::id<Samurai>(arg1),
            xp      : arg2,
            score   : arg3,
        };
        0x2::event::emit<Trained>(v0);
    }

    public fun honor(arg0: &Samurai) : u64 {
        arg0.honor
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GameCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id       : 0x2::object::new(arg0),
            samurai  : 0x2::table::new<address, 0x2::object::ID>(arg0),
            enlisted : 0,
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun name(arg0: &Samurai) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun note_blade_forged(arg0: &mut Samurai) {
        arg0.blades_forged = arg0.blades_forged + 1;
    }

    public fun owner(arg0: &Samurai) : address {
        arg0.owner
    }

    public fun record_duel(arg0: &GameCap, arg1: &mut Samurai, arg2: &mut Samurai, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        arg1.honor = arg1.honor + arg3;
        arg1.wins = arg1.wins + 1;
        arg1.duel_xp = arg1.duel_xp + arg5;
        if (arg2.honor > arg4) {
            arg2.honor = arg2.honor - arg4;
        } else {
            arg2.honor = 0;
        };
        arg2.losses = arg2.losses + 1;
        arg2.duel_xp = arg2.duel_xp + arg6;
        let v0 = DuelRecorded{
            winner     : 0x2::object::id<Samurai>(arg1),
            loser      : 0x2::object::id<Samurai>(arg2),
            honor_gain : arg3,
        };
        0x2::event::emit<DuelRecorded>(v0);
    }

    // decompiled from Move bytecode v7
}

