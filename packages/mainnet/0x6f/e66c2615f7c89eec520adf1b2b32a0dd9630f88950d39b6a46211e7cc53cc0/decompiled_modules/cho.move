module 0x6fe66c2615f7c89eec520adf1b2b32a0dd9630f88950d39b6a46211e7cc53cc0::cho {
    struct CHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHO>(arg0, 9, b"CHO", b"cho", b"VINAHOUSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d2b84a6-8de6-4208-9ef9-b90a1078114a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

