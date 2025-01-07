module 0x1743cfcf557424051e217a30eef335160fa6657bc81f2d3aac2305f56e1f6ba2::moshi {
    struct MOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSHI>(arg0, 6, b"MOSHI", b"MOSHI SUI", b"Meet $MOSHI. Ponke's little brotherrebellious, determined to break free from the trenches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2o_Db7_ZT_400x400_3d18f8394a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

