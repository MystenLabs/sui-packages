module 0x2ae0aab82fdeee6cf7837ea09c01feb203f8189c9d3e61492880c55e6f04fc26::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGA>(arg0, 6, b"BELUGA", b"MAJESTIC BELUGA", b"The majestic $BELUGA is making waves in thw Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_14_54_04_dc0f599aa8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

