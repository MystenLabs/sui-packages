module 0x6d4c7ae3a06ee2212bfa675ff091c1ecd1072b08229bfcfb9c4e6dc46bd869e1::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 9, b"BBB", b"Blop", b"The next AAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/673ea5b8-fb43-49b0-86fd-04638147207c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

