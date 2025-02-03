module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::quote_utils {
    struct FriendKey has drop {
        dummy_field: bool,
    }

    public fun admin_friend_key(arg0: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::AdminCap) : FriendKey {
        FriendKey{dummy_field: false}
    }

    public(friend) fun friend_key() : FriendKey {
        FriendKey{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

