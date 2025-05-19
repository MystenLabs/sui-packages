module 0x378153d593c2192ab833171d14a06a4ccd44e322d16e0639add808cf9fa82afa::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCA>(arg0, 6, b"ORCA", b"Orca The Pokemon Predator", b"Welcome to orca the pokemon and pudgy predator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreickso4l5rqi3dqmd7wicg3sqrtdvoh4vutnhumxtd2flqrngwi52i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORCA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

