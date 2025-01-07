module 0x68eb1f177f78d805fa6e7f3b7550bee281658ce01d9a199651dcaadb9f4a04f4::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 9, b"NAMI", b"Momi Nami", b"Momi Nami Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d0dd46f-eafc-448e-b3cc-a2856cea02bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

