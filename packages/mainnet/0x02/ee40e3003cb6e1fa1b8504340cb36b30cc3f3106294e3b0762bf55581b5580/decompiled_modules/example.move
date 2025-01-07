module 0x2ee40e3003cb6e1fa1b8504340cb36b30cc3f3106294e3b0762bf55581b5580::example {
    struct Sword has store, key {
        id: 0x2::object::UID,
        magic: u64,
        strength: u64,
    }

    struct Forge has key {
        id: 0x2::object::UID,
        swords_created: u64,
    }

    public fun enchant_sword(arg0: Sword, arg1: &0x2::tx_context::TxContext) {
        arg0.magic = arg0.magic + 1;
        0x2::transfer::transfer<Sword>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun enchant_sword2(arg0: &mut Sword) {
        arg0.magic = arg0.magic + 1;
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

    public fun upgrade_sword(arg0: Sword, arg1: &0x2::tx_context::TxContext) {
        arg0.strength = arg0.strength + 1;
        0x2::transfer::transfer<Sword>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun upgrade_sword2(arg0: &mut Sword) {
        arg0.strength = arg0.strength + 1;
    }

    // decompiled from Move bytecode v6
}

