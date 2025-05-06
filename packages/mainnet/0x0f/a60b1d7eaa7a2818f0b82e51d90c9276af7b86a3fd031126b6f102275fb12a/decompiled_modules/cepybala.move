module 0xfa60b1d7eaa7a2818f0b82e51d90c9276af7b86a3fd031126b6f102275fb12a::cepybala {
    struct CEPYBALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEPYBALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEPYBALA>(arg0, 6, b"CEPYBALA", b"CEPYBALA SUIBALA", b"Cepybala Suibala (CEPYBALA) is the cutest sui memecoin, loaded with cepybala charm, ready to rocket to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicl5toyroryaxykj75kgyo4stmw4siqwna2f5mr66hpvpfycmaxmy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEPYBALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CEPYBALA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

