module 0x4300b3d55b7cfe85d7bf23514b3d665c4ab433b3544e9c398f8d2b4d30b881ba::blud {
    struct BLUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUD>(arg0, 9, b"BLUD", b"Blud", b"BLUDE Trust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7623060-c159-49e0-9a68-6b8df4f82d42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

