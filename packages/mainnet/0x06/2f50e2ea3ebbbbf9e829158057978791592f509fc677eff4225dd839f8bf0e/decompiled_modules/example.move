module 0xa846eaba7b4c5a5358761010b24d2e4d0e46825dac83680c36f00309260f5545::example {
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

    public fun new_sword(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Sword{
            id       : 0x2::object::new(arg0),
            magic    : 0,
            strength : 0,
        };
        0x2::transfer::transfer<Sword>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun strength(arg0: &Sword) : u64 {
        arg0.strength
    }

    public fun swords_created(arg0: &Forge) : u64 {
        arg0.swords_created
    }

    // decompiled from Move bytecode v6
}

