module 0xaca5d51ed0f7a4b80e8980c52bcf2d4cb9757f68c111840d797a4337e5e9b4ee::wrr {
    struct WRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRR>(arg0, 9, b"WRR", b"WARRIOR", b"MEME COIN FOR EVERY WARRIOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/feff0473-969e-4989-8c33-5fff06a1197b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

