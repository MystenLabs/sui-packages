module 0x3302a9f22abb2f5c871a40aa5d886b69ab0d0b70311ba6b1782b051fe73c28b6::suihood {
    struct SUIHOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHOOD>(arg0, 6, b"SUIHOOD", b"SUI HOOD", b"Join The Gang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6749_f7d95efc35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

