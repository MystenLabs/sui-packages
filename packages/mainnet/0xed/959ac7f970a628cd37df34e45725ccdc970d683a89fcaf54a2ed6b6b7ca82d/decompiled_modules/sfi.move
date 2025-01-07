module 0xed959ac7f970a628cd37df34e45725ccdc970d683a89fcaf54a2ed6b6b7ca82d::sfi {
    struct SFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFI>(arg0, 9, b"SFI", b"SUIFI", x"0a53756946692069732061204465466920746f6b656e206f6e2053756920626c6f636b636861696e2c206f66666572696e6720666173742c206c6f772d636f7374207472616e73616374696f6e7320616e642061207365637572652c20757365722d667269656e646c7920706c6174666f726d2e2044657369676e656420666f722073696d706c696369747920616e642067726f7774682c20537569466920737570706f727473207374616b696e672c207969656c64206661726d696e672c20616e64206c656e64696e672c20656d706f776572696e6720757365727320696e20646563656e7472616c697a65642066696e616e6365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a121ed7f-0635-48a9-aadd-9a4eab0dcfb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

