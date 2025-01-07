module 0xbb0f4e1ac7a4a5d3ab8bef2ff17b787172fc80e34644967574b9c66b051aa127::dcck {
    struct DCCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCCK>(arg0, 9, b"DCCK", b"DCCK Air", b"DCCK Aidrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebb8564a-1c90-4b0e-a818-3bb752506fec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

