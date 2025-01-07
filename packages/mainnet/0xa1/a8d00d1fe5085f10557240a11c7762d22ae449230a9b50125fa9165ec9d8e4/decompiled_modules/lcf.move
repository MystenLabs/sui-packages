module 0xa1a8d00d1fe5085f10557240a11c7762d22ae449230a9b50125fa9165ec9d8e4::lcf {
    struct LCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCF>(arg0, 9, b"LCF", b"Lucifer", b"Lucifer is comong ...!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e7420e1-e940-492d-aeb6-d6bdfb76b175.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

