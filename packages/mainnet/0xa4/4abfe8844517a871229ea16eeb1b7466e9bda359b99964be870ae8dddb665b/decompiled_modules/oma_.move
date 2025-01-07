module 0xa44abfe8844517a871229ea16eeb1b7466e9bda359b99964be870ae8dddb665b::oma_ {
    struct OMA_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMA_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMA_>(arg0, 9, b"OMA_", b"OmaK", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d09f5d1b-74f7-4729-bf26-69b5ab2fafa5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMA_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMA_>>(v1);
    }

    // decompiled from Move bytecode v6
}

