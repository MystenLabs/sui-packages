module 0x1fd9c88acb9a6156fd7dcf24035ce3d6b699a769c61f1a5891d9413778b86bba::candle {
    struct CANDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDLE>(arg0, 6, b"CANDLE", b"CANDLE STICK", b"Lighting the way to moon | Candle Stick Army", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Candle_meme_8a18a52a28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

