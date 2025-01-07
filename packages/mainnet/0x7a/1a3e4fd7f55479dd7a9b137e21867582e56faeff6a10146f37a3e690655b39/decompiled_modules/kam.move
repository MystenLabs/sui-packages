module 0x7a1a3e4fd7f55479dd7a9b137e21867582e56faeff6a10146f37a3e690655b39::kam {
    struct KAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAM>(arg0, 6, b"KaM", b"Kaaatius Maaaximus", x"4b61616174697573204d61616178696d75730a616161436174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2126_b4fad6ba44.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

