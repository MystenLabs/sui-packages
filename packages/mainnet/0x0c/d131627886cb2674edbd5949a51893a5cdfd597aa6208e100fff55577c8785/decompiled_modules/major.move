module 0xcd131627886cb2674edbd5949a51893a5cdfd597aa6208e100fff55577c8785::major {
    struct MAJOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJOR>(arg0, 6, b"Major", b"Major Sui", b"You are the Major, not anothers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241012_173729_210_84f0ba0e3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAJOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

