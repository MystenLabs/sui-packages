module 0xf7e063a4c677183f6166b61082c8ea6080265cc8842305625142776ed6a1742::kinako {
    struct KINAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINAKO>(arg0, 6, b"Kinako", b"Kinako Sui", b"Kinako isn't just another token; it's the furry friend your crypto wallet never knew it needed. Named after the lovable, snack-loving Japanese word for \"roasted soybean flour,\" Kinako embodies the playful, loyal, and utterly adorable spirit of our canine companions. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kinako_04047463aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINAKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINAKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

