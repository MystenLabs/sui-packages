module 0x821b54769646751419c87049c35bc8336ec005af15ce34d0ce824c1412e260df::yolo {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLO>(arg0, 6, b"YOLO", b"$Sui YOLO", b"The official token of Sui YOLO Bot, Sui's premier volume & Rank Booster.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736392828197_19aeb0db57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

