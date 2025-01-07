module 0xa199e780b4f887563f70fab7703bde961411874ebfce1587bedbfce5ca3aa980::amel {
    struct AMEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMEL>(arg0, 9, b"AMEL", b"Amelia", b"Amelia Shilova", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aeb62ff9-5447-42e3-847b-0ca36979e0d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

