module 0x80e0a0a77978d7b14191f9a9deb84696b77b2a8754b2a2e6a53220fcc589224d::penguins {
    struct PENGUINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUINS>(arg0, 6, b"Penguins", b"penguins", b"penguins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_24_38_b097773894.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

