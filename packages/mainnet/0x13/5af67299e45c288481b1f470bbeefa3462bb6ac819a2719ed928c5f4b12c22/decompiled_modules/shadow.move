module 0x135af67299e45c288481b1f470bbeefa3462bb6ac819a2719ed928c5f4b12c22::shadow {
    struct SHADOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHADOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHADOW>(arg0, 9, b"SHADOW", b"Shadow", b"Nice Shadow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49319595-e24e-40c9-9a25-8994fb67b172.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHADOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

