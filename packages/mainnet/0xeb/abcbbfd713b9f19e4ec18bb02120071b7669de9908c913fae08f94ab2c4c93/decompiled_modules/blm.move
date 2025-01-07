module 0xebabcbbfd713b9f19e4ec18bb02120071b7669de9908c913fae08f94ab2c4c93::blm {
    struct BLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLM>(arg0, 9, b"BLM", b"BLOM", b"Fake of Blum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab09d6b7-590f-4616-8422-c1247f94d60f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

