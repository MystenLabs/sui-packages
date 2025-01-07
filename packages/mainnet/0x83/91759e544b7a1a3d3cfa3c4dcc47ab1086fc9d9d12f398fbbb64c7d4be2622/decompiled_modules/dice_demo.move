module 0x8391759e544b7a1a3d3cfa3c4dcc47ab1086fc9d9d12f398fbbb64c7d4be2622::dice_demo {
    struct Dice has store, key {
        id: 0x2::object::UID,
        value: u8,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dice{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Dice>(v0);
    }

    entry fun roll_dice(arg0: &0x2::random::Random, arg1: &mut Dice, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        arg1.value = 0x2::random::generate_u8_in_range(&mut v0, 1, 6);
    }

    // decompiled from Move bytecode v6
}

