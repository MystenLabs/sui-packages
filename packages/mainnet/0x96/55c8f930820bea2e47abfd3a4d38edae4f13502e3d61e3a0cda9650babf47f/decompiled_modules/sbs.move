module 0x9655c8f930820bea2e47abfd3a4d38edae4f13502e3d61e3a0cda9650babf47f::sbs {
    struct SBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBS>(arg0, 6, b"SBS", b"SHIBUSSYONSUI", b"A SUI coin for the terminally tired", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0304_1a136f18e6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

