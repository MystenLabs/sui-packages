module 0xe05f842f0e43a426e3187ed79822bcbc777bad073de35f5b8f7a22c60b7cb6b0::bigw {
    struct BIGW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGW>(arg0, 9, b"BIGW", b"Bigwaves", b"A big wave that Will shake your day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c439115-0350-4cf9-9dd4-545e733d6584.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGW>>(v1);
    }

    // decompiled from Move bytecode v6
}

