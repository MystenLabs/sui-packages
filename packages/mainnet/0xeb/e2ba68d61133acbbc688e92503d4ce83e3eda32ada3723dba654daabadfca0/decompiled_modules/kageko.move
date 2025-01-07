module 0xebe2ba68d61133acbbc688e92503d4ce83e3eda32ada3723dba654daabadfca0::kageko {
    struct KAGEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAGEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAGEKO>(arg0, 9, b"KAGEKO", b"Kageko con", b"Kagekoco ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5be236dc-5ab5-46ae-b5eb-68b10e5c9bb7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAGEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAGEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

