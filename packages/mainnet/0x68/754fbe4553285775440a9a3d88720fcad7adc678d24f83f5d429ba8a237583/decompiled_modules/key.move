module 0x68754fbe4553285775440a9a3d88720fcad7adc678d24f83f5d429ba8a237583::key {
    struct Key {
        code: u64,
    }

    public(friend) fun delete(arg0: Key) {
        let Key {  } = arg0;
    }

    public fun get_code(arg0: &Key) : u64 {
        arg0.code
    }

    public fun new() : Key {
        Key{code: 0}
    }

    public fun set_code(arg0: &mut Key, arg1: u64) {
        arg0.code = arg1;
    }

    // decompiled from Move bytecode v6
}

