module 0xcd4927495be08794ee09463653bb7fe51a428093f8ac4c910b3f1be649e63516::my_module {
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

    public fun strength(arg0: &Sword) : u64 {
        arg0.strength
    }

    public entry fun sword_create(arg0: &mut Forge, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Sword{
            id       : 0x2::object::new(arg4),
            magic    : arg1,
            strength : arg2,
        };
        0x2::transfer::transfer<Sword>(v0, arg3);
        arg0.swords_created = arg0.swords_created + 1;
    }

    public fun swords_created(arg0: &Forge) : u64 {
        arg0.swords_created
    }

    public entry fun test<T0>() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

