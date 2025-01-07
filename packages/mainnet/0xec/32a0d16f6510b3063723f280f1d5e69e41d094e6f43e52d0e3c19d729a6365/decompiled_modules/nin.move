module 0xec32a0d16f6510b3063723f280f1d5e69e41d094e6f43e52d0e3c19d729a6365::nin {
    struct NIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIN>(arg0, 9, b"NIN", x"4ec3ad6e", b"a meme about popular sentence of a baby in Vietnam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3c9559d-339a-4fe1-8a34-883479bb0bda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

