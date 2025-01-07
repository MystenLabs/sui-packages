module 0xcde2fd571ecb2b3c571f4cc4c0277b44645dd8616bb64f2af9a2d7b8f9dc0707::mhrs {
    struct MHRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHRS>(arg0, 9, b"MHRS", b"mahrus", b"ghg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0249a74f-4b7f-471f-becb-58679d0d620f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

