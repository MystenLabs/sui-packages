module 0x86cce7ce439dce9a9dc5ba3ae0bfc78bddd5c7cbde048c600fe409af624e72cb::mumu {
    struct MUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMU>(arg0, 9, b"MUMU", b"Mumu the b", b"The masscot of bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c60d6f08-84a0-4774-bc1a-b769918567f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

