module 0x988f0bbae3b070b70f6d60b8521193d6780d718c5e77a05f497f79c0f3d66d7f::suiso {
    struct SUISO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISO>(arg0, 6, b"Suiso", b"suiso on sui", b"Suiso, the enigmatic spirit of hydrogen, fuels the future with its endless energy, bringing a breath of fresh air to the world of innovation. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8413894_b1f20ce273.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISO>>(v1);
    }

    // decompiled from Move bytecode v6
}

