module 0x67d843b58e447bbf3d36b2a1efb6f6941a1894b47422d106eb2841764996910a::pring {
    struct PRING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRING>(arg0, 6, b"PRING", b"PRINGUL", b"PRINGUL(PRING) is a fun, community-driven memecoin inspired by internet memes. With a playful name and viral trends, it's all about humor, social engagement, and a shared love for lighthearted fun in the crypto space. Perfect for those looking for a laugh and potential gains, Pringul brings a snack-like joy to the world of crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_19_59_28_771ed15503.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRING>>(v1);
    }

    // decompiled from Move bytecode v6
}

