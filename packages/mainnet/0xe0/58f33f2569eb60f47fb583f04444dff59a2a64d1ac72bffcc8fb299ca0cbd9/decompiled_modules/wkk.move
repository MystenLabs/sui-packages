module 0xe058f33f2569eb60f47fb583f04444dff59a2a64d1ac72bffcc8fb299ca0cbd9::wkk {
    struct WKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKK>(arg0, 6, b"WKK", b"Waikiki On Sui", b"$WKK - Always Fun! Splash! WKK!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003094_f4cfe9133b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

