module 0x1a8660dd24fbddecf4c14f41e988af23e5a169b72f6cc9c2be177c0c5293b79b::pdeng {
    struct PDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDENG>(arg0, 6, b"PDENG", b"POPDENG", b"Moodeng that pops", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4814_d19d80b4fd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

