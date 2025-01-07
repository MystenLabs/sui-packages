module 0x719e6a33c2add08dd7ceefde339860abb7d62358aff40424f78d6000f78dffd1::scubadog {
    struct SCUBADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUBADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUBADOG>(arg0, 6, b"SCUBADOG", b"BLUE SCUBA DOG", x"455645525920434841494e204e45454420444f47202c20534355424120444f4720495320535549204d4153434f542e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3832_46e9c23991.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUBADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

