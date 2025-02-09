module 0xfce7c9887dfc11d719daf193813491ffbee3afd59efb52e48aea5590ff59cb55::kon {
    struct KON has drop {
        dummy_field: bool,
    }

    fun init(arg0: KON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KON>(arg0, 6, b"KON", b"KONAN$", b"More than just a cryptocurrency, Konan is a symbol of loyalty, strength, and unyielding determination. From supporting veterans and first responders to funding programs that aid communities affected by conflict, Konan stands for unity, compassion, and making the world a better place.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/https_3e069407cd28d32752c90d4009034b9c_cdn_bubble_io_f1727431996255x322508755583060350_unnamed283_29_da46c8443c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KON>>(v1);
    }

    // decompiled from Move bytecode v6
}

