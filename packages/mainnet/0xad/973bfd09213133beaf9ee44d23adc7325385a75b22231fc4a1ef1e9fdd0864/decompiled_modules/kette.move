module 0xad973bfd09213133beaf9ee44d23adc7325385a75b22231fc4a1ef1e9fdd0864::kette {
    struct KETTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETTE>(arg0, 6, b"KETTE", b"PREZIDENT KETTE", b"The very first Prezidentkette coin on Sui Chain. let's make prezidentkette the biggest on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_20_48_08_d3767f1c8a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KETTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

