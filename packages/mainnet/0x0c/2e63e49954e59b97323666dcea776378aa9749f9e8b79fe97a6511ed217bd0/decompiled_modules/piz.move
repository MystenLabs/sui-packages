module 0xc2e63e49954e59b97323666dcea776378aa9749f9e8b79fe97a6511ed217bd0::piz {
    struct PIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZ>(arg0, 9, b"PIZ", b"Pizza", b"Only token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8099e86d-c630-4553-8607-4252b0f76368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

