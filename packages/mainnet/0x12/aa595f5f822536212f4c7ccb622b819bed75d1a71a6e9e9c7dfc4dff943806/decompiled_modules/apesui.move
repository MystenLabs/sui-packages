module 0x12aa595f5f822536212f4c7ccb622b819bed75d1a71a6e9e9c7dfc4dff943806::apesui {
    struct APESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APESUI>(arg0, 6, b"APESUI", b"APE SUI", b"The ape in suit, now on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_23_47_53_3005ed8087.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

