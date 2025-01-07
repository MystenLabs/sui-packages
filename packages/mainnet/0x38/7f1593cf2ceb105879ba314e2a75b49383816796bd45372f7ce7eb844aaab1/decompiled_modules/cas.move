module 0x387f1593cf2ceb105879ba314e2a75b49383816796bd45372f7ce7eb844aaab1::cas {
    struct CAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAS>(arg0, 9, b"CAS", b"Cat sui", b"Chilled cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c588670b-287f-453d-91b7-eee3ac48c0f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

