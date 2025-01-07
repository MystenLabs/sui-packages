module 0x50d143166919b6c4eef712f81ebcd8cf9bc8518d77f5270794605b1415fdff5a::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 6, b"WIF", b"DOGWIF", b"Popular meme Dogwifhat vibes wif frens onchain. https://t.me/dogwifcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728564203204_9817eeaec7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

