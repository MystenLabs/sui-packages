module 0x61bd81d63d60a7eb3ee92a00ad6d5f3e5e4dacf97933929c7849e0535a3b0303::drip {
    struct DRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIP>(arg0, 6, b"DRIP", b"BLUE DRIP", b"Replace art with Kanye", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8768_b6056756ed.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

