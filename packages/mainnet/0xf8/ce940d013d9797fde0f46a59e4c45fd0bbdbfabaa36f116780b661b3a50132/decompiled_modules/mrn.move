module 0xf8ce940d013d9797fde0f46a59e4c45fd0bbdbfabaa36f116780b661b3a50132::mrn {
    struct MRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRN>(arg0, 9, b"MRN", b"Mehran", b"For huntrs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1bacfb8-e0bf-4009-bfcb-9b1207f1523d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

