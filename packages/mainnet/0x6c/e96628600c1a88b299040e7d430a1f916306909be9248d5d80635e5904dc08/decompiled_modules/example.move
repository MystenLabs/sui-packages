module 0x6ce96628600c1a88b299040e7d430a1f916306909be9248d5d80635e5904dc08::example {
    struct Sword has store, key {
        id: 0x2::object::UID,
        magic: u64,
        strength: u64,
    }

    struct Forge has key {
        id: 0x2::object::UID,
        swords_created: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Forge{
            id             : 0x2::object::new(arg0),
            swords_created : 0,
        };
        0x2::transfer::transfer<Forge>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun magic(arg0: &Sword) : u64 {
        arg0.magic
    }

    public fun new_sword(arg0: &mut Forge, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Sword {
        arg0.swords_created = arg0.swords_created + 1;
        Sword{
            id       : 0x2::object::new(arg3),
            magic    : arg1,
            strength : arg2,
        }
    }

    public fun strength(arg0: &Sword) : u64 {
        arg0.strength
    }

    public fun sword_create(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Sword {
        Sword{
            id       : 0x2::object::new(arg2),
            magic    : arg0,
            strength : arg1,
        }
    }

    public fun swords_created(arg0: &Forge) : u64 {
        arg0.swords_created
    }

    // decompiled from Move bytecode v6
}

