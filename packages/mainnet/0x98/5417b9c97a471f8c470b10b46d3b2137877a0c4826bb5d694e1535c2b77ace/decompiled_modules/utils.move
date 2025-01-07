module 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils {
    public fun is_bear_position(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_bull_position(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_valid_position(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    public fun to_miliseconds(arg0: u64) : u64 {
        arg0 * 1000
    }

    // decompiled from Move bytecode v6
}

