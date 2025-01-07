module 0x41b949e3bb759898503add83cb9cbf83ec006a2b6d32a351c91fdc1fcabaed3f::miga {
    struct MIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGA>(arg0, 9, b"MIGA", b"Tiger", b"Crying Tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e637799d-d8d7-4cd6-8666-7ad3c4bfcd76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

