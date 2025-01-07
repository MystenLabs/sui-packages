module 0xe66544dac9cbf16731c05a620684f64ea162bfd08ea7a9df57dbe2c36c4b9528::cucu {
    struct CUCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCU>(arg0, 9, b"CUCU", b"Cucurut", b"Future memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53035cb4-4e6a-4a4f-ba89-cc724fd08635.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUCU>>(v1);
    }

    // decompiled from Move bytecode v6
}

