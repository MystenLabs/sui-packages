module 0x362febfa5b00391f6255397c99077f1b8baecd9135e20168943f354545103569::serpentum {
    struct SERPENTUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SERPENTUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERPENTUM>(arg0, 6, b"Serpentum", b"Serpentum on sui", b"We are excited to welcome you to the $SPT community. Let's build a strong community together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_4d8a5d52bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SERPENTUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SERPENTUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

