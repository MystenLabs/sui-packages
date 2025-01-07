module 0xdc1944e5b92034a20caf8a6e9d59b83af4f471a7bec68fea93691019679247ee::bony002 {
    struct BONY002 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONY002, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONY002>(arg0, 9, b"BONY002", b"BONKY", b"A silly clumsy funny looking ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/285c588e-202b-45cd-b750-ac3f56ee3031.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONY002>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONY002>>(v1);
    }

    // decompiled from Move bytecode v6
}

