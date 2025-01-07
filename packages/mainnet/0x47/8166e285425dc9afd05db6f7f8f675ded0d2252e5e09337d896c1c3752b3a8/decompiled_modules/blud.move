module 0x478166e285425dc9afd05db6f7f8f675ded0d2252e5e09337d896c1c3752b3a8::blud {
    struct BLUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUD>(arg0, 6, b"BLUD", b"Blud on Sui", b"I Have question, are you real fucking degen?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x5c956df977f927910091ab7aed03bc4a1f0d223d_f303dc0712.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

