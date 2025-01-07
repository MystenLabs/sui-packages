module 0x29ac848edd0ee7e36c293830eec782907ff2de0a1dbb00a613a01f50c5f3b359::sup {
    struct SUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUP>(arg0, 6, b"SUP", b"Suipreme", b"Suipreme ($SUP) is the ultimate meme coin on the Sui blockchain, blending memes and cutting-edge blockchain tech to create a unique experience for meme enthusiasts and crypto investors alike.  Join the Suipreme Apes today!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731243889498.58")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

