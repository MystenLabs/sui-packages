module 0x36154d5588eafd79dfd690a049a7b46d0d809bc367f604dc270aecc778686808::sk8pose {
    struct SK8POSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SK8POSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SK8POSE>(arg0, 6, b"SK8POSE", b"Skater Poser", b"The hardest poser you ever will meet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738364715041.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SK8POSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SK8POSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

