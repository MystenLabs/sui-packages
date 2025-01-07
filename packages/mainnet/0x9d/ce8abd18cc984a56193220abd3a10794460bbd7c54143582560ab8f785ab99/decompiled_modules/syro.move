module 0x9dce8abd18cc984a56193220abd3a10794460bbd7c54143582560ab8f785ab99::syro {
    struct SYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYRO>(arg0, 6, b"Syro", b"Suiro", x"737569726f202d205359524f0a4d79726f204f6e20537569210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Syro_bbf6b79585.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

