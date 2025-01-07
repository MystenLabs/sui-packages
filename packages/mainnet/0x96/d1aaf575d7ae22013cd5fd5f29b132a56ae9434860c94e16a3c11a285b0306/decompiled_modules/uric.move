module 0x96d1aaf575d7ae22013cd5fd5f29b132a56ae9434860c94e16a3c11a285b0306::uric {
    struct URIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: URIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URIC>(arg0, 9, b"URIC", b"Unity Rich", b"a community-driven utility token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eeca10fc-9945-42bc-bfaa-4830068fd110.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<URIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

