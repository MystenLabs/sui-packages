module 0x6b042c570ec7d6b7a2b22f60062c588f6d5065b98b5c14c2cb7c2b60865d9d24::media_buying_reporting {
    struct MediaBuyingReporting has store, key {
        id: 0x2::object::UID,
        path: vector<u8>,
        owner: address,
    }

    public fun get_reporting(arg0: &MediaBuyingReporting) : vector<u8> {
        arg0.path
    }

    // decompiled from Move bytecode v6
}

