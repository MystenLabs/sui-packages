module 0x5fb2c62ccc97189f2b402f26089156e227fa4820378b5c430154c0222d8f9b8a::ksx {
    struct KSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSX>(arg0, 9, b"KSX", b"KuroSX", b"Testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/117b1a7a-73c6-47ab-a2d0-46bcb0891697.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

