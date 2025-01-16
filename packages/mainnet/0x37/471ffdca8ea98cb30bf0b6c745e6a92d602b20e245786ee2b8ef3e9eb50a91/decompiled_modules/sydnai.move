module 0x37471ffdca8ea98cb30bf0b6c745e6a92d602b20e245786ee2b8ef3e9eb50a91::sydnai {
    struct SYDNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYDNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYDNAI>(arg0, 6, b"SYDNAI", b"Sydnai Sweeney", b"Meet Your AI dream girl, Sydnai Sweeney. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_163330_318_608a279976.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYDNAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYDNAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

