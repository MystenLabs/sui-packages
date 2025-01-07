module 0x1b18fe4d3b55b6f3d6b06d0bd46af15d3c8cbf9a91a3947b1b6f341cbd327246::cathulhu {
    struct CATHULHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATHULHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATHULHU>(arg0, 6, b"CATHULHU", b"CATHULHU TUR", b"Meet Cathulhu, the cosmic overlord of nightmares and cuteness. Exposure to Cathulhu can drive people to love, madness and horror", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730991379237.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATHULHU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATHULHU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

