module 0xc0f45d583f7559da3cad7c9bf2a21972819b826b432689e952c8aa70b91026f1::prince {
    struct PRINCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRINCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRINCE>(arg0, 6, b"PRINCE", b"Prince", b"Prince!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/9mEWn-yMC2jIQFZhRCr494-sqVosx3ieDcfu-uUJRb8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRINCE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRINCE>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRINCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

