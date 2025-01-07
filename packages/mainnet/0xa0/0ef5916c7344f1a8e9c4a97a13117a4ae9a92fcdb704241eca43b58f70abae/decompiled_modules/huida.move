module 0xa00ef5916c7344f1a8e9c4a97a13117a4ae9a92fcdb704241eca43b58f70abae::huida {
    struct HUIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUIDA>(arg0, 6, b"HUIDA", b"Sui Huida", b"I am Huida, you are Huida, we are $HUIDA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018264_f9a2e5bb3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUIDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

