module 0x6e2aa2b0551b6403e8e1c60869f63dd17ff11142194dec7cdeedbe1b6627b619::pose {
    struct POSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSE>(arg0, 6, b"POSE", b"Posuidon", b"Majestic guardian of the $SUI ocean. Protecting the community from scams and rug pulls. Join the army", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pose_9e9fc9871f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

