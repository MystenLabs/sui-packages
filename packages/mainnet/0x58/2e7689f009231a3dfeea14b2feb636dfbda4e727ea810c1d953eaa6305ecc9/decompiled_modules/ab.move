module 0x582e7689f009231a3dfeea14b2feb636dfbda4e727ea810c1d953eaa6305ecc9::ab {
    struct AB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AB>(arg0, 9, b"AB", b"Ab King", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05fad7ff-0326-4ab9-9f0f-f1393668b3b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AB>>(v1);
    }

    // decompiled from Move bytecode v6
}

