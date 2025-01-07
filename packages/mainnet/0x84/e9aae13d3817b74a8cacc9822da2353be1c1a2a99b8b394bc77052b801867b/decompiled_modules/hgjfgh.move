module 0x84e9aae13d3817b74a8cacc9822da2353be1c1a2a99b8b394bc77052b801867b::hgjfgh {
    struct HGJFGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGJFGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGJFGH>(arg0, 9, b"HGJFGH", b"ASDASD", b"SDFGSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cba2a112-832d-4177-bce3-6728371808fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGJFGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HGJFGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

