module 0x295865b0b14fc62d69568380a52e4f897a1269e105d24229980073517853eee8::fukupapers {
    struct FUKUPAPERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKUPAPERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKUPAPERS>(arg0, 9, b"SEAL", b"fukupapers", b"degen maxi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1949348870926012416/VadXpw5Z_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUKUPAPERS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKUPAPERS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

