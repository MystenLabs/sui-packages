module 0x3aaa23ae6f2477aa919886fbcfbc2ae24dd6d0a31d74c263c026bbcb13274815::hopfun {
    struct HOPFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFUN>(arg0, 6, b"HOPFUN", b"HOPFUN CTO", b"HOP IS NOT FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G9_NH_V7z_400x400_53e8708e62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

