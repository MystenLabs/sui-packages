module 0x8328854e43aef16139753fb8a4f880cd4517fdc983aff1211333ec8c4cd4ae34::rd {
    struct RD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RD>(arg0, 9, b"RD", b"RANDOM", b"My hiphop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4cd48a6-7c38-4a28-8026-8a9fdd9043de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RD>>(v1);
    }

    // decompiled from Move bytecode v6
}

