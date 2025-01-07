module 0xebb893fad92a9736016257d338dd312a5ef62e7c9da5c618967d944cdd0c1633::didi {
    struct DIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDI>(arg0, 9, b"DIDI", b"WEWE", b"DIDI to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2dfdfc98-9975-4427-b3aa-bd2472cf4fc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

