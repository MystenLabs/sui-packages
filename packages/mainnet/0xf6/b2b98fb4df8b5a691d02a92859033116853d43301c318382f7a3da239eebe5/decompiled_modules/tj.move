module 0xf6b2b98fb4df8b5a691d02a92859033116853d43301c318382f7a3da239eebe5::tj {
    struct TJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJ>(arg0, 9, b"TJ", b"WAVE", b"For funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9a2bef1-0c8a-48a9-9de3-461f28ba7444.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

