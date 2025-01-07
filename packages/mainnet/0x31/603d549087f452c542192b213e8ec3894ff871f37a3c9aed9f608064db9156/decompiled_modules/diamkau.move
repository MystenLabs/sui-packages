module 0x31603d549087f452c542192b213e8ec3894ff871f37a3c9aed9f608064db9156::diamkau {
    struct DIAMKAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMKAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMKAU>(arg0, 9, b"DIAMKAU", b"Tolongkaki", b"Stupid meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fee3f24d-cfd7-4cb2-a3be-ab8adbd5124e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMKAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMKAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

