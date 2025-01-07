module 0xfdeeadf1f54e12f030ca4233e586a7270f4864e864b443bf7ee67e02086bc626::hd {
    struct HD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HD>(arg0, 9, b"HD", b"WER", b"HGF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc41ef06-fc1c-4d93-ada4-2275000ff21a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HD>>(v1);
    }

    // decompiled from Move bytecode v6
}

