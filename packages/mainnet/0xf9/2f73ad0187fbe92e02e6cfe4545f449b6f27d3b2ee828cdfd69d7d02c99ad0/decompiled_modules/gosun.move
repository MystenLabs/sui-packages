module 0xf92f73ad0187fbe92e02e6cfe4545f449b6f27d3b2ee828cdfd69d7d02c99ad0::gosun {
    struct GOSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOSUN>(arg0, 6, b"GOSUN", b"GUARDIAN OF SUN", b"We moving to SUI. GOSUN aims to preserve, celebrate, and collaborate the creative and cultural phenomenon of memes on SUI. Original OGs here. 888.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_27_00_22_11_2_0273ee12aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOSUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOSUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

