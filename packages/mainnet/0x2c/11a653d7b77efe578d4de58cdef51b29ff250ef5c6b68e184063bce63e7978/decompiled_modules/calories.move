module 0x2c11a653d7b77efe578d4de58cdef51b29ff250ef5c6b68e184063bce63e7978::calories {
    struct CALORIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALORIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALORIES>(arg0, 6, b"CALORIES", b"Calorie Sui", b"Calorie Sui is your intelligent coach within Genesis Virtuals. You spend $CALORIES, the ecosystem's currency, to unlock personalized routines, plans, and advice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigi2xeykrwimhqfwaorrgx5arccssnpnn3olkg4su7sbailnxskbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALORIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CALORIES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

