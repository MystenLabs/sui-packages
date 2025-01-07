module 0x38d5e60c753c10057a4b81b369549a117f70c19ca771e17f05276c20707562c6::my_module2 {
    struct Sword has store, key {
        id: 0x2::object::UID,
        magic: u64,
        strength: u64,
        modified_by: address,
    }

    struct Forge has store, key {
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

    public entry fun magic_inc(arg0: &mut Sword) {
        arg0.magic = arg0.magic + 1;
    }

    public entry fun magic_inc_2(arg0: &mut Sword, arg1: &0x2::tx_context::TxContext) {
        arg0.magic = arg0.magic + 1;
        arg0.modified_by = 0x2::tx_context::sender(arg1);
    }

    entry fun magic_inc_entry(arg0: &mut Sword) {
        arg0.magic = arg0.magic + 1;
    }

    public fun strength(arg0: &Sword) : u64 {
        arg0.strength
    }

    public entry fun sword_create(arg0: &mut Forge, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Sword{
            id          : 0x2::object::new(arg4),
            magic       : arg1,
            strength    : arg2,
            modified_by : 0x2::tx_context::sender(arg4),
        };
        0x2::transfer::public_transfer<Sword>(v0, arg3);
        arg0.swords_created = arg0.swords_created + 1;
    }

    public entry fun sword_transfer(arg0: Sword, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Sword>(arg0, arg1);
    }

    public fun swords_created(arg0: &Forge) : u64 {
        arg0.swords_created
    }

    // decompiled from Move bytecode v6
}

