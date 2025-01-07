module 0xde44352d9c61336b577715d1cc5c436361c6158643d9c3f4033c4cad139fc406::candle {
    struct CANDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDLE>(arg0, 6, b"CANDLE", b"Candlesui Cat", b"$Candle Cat CommunityWhen members have the first and last word and decide their own destiny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_PQL_r_Zk_400x400_be535abca9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

