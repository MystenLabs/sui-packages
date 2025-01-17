module 0xcad4ef8e725bd8c5f87c5cfc987a44e156ad3c01e36baca6a99c5c5d3d01bc78::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD>(arg0, 6, b"Bird", b"Bird fly in the sky", b"Help this bird fly in the sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737081082978.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

