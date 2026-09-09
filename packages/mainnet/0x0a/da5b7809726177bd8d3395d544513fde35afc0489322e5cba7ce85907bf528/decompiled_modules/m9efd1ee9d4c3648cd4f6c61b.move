module 0xada5b7809726177bd8d3395d544513fde35afc0489322e5cba7ce85907bf528::m9efd1ee9d4c3648cd4f6c61b {
    public fun fc9da9c0a03ab5c326c54cd22(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

