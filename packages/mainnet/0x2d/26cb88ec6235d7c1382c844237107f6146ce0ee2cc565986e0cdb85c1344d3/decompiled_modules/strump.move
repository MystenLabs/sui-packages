module 0x2d26cb88ec6235d7c1382c844237107f6146ce0ee2cc565986e0cdb85c1344d3::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRUMP>(arg0, 9, b"STRUMP", b"TRUMP MEME", x"5452554d503a0a5448452043525950544f20505245534944454e540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2a9f37b6255c0f8f413eafdb65edf657blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

