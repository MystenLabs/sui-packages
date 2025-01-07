module 0x8bf8c47e8b44c9d9a65ee63c6926d455303b840b9e1bdea2f10d9b31c561ddac::xrpsanta {
    struct XRPSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRPSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRPSANTA>(arg0, 6, b"XRPSANTA", b"XRP SANTA", b"Let's go hohoho, $XRPSANTA is a meme coin that will be popular in the crypto world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_154429_152_7758e9dd5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRPSANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRPSANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

