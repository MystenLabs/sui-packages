module 0x646bba27425b7a7ae5fa86ffd3de47292acc954fe0c43e6e5114aab75ad3e50::sunome {
    struct SUNOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNOME>(arg0, 6, b"SUNOME", b"SUI OF MEME", b"this is giga pump on sui pvp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6224330544997581916_d0788ddd19.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

