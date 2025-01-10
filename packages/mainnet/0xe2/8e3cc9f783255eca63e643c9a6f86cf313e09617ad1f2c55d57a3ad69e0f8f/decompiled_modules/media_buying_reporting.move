module 0xe28e3cc9f783255eca63e643c9a6f86cf313e09617ad1f2c55d57a3ad69e0f8f::media_buying_reporting {
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

