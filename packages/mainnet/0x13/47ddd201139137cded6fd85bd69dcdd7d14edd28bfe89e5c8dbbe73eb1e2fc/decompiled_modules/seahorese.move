module 0x1347ddd201139137cded6fd85bd69dcdd7d14edd28bfe89e5c8dbbe73eb1e2fc::seahorese {
    struct SEAHORESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAHORESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAHORESE>(arg0, 6, b"SEAHORESE", b"seahorses", b"seahorses on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_15_07_52_0f3f8750aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAHORESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAHORESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

