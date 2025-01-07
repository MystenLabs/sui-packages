module 0x511ccf44dc2226f7065ab3a73309ed02fb1f303f9d9b19ea10d1158d8d9ea65d::dfvc {
    struct DFVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFVC>(arg0, 9, b"DFVC", b"KJH", b"BBCVZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e597713-4236-4f05-8274-ed11fe40fc93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

