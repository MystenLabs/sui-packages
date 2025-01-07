module 0x775c52e8ff03c62c3b15cab33382e6034feee97bd245a3127f71ff2be2592d1a::pixel {
    struct PIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXEL>(arg0, 9, b"PIXEL", b"Not Pixel", x"31354d20706978656c7320616c7265616479206865726520f09fa48d0a0a41207374756e6e696e67206d696c6573746f6e652c2068756765207468616e6b7320746f2065766572796f6e650a0a427574207468652063656c6562726174696f6e2077696c6c207374617274206120626974206c617465720a0a4e6f7420506978656c20322e3020697320616c7265616479206f6e207468652077617920f09f9a800a0a4e657874207765656b2c2067657420796f75722074656d706c617465732026206368616d7061676e652072656164790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b9581bb-ad3d-4fb6-9afc-76cde167d67c-IMG_20241005_082422_075.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

