module 0x92921ac97f8d82ee72300936bf7df99e5c8529f5e54ceecad10dbcd857e4470::ptrgrff {
    struct PTRGRFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTRGRFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTRGRFF>(arg0, 9, b"PTRGRFF", b"Peter", b"Griffin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21f4e254-f9e5-411b-9b4c-1f464876ec0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTRGRFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTRGRFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

