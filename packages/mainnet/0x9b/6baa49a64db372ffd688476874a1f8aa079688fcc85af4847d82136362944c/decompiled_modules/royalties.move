module 0x9b6baa49a64db372ffd688476874a1f8aa079688fcc85af4847d82136362944c::royalties {
    public fun fee_service_collection(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = arg0 * arg2 / 1000;
        let v1 = arg0 * arg1 / 1000 + v0;
        (arg0 - v1, v1, v0)
    }

    // decompiled from Move bytecode v6
}

