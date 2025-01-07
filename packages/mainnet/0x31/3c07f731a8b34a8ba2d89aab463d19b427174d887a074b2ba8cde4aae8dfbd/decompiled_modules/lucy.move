module 0x313c07f731a8b34a8ba2d89aab463d19b427174d887a074b2ba8cde4aae8dfbd::lucy {
    struct LUCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCY>(arg0, 6, b"LUCY", b"Lucy", b"The symbol of 2025 and vatican mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9467_071e9eea18.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

