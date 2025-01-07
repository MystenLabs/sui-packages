module 0xc9b4264397de25803d21b2588b7b709649c8552e846c11c29bf76bbd19a33a64::yuki {
    struct YUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKI>(arg0, 6, b"Yuki", b"$Yuki", b"Meet Yuki the popular panda dog. Yuki has over 230k followers on instagram and her owner has over 4 million, check for yourself.  https://www.instagram.com/khloe?igsh=MWVsbzl5MWgzeGlqNQ==", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0502_a79c031c61.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

