module 0x783af13440489f5c6d0d20ef942fb8dc2b01ed3c036d22949d22c425c8e20f3a::sendor {
    struct SENDOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENDOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENDOR>(arg0, 6, b"SENDOR", b"Sen", b"Meet Sendor! He flies really high! Well, as high as he can before remembering he's scared of heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/send_b65f331f8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENDOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENDOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

