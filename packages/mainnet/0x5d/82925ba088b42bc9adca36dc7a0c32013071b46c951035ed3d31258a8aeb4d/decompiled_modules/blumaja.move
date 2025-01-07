module 0x5d82925ba088b42bc9adca36dc7a0c32013071b46c951035ed3d31258a8aeb4d::blumaja {
    struct BLUMAJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUMAJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUMAJA>(arg0, 9, b"BLUMAJA", b"BLUM", b"Blumje", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1a219a3-2b4c-412a-940f-176226ea71cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUMAJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUMAJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

