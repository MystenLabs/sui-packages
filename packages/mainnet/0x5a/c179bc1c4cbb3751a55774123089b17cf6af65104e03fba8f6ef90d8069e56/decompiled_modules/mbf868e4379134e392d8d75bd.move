module 0x5ac179bc1c4cbb3751a55774123089b17cf6af65104e03fba8f6ef90d8069e56::mbf868e4379134e392d8d75bd {
    public fun fc526c6d3714e501a70d26e14(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

