module 0xe34f3365cb17ebf4f0b842f5955e5e9199c8fb4f952d397baf46437049ce8925::guas {
    struct GUAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUAS>(arg0, 6, b"GUAS", b"GUAONSUI", b"GUA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_01_45_10_0efb3c05dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

