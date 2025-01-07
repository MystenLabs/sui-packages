module 0x878a126bd893d5e5161195ac559c42b63e37b51bbc85fa665dc9f5dca30aa30e::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HOPCAT", b"HopCat", b"Hi, I'm Hop, the coolest cat on sui! Yes, I'm like that - I jump like a real athlete, or almost... But every jump I make is a show! Also, between you and me, I love to eat fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984020813.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

