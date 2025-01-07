module 0x46262abfb3c6951ebe30be8c453174a4e37043b7741b391ffb18f0e29ebce20b::swif {
    struct SWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIF>(arg0, 6, b"SWIF", b"sogwifhat", b"A dog wif a hat. No socials sendorrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0269_a777f5f29b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

