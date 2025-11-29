module 0xc5bd42f25351a8751739f27ddf92d0283366860cebfaec0d49d26767884257b6::Planet {
    struct Catalyst has copy, drop {
        player: address,
        ghost_operator: address,
        operator_level: u64,
    }

    public fun Genesis(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Catalyst{
            player         : 0x2::tx_context::sender(arg2),
            ghost_operator : arg0,
            operator_level : arg1,
        };
        0x2::event::emit<Catalyst>(v0);
    }

    public fun init_package(arg0: 0x2::package::UpgradeCap) {
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg0, @0x0);
    }

    // decompiled from Move bytecode v6
}

