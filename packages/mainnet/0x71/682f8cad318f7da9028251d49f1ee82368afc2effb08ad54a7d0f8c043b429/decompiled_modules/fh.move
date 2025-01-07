module 0x71682f8cad318f7da9028251d49f1ee82368afc2effb08ad54a7d0f8c043b429::fh {
    struct FH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FH>(arg0, 9, b"FH", b"E", b"FB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/807d601d-ae89-42ad-bd2d-df3b5ecf2889.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FH>>(v1);
    }

    // decompiled from Move bytecode v6
}

