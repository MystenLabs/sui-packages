module 0x582451cce46a23c61e23d717d91638ce1e11b55692114c8b196e0a4f224bc77e::simple_warrior {
    struct Sword has store, key {
        id: 0x2::object::UID,
        strength: u8,
    }

    struct Shield has store, key {
        id: 0x2::object::UID,
        armor: u8,
    }

    struct SimpleWarrior has key {
        id: 0x2::object::UID,
        sword: 0x1::option::Option<Sword>,
        shield: 0x1::option::Option<Shield>,
    }

    public entry fun create_shield(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Shield{
            id    : 0x2::object::new(arg1),
            armor : arg0,
        };
        0x2::transfer::transfer<Shield>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_sword(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Sword{
            id       : 0x2::object::new(arg1),
            strength : arg0,
        };
        0x2::transfer::transfer<Sword>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_warrior(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleWarrior{
            id     : 0x2::object::new(arg0),
            sword  : 0x1::option::none<Sword>(),
            shield : 0x1::option::none<Shield>(),
        };
        0x2::transfer::transfer<SimpleWarrior>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun equip_shield(arg0: &mut SimpleWarrior, arg1: Shield, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<Shield>(&arg0.shield)) {
            0x2::transfer::transfer<Shield>(0x1::option::extract<Shield>(&mut arg0.shield), 0x2::tx_context::sender(arg2));
        };
        0x1::option::fill<Shield>(&mut arg0.shield, arg1);
    }

    public entry fun equip_sword(arg0: &mut SimpleWarrior, arg1: Sword, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<Sword>(&arg0.sword)) {
            0x2::transfer::transfer<Sword>(0x1::option::extract<Sword>(&mut arg0.sword), 0x2::tx_context::sender(arg2));
        };
        0x1::option::fill<Sword>(&mut arg0.sword, arg1);
    }

    // decompiled from Move bytecode v6
}

