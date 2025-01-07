module 0xd0d4fb77569a4334ff28a25bbd08f2e621b89ae4273827877df9de0195d99d6c::didi {
    struct DIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDI>(arg0, 9, b"DIDI", b"Hdjn", b"Dududj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f705410-297b-405a-878d-1b270f198f0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

