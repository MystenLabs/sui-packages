module 0xebb0b9a7fa0729e381671311c5b9049a32dce544c344bc1423e4f48ad4a62cc4::rd {
    struct RD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RD>(arg0, 9, b"RD", b"RANDOM", b"My hiphop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56d374af-8f03-474c-b673-a20f1758cced.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RD>>(v1);
    }

    // decompiled from Move bytecode v6
}

