module 0x4713f157d950137ef4695ff395a39f399ba4ef576832579df2bc132027af3738::sti {
    struct STI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STI>(arg0, 9, b"STI", b"Stiber", b"Best token stb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42a43703-b6e5-49bb-ad80-cc4c155eecae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STI>>(v1);
    }

    // decompiled from Move bytecode v6
}

