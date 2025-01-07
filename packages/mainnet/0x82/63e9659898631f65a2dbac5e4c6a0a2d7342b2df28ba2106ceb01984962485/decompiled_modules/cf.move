module 0x8263e9659898631f65a2dbac5e4c6a0a2d7342b2df28ba2106ceb01984962485::cf {
    struct CF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CF>(arg0, 9, b"CF", b"CAFEIN", b"Meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78802efb-cbe9-4409-ab1e-785cacc4f31d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CF>>(v1);
    }

    // decompiled from Move bytecode v6
}

