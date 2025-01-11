module 0x5ec0ab0dd3a94e9c8a8746e79c9316a8f1ea4edf5ba59e69f2a2db1419e2d433::deck {
    struct Deck has store, key {
        id: 0x2::object::UID,
        path: vector<u8>,
        owner: address,
    }

    // decompiled from Move bytecode v6
}

