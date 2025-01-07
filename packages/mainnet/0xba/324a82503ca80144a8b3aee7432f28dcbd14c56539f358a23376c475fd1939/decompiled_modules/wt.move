module 0xba324a82503ca80144a8b3aee7432f28dcbd14c56539f358a23376c475fd1939::wt {
    struct WT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WT>(arg0, 9, b"WT", b"Winter", b"WINTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/889004e7-d713-4891-a398-bb940f6631bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WT>>(v1);
    }

    // decompiled from Move bytecode v6
}

