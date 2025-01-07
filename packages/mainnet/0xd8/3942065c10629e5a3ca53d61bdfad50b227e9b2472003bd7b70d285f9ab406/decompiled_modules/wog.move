module 0xd83942065c10629e5a3ca53d61bdfad50b227e9b2472003bd7b70d285f9ab406::wog {
    struct WOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOG>(arg0, 9, b"WOG", b"Whale", x"5768616c65204f726967696e616c2047616e67737465720a4120736561736f6e656420696e766573746f7220616e64206561726c792061646f70746572206f66206469676974616c206173736574732c20706172746963756c61726c792074686f736520776974682061207374726f6e6720636f6d6d756e6974792d64726976656e20656c656d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/496488dd-f817-4182-97f5-4033d0222230.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

