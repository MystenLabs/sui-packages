module 0x373334bb62f82f201529a0a65e75d3a24e353ef86c648e90a4356ea89ea68ce8::prch {
    struct PRCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRCH>(arg0, 9, b"PRCH", b"PORSCHE", x"687572727920757020496d6167696e652061207374796c69736820616e64206c75787572696f7573206272616e64207468617420726570726573656e747320736f706869737469636174696f6e20616e642073706565640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8513ce72-1718-44ae-8fa2-2ea16d4d9eff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

