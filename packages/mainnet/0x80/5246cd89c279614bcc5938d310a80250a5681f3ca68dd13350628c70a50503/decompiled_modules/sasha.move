module 0x805246cd89c279614bcc5938d310a80250a5681f3ca68dd13350628c70a50503::sasha {
    struct SASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHA>(arg0, 6, b"SASHA", b"BITCOIN CAT", b"https://x.com/SashaCTO_", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kakao_Talk_20241005_114235183_f04fc4b823.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

