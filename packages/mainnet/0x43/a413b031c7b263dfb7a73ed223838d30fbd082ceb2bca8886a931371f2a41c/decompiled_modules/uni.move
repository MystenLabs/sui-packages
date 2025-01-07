module 0x43a413b031c7b263dfb7a73ed223838d30fbd082ceb2bca8886a931371f2a41c::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"Uni", b"uni the wonder dog", b"Sui's ceo dog uni_the_wonder_dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/14311e80fd3e7c825729a315352379f2_e95d5635e8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

