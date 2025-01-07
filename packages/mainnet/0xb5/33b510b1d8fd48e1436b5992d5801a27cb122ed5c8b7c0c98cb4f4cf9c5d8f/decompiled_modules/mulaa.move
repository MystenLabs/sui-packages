module 0xb533b510b1d8fd48e1436b5992d5801a27cb122ed5c8b7c0c98cb4f4cf9c5d8f::mulaa {
    struct MULAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MULAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MULAA>(arg0, 9, b"MULAA", b"MULA", b"MULAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa7b6291-d9d0-4276-80d3-004fdfdc74a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MULAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MULAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

