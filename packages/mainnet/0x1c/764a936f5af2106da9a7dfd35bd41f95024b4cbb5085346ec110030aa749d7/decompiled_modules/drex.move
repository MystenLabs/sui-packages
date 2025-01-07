module 0x1c764a936f5af2106da9a7dfd35bd41f95024b4cbb5085346ec110030aa749d7::drex {
    struct DREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREX>(arg0, 9, b"DREX", b"DINO", b"DINO is a cute meme that needs to be carried out by someone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4470082-bcc6-4d9e-945b-53c2a02dd005.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

