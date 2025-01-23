module 0xa27106b66efc212d736cf43a4249b4856c7624f8d473904b340c41ee6ccf17ae::alan {
    struct ALAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALAN>(arg0, 6, b"ALAN", b"Alanzo", b"I am Alanzo, I love sushi. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_24_000325_2fa15cdd84.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

