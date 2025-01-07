module 0x72c466807a3a220a45e08397e0d182fc3a9c4cbcddbb1bc7cf632426155cadb8::rageface {
    struct RAGEFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAGEFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAGEFACE>(arg0, 9, b"RAGEFACE", b"Rage Face", b"A meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b216677d-33cd-47b1-b0cd-bfd9e6727884-IMG_0849.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAGEFACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAGEFACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

