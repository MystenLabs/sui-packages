module 0x8193d269dad1f09b8a00876fca6c08f2dc5a9845955883cfa720608bb84b1fd9::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY>(arg0, 6, b"Luffy", b"Sun God Nika", b"Long ago, in a vast digital realm known as the SUI Network, there existed a fearless adventurer named Sungodnika Sui. Clad in shimmering armor forged from blockchain shards and powered by the limitless energy of smart contracts, Sungodnika was a beacon of hope for investors far and wide. His quest? To find the elusive Treasure of Infinite Yields, a mythical fortune said to reward those who dared explore the networks deepest layers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_22_10_52_44_71f2839338.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

