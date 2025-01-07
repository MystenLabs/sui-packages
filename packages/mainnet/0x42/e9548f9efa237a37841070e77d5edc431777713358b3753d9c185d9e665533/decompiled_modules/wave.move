module 0x42e9548f9efa237a37841070e77d5edc431777713358b3753d9c185d9e665533::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 9, b"WAVE", b"ClashOFWav", b"ClashOfWave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2cace1a-99af-46a5-a96c-c5d1eb75ca0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

