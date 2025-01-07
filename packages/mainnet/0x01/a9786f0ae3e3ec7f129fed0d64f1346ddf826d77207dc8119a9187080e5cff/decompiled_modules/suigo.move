module 0x1a9786f0ae3e3ec7f129fed0d64f1346ddf826d77207dc8119a9187080e5cff::suigo {
    struct SUIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGO>(arg0, 9, b"SUIGO", b"SUI-Go Tok", x"546f6b656e207468617420426f6f6d206c617465720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb95ae6e-8f51-49a1-aada-7f3efe9398ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

