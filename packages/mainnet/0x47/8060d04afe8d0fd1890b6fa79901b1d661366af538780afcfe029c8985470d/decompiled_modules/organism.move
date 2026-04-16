module 0x478060d04afe8d0fd1890b6fa79901b1d661366af538780afcfe029c8985470d::organism {
    struct Organism has store, key {
        id: 0x2::object::UID,
        state: u64,
        genesis: u64,
        interactions: u64,
        wallets_generated: u64,
        owner: address,
        active: bool,
    }

    struct InteractionEvent has copy, drop {
        participant: address,
        state: u64,
        interaction_count: u64,
    }

    struct GenesisEvent has copy, drop {
        organism: address,
        creator: address,
        state: u64,
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Organism{
            id                : 0x2::object::new(arg0),
            state             : 1680,
            genesis           : 0x2::tx_context::epoch(arg0),
            interactions      : 0,
            wallets_generated : 0,
            owner             : v0,
            active            : true,
        };
        let v2 = GenesisEvent{
            organism : 0x2::object::uid_to_address(&v1.id),
            creator  : v0,
            state    : 1680,
        };
        0x2::event::emit<GenesisEvent>(v2);
        0x2::transfer::public_transfer<Organism>(v1, v0);
    }

    fun fibonacci(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 1
        };
        if (arg0 == 1) {
            return 1
        };
        let v0 = 1;
        let v1 = 2;
        while (v1 <= arg0) {
            v0 = 1 + v0;
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_interactions(arg0: &Organism) : u64 {
        arg0.interactions
    }

    public fun get_state(arg0: &Organism) : u64 {
        arg0.state
    }

    public fun get_wallets(arg0: &Organism) : u64 {
        arg0.wallets_generated
    }

    public entry fun interact(arg0: &mut Organism, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.interactions = arg0.interactions + 1;
        arg0.state = (arg0.state + fibonacci(arg0.interactions % 17)) % 1680;
        if (arg0.interactions % 233 == 0) {
            arg0.wallets_generated = arg0.wallets_generated + 1;
        };
        let v0 = InteractionEvent{
            participant       : 0x2::tx_context::sender(arg1),
            state             : arg0.state,
            interaction_count : arg0.interactions,
        };
        0x2::event::emit<InteractionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

