module 0xdaaeace12354567f608f125bcc0d6e22184f9a8289db5a30d45114b2820e39df::suirangers {
    struct SUIRANGERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRANGERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRANGERS>(arg0, 6, b"SUIRANGERS", b"Sui Rangers", b"Sui Rangers is a memecoin inspired by the spirit of a legendary team of heroes. With a mission to conquer the crypto world, Sui Rangers invites holders to join as part of a strong, action-packed team always ready to face challenges. Like true heroes, Sui Rangers believes that the greatest power lies in community teamwork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000045927_183a7282e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRANGERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRANGERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

