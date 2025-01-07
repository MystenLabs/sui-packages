module 0x354237a2d8d2102f4413d1aabdfbe4fb6809067a5e4bdc2694a5d281bc01dbfe::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIB>(arg0, 6, b"SHIB", b"Shiba Sui", b"Buy Shiba Inu today! Best meme coin on SUI! Buy low and keep holding for the bull run!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5411_07f759582e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

