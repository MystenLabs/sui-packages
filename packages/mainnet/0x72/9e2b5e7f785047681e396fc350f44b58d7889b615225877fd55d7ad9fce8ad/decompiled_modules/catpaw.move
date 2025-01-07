module 0x729e2b5e7f785047681e396fc350f44b58d7889b615225877fd55d7ad9fce8ad::catpaw {
    struct CATPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATPAW>(arg0, 9, b"CATPAW", b"Cats", b"Cat paws is a good community token with strong backup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5118695-28f4-4371-bfe2-7abdbf55b351.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATPAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATPAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

