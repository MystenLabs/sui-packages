module 0x98059411a57b5f660448b603868111bf87879c7782c0ec39417f45d7b74e1ffc::royalties {
    public fun fee_service_collection(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = arg0 * arg2 / 1000;
        let v1 = arg0 * arg1 / 1000 + v0;
        (arg0 - v1, v1, v0)
    }

    // decompiled from Move bytecode v6
}

