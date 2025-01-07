module 0xeb294b9401a7b6df0000b9f4cb67322d0fcdd12dd05ef9bd28529d41dbf07d22::royalties {
    public fun fee_service_collection(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = arg0 * arg2 / 1000;
        let v1 = arg0 * arg1 / 1000 + v0;
        (arg0 - v1, v1, v0)
    }

    // decompiled from Move bytecode v6
}

