module 0xb99191d9bfadc6de01c0a9fc3ee16280e18ed08c7a0e1c51d02a6da3701c8ba6::go {
    struct GO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GO>(arg0, 9, b"GO", b"Cat", b"Is memefad to moud", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3af59278-ddba-47c5-8d87-02c02ca75d5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GO>>(v1);
    }

    // decompiled from Move bytecode v6
}

