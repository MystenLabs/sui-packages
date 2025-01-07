module 0x4bfc26eeb577919b55c5ca8a45b40440403637427536fb405c6c5e5872e12755::eloniom {
    struct ELONIOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONIOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONIOM>(arg0, 9, b"ELONIOM", b"Elon", b"Only the winners should be this token of Ilana's child", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0009de39-e765-400b-84b2-d5030b596f4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONIOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONIOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

