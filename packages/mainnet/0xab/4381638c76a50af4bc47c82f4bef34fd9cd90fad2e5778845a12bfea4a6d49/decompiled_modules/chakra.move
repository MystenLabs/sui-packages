module 0xab4381638c76a50af4bc47c82f4bef34fd9cd90fad2e5778845a12bfea4a6d49::chakra {
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
            points        : arg0,
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

