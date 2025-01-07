module 0x6646958e347aa24ee5200d3da191352f4dc2a63f151ea675c0bb1e110561ab6e::aquafrens {
    struct AQUAFRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAFRENS>(arg0, 6, b"AQUAFRENS", b"AQUAMAN AND FRENS", b"AQUAMAN WITH FRENS = BULLISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3831_4eed89a915.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAFRENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAFRENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

