module 0x6838175d7a2a12df338a8b4ce0a432f130d3932e899d2f86d41fda7ca4de4a0d::lcf {
    struct LCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCF>(arg0, 9, b"LCF", b"Lucifer", b"Lucifer is comong ...!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44d56fa0-a6d6-4ee2-bfd6-f6f9dc4e5ad9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

