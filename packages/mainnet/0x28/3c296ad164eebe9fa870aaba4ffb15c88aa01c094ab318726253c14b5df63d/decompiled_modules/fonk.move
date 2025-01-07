module 0x283c296ad164eebe9fa870aaba4ffb15c88aa01c094ab318726253c14b5df63d::fonk {
    struct FONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FONK>(arg0, 6, b"FONK", b"FONKSUI", b"$FONK Coin is a playful and vibrant memecoin designed to enhance the entertainment experience within a casino ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241004_234840_065_80582b3208.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

