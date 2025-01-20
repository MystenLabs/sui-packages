module 0xbbb8fd74f71935e7001a50eff6e5f21d4dee2bcbb1526799c922fd86b488686a::cbs {
    struct CBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBS>(arg0, 6, b"CBS", b"CYBORGSUI", b"Hello future investors! Cyborg robot would like to welcome everyone to the world of Sui Network coin !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_1_2025_01_16_00_19_52_36b3d0065c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

