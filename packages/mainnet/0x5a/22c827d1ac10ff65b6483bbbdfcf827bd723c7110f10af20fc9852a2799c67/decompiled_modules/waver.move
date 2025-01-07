module 0x5a22c827d1ac10ff65b6483bbbdfcf827bd723c7110f10af20fc9852a2799c67::waver {
    struct WAVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVER>(arg0, 9, b"WAVER", b"Wavero", b"just wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23682f3d-acc6-4d2c-a63a-e67492e63fbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

