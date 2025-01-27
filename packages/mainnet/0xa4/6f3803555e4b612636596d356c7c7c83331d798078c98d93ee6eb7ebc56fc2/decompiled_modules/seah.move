module 0xa46f3803555e4b612636596d356c7c7c83331d798078c98d93ee6eb7ebc56fc2::seah {
    struct SEAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAH>(arg0, 6, b"SEAH", b"Seahorse", b"$SEAH, the cutest seahorse on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0904_e9cd372aad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

