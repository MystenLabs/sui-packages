module 0x141598d8db98694b4730f6a582905ca54556412d0fcb1afc2c6bd0e0406e6631::md763bb28a77c7b75cad6eed8 {
    public fun fb9358754a0cbfabc2f3bc644(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

