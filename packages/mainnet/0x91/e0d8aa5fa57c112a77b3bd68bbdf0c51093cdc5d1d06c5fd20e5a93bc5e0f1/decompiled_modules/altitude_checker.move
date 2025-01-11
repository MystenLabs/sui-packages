module 0x91e0d8aa5fa57c112a77b3bd68bbdf0c51093cdc5d1d06c5fd20e5a93bc5e0f1::altitude_checker {
    struct AltitudeChecker has store, key {
        id: 0x2::object::UID,
        path: vector<u8>,
        owner: address,
    }

    public fun get_altitude_checker(arg0: &AltitudeChecker) : vector<u8> {
        arg0.path
    }

    // decompiled from Move bytecode v6
}

