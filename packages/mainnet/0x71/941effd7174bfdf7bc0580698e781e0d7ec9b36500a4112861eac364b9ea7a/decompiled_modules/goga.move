module 0x71941effd7174bfdf7bc0580698e781e0d7ec9b36500a4112861eac364b9ea7a::goga {
    struct GOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGA>(arg0, 6, b"GOGA", b"GOVERNA", b"This structured plan is designed to ensure a smooth launch, boost visibility, and cultivate a vibrant and engaged community from the very beginning. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6266_1c75503ffc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

