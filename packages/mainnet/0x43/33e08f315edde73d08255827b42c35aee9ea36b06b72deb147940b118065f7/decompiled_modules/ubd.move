module 0x4333e08f315edde73d08255827b42c35aee9ea36b06b72deb147940b118065f7::ubd {
    struct UBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBD>(arg0, 6, b"UBD", b"United Blockchain Degens", b"Memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250117_212456_fe197c9e96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

