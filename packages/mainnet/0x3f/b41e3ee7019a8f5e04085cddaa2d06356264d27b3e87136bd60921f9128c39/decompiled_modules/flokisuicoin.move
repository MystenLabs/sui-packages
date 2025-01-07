module 0x3fb41e3ee7019a8f5e04085cddaa2d06356264d27b3e87136bd60921f9128c39::flokisuicoin {
    struct Sword has store, key {
        id: 0x2::object::UID,
        magic: u64,
        strength: u64,
    }

    struct Flokisuicoin has store, key {
        id: 0x2::object::UID,
        swords_created: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Flokisuicoin{
            id             : 0x2::object::new(arg0),
            swords_created : 0,
        };
        0x2::transfer::transfer<Flokisuicoin>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun magic(arg0: &Sword) : u64 {
        arg0.magic
    }

    public fun strength(arg0: &Sword) : u64 {
        arg0.strength
    }

    public entry fun sword_create(arg0: &mut Flokisuicoin, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Sword{
            id       : 0x2::object::new(arg4),
            magic    : arg1,
            strength : arg2,
        };
        arg0.swords_created = arg0.swords_created + 1;
        0x2::transfer::transfer<Sword>(v0, arg3);
    }

    public fun swords_created(arg0: &Flokisuicoin) : u64 {
        arg0.swords_created
    }

    // decompiled from Move bytecode v6
}

