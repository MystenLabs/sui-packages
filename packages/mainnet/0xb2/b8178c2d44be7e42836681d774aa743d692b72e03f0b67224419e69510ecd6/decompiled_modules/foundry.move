module 0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::foundry {
    struct Sword has store, key {
        id: 0x2::object::UID,
        level: u8,
    }

    fun err_ore_not_qualified() {
        abort 0
    }

    public fun forge(arg0: 0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::mine::Ore, arg1: &mut 0x2::tx_context::TxContext) : Sword {
        let v0 = 0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::mine::melt(arg0);
        if (v0 < quality_threshold()) {
            err_ore_not_qualified();
        };
        Sword{
            id    : 0x2::object::new(arg1),
            level : v0 / 2,
        }
    }

    entry fun forge_and_transfer(arg0: 0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::mine::Ore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Sword>(forge(arg0, arg2), arg1);
    }

    public fun level(arg0: &Sword) : u8 {
        arg0.level
    }

    public fun quality_threshold() : u8 {
        20
    }

    // decompiled from Move bytecode v6
}

