module 0x51a049f9e264f96f0f0aefe86a3841949bd12aea0ba348751a96a548a0c0e40::hammer {
    struct HAMMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMER>(arg0, 6, b"HAMMER", b"HAMMER TIME", x"48657265277320796f75722048616d6d65722e20536d617368206974210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_09_19_215048_0fd945898f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

