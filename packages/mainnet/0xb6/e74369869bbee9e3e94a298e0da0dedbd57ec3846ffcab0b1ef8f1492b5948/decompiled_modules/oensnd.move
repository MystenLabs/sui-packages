module 0xb6e74369869bbee9e3e94a298e0da0dedbd57ec3846ffcab0b1ef8f1492b5948::oensnd {
    struct OENSND has drop {
        dummy_field: bool,
    }

    fun init(arg0: OENSND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OENSND>(arg0, 9, b"OENSND", b"jdjd", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c491d513-2ecc-4c48-86af-faadcee75e7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OENSND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OENSND>>(v1);
    }

    // decompiled from Move bytecode v6
}

