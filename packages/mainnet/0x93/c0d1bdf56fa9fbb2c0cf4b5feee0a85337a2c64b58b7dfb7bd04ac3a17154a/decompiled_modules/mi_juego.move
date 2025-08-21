module 0x93c0d1bdf56fa9fbb2c0cf4b5feee0a85337a2c64b58b7dfb7bd04ac3a17154a::mi_juego {
    struct Sword has key {
        id: 0x2::object::UID,
        power: u64,
    }

    struct Enemy has key {
        id: 0x2::object::UID,
        health: u64,
    }

    public fun attack_enemy(arg0: &Sword, arg1: &mut Enemy) {
        if (arg0.power >= arg1.health) {
            arg1.health = 0;
        } else {
            arg1.health = arg1.health - arg0.power;
        };
    }

    public fun battle(arg0: &Sword, arg1: &Sword) : &Sword {
        if (arg0.power >= arg1.power) {
            arg0
        } else {
            arg1
        }
    }

    public fun get_health(arg0: &Enemy) : u64 {
        arg0.health
    }

    public fun get_power(arg0: &Sword) : u64 {
        arg0.power
    }

    public fun new_enemy(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Enemy {
        Enemy{
            id     : 0x2::object::new(arg1),
            health : arg0,
        }
    }

    public fun new_sword(arg0: &mut 0x2::tx_context::TxContext) : Sword {
        Sword{
            id    : 0x2::object::new(arg0),
            power : 10,
        }
    }

    public fun upgrade_sword(arg0: &mut Sword, arg1: u64) {
        arg0.power = arg0.power + arg1;
    }

    // decompiled from Move bytecode v6
}

