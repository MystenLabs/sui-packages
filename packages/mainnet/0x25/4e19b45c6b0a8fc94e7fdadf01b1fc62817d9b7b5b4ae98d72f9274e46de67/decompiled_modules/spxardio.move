module 0x254e19b45c6b0a8fc94e7fdadf01b1fc62817d9b7b5b4ae98d72f9274e46de67::spxardio {
    struct SPXARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPXARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPXARDIO>(arg0, 6, b"SPXARDIO", b"Spxardio 6900", b"$SPXARDIO: the meme coin where Murad's 6900 bros go full retardios and rockets us to the moon with zero logic and maximum chaos!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Kp_Q_Zjkq_400x400_825b41afd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPXARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPXARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

