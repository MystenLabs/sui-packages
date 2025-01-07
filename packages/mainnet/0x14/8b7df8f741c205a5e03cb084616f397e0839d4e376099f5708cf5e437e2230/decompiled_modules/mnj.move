module 0x148b7df8f741c205a5e03cb084616f397e0839d4e376099f5708cf5e437e2230::mnj {
    struct MNJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNJ>(arg0, 9, b"MNJ", b"Kim Minji", b"Just for Kim Minji out there", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8abdf265-8cd4-439e-ba84-085e232f8174.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

