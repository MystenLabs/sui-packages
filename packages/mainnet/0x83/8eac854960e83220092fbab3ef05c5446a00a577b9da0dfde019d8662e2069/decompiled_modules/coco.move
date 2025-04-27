module 0x838eac854960e83220092fbab3ef05c5446a00a577b9da0dfde019d8662e2069::coco {
    struct COCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCO>(arg0, 6, b"COCO", b"Coco on Sui", b"COCO isnt just a coconut, hes the coconut. Born on a sunny beach and raised by the waves, always cool, always smiling. With a straw on top and an umbrella for flair, COCO doesnt just go with the flow, he is the flow. Whether hes soaking up the sun or dancing in the rain, nothing shakes his chill. One things for sure COCO is here to have a good time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062905_acd8a6ea03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

