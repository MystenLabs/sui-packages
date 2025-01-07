module 0x6179a57796d05f54b96869ccc98ddaa1a6b364bdeb0fd31e48f494b903ea019::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGA>(arg0, 6, b"BELUGA", b"Beluga", b"The majestic $BELUGA making waves in the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0117_4ace40c753.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

