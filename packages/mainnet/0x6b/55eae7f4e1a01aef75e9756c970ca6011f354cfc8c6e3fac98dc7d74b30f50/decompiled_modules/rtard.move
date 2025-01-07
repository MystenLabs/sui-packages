module 0x6b55eae7f4e1a01aef75e9756c970ca6011f354cfc8c6e3fac98dc7d74b30f50::rtard {
    struct RTARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTARD>(arg0, 6, b"RTARD", b"Retard", b"If you buy this you are not smart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6779_355a4894a5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

