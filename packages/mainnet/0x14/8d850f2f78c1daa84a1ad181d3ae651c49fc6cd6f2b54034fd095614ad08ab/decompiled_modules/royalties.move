module 0x148d850f2f78c1daa84a1ad181d3ae651c49fc6cd6f2b54034fd095614ad08ab::royalties {
    public fun fee_service_collection(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = arg0 * arg2 / 1000;
        let v1 = arg0 * arg1 / 1000 + v0;
        (arg0 - v1, v1, v0)
    }

    // decompiled from Move bytecode v6
}

