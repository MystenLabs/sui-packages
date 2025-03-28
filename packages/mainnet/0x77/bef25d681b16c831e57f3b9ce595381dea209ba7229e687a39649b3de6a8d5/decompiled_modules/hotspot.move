module 0x77bef25d681b16c831e57f3b9ce595381dea209ba7229e687a39649b3de6a8d5::hotspot {
    struct HOTSPOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTSPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTSPOT>(arg0, 6, b"HOTSPOT", b"Hotspot", b"Nooooooooo my Huuutspoout. Brooo Hoooutspooouut oh maturamakalunga WiFi no coming signal go pish pish buritomahara just sit down hand up crying like spicy curry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076490_76af3317ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTSPOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOTSPOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

