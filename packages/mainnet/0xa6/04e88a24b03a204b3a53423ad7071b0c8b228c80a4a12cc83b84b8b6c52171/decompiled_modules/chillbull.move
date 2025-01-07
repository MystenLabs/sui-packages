module 0xa604e88a24b03a204b3a53423ad7071b0c8b228c80a4a12cc83b84b8b6c52171::chillbull {
    struct CHILLBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLBULL>(arg0, 6, b"CHILLBULL", b"CHILL BULL", b"The real Chill Bull on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3690_4f4beb6d0e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

