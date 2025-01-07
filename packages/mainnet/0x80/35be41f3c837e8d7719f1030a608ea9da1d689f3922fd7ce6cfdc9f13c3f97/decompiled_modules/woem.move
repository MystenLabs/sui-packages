module 0x8035be41f3c837e8d7719f1030a608ea9da1d689f3922fd7ce6cfdc9f13c3f97::woem {
    struct WOEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOEM>(arg0, 6, b"WOEM", b"MEMEOW", b"Maybe cat, maybe meow but of course its MEMEOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_24_16_27_53_94b9040903.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

