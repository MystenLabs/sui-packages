module 0x85e09a4b298646cda191d1870b3a0b4546987129bb4bf7847bf17707b5043c05::kek69 {
    struct KEK69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEK69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEK69>(arg0, 6, b"KEK69", b"OnlyFrens", b"We will influence the influencers to promote for us - Oh how the turns have tabled", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0095_3583d175ec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEK69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEK69>>(v1);
    }

    // decompiled from Move bytecode v6
}

