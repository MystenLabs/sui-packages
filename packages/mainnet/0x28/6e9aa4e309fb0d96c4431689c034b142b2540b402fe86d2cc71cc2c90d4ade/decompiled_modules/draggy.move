module 0x286e9aa4e309fb0d96c4431689c034b142b2540b402fe86d2cc71cc2c90d4ade::draggy {
    struct DRAGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGGY>(arg0, 6, b"DRAGGY", b"DRAGGY SUI Meme Land", b"DRAGGY SUI. Prepaid Dexscreener: Done", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_4_dd12543c39.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

