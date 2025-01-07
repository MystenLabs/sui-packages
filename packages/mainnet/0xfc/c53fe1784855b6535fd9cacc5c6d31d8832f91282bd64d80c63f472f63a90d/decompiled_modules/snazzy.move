module 0xfcc53fe1784855b6535fd9cacc5c6d31d8832f91282bd64d80c63f472f63a90d::snazzy {
    struct SNAZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAZZY>(arg0, 6, b"Snazzy", b"SnazzySui", b"Looking sharp, mooning hard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_081239747_8c5abbde2a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

