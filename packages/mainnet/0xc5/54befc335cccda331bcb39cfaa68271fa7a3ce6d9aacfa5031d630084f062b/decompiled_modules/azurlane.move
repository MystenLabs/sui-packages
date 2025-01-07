module 0xc554befc335cccda331bcb39cfaa68271fa7a3ce6d9aacfa5031d630084f062b::azurlane {
    struct AZURLANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZURLANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZURLANE>(arg0, 6, b"AZURLANE", b"Azur Lane", x"48756d616e206265696e6773207765726520626f726e20696e207468697320617a75726520626c75652073656120617420746865207665727920626567696e200a6e696e672e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/240089211_288_k419066_22b2cd1796.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZURLANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZURLANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

