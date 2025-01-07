module 0x561cce5f5252e33d454805ef34f6fe5ad3be904f44bba1c1d2a2ac808f981a44::suitrump {
    struct SUITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRUMP>(arg0, 9, b"SUITRUMP", b"Trump on Sui", b"Official token of Trump 2024.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sp-ao.shortpixel.ai/client/to_webp,q_lossy,ret_img,w_250,h_250/https://www.hypebot.com/wp-content/uploads/2024/08/Donald_Trump-250x250.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

