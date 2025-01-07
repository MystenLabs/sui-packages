module 0x73e037684156e0be196420dbd967eda486f0e4788aa5fa45e00fc7b5c04b282a::rdt {
    struct RDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDT>(arg0, 9, b"RDT", b"TRUMP", x"5748415420434f554c440a504f535349424c590a474f2057524f4e473f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b87fae8-bda4-4e63-acae-b4e906e0f853.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

