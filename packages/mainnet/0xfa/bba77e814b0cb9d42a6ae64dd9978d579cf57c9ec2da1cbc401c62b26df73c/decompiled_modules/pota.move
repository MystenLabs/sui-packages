module 0xfabba77e814b0cb9d42a6ae64dd9978d579cf57c9ec2da1cbc401c62b26df73c::pota {
    struct POTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTA>(arg0, 9, b"POTA", b"Baked Pota", b"Baked Potato", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/081ef07d-7858-4395-b77d-5c77b1296514.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

