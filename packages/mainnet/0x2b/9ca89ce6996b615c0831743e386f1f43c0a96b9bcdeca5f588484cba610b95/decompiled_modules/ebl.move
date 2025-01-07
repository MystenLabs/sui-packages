module 0x2b9ca89ce6996b615c0831743e386f1f43c0a96b9bcdeca5f588484cba610b95::ebl {
    struct EBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBL>(arg0, 6, b"EBL", b"EBULL", b"$EBULL is a meme coin thats all about the bullish energy of the crypto market. Its built on SUI, and yes, even ELON gave it a nodhows that for a seal of approval? Theres no fancy utility here, just a straightforward symbol of the markets wild ride.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_e8a7c57a95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

