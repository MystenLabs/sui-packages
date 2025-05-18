module 0x772d154bd510b0eabc8541e7650ccbff78d281a39ec583a7aa47a3c50ff86970::kfrc {
    struct KFRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFRC>(arg0, 6, b"KFRC", b"King Froc", b"KFRC is the king of frogs in the sea, land and air, unite into a powerful and invincible $KFRC force", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidmbz4ckmap6oa6e7dighhgeiaausedefhdtv73ha55on4f7gn2gu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KFRC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

