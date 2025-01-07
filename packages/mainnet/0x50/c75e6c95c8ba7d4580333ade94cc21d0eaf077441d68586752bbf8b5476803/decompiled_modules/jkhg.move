module 0x50c75e6c95c8ba7d4580333ade94cc21d0eaf077441d68586752bbf8b5476803::jkhg {
    struct JKHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKHG>(arg0, 9, b"JKHG", b"ASDAS", b"VBCCD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c857f2b6-cb9c-4bc1-94c2-4357ce3f6ca4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

