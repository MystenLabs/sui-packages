module 0xf75de9d578776aaae4a00daac66b0372231b20e4eb9113f4d506bbb8f4ca49d1::gougou {
    struct GOUGOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOUGOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOUGOU>(arg0, 6, b"GOUGOU", b"Chinese Doge", b" (gu gu b) GOUGOU Token merges the beloved Doge meme with the charm of Chinese cultural elements, resulting in a refreshing and captivating synthesis that pays homage to tradition while embracing the future. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pprn_logo_d30ff883f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOUGOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOUGOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

