module 0x394a73cca40a075110e162ee42870de8a7c2c180c1498ec1f54db39fced36f83::chakra {
    struct CHAKRA has drop {
        dummy_field: bool,
    }

    struct Chakra has drop, store {
        number: u64,
        points: u64,
        level: u64,
        enlightenment: u64,
    }

    public fun burn(arg0: Chakra) {
        let Chakra {
            number        : _,
            points        : _,
            level         : _,
            enlightenment : _,
        } = arg0;
    }

    public fun create(arg0: u64) : Chakra {
        Chakra{
            number        : arg0,
            points        : 0,
            level         : 0,
            enlightenment : 0,
        }
    }

    public(friend) fun number(arg0: &Chakra) : u64 {
        arg0.number
    }

    public(friend) fun points(arg0: &Chakra) : u64 {
        arg0.points
    }

    public fun set_points(arg0: &mut Chakra, arg1: u64) {
        arg0.points = arg1;
    }

    // decompiled from Move bytecode v6
}

