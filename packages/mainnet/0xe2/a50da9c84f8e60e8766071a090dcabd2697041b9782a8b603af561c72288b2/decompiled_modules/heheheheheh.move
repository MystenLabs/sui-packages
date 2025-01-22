module 0xe2a50da9c84f8e60e8766071a090dcabd2697041b9782a8b603af561c72288b2::heheheheheh {
    struct HEHEHEHEHEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHEHEHEHEH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HEHEHEHEHEH>(arg0, 6, b"HEHEHEHEHEH", b"HEHE by SuiAI", b"huhu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/shiba_inu_shib_sticker_38b7b32160.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HEHEHEHEHEH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHEHEHEHEH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

