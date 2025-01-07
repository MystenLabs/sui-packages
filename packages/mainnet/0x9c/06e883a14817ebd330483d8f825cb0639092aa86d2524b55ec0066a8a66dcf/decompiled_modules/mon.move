module 0x9c06e883a14817ebd330483d8f825cb0639092aa86d2524b55ec0066a8a66dcf::mon {
    struct MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MON>(arg0, 9, b"MON", b"MONYET", b"Stupid People Like a Monkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffe1c845-a6ef-44e7-aff3-5f1a71e30791.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MON>>(v1);
    }

    // decompiled from Move bytecode v6
}

