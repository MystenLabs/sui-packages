module 0xdffa9855fe3f51daf9c43cf53ead863b36b96fa3daf4aab57ff2462ed5bc73a1::act47 {
    struct ACT47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT47>(arg0, 6, b"ACT47", b"Act 47: A Presidential Prophecy", x"3e2052656269727468206f662061204e6174696f6e0a3e20526573746f726174696f6e206f6620616e204f726465720a3e2049676e6974696f6e206f6620477265656e2043616e646c6573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_035456_500_7d1427651a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACT47>>(v1);
    }

    // decompiled from Move bytecode v6
}

