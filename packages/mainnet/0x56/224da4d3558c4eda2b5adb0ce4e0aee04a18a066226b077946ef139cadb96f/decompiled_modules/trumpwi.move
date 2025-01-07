module 0x56224da4d3558c4eda2b5adb0ce4e0aee04a18a066226b077946ef139cadb96f::trumpwi {
    struct TRUMPWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWI>(arg0, 9, b"TRUMPWI", b"Trump win", b"Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d46f71f0-06ef-4c50-aa09-e2a0211b88a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

