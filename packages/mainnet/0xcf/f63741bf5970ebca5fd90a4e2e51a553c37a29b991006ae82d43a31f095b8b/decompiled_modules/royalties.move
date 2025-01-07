module 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::royalties {
    public fun fee_service_collection(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = arg0 * arg2 / 1000;
        let v1 = arg0 * arg1 / 1000 + v0;
        (arg0 - v1, v1, v0)
    }

    // decompiled from Move bytecode v6
}

