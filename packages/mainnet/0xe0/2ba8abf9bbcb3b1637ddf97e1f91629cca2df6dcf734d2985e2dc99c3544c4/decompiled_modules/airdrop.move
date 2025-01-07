module 0xe02ba8abf9bbcb3b1637ddf97e1f91629cca2df6dcf734d2985e2dc99c3544c4::airdrop {
    struct AIRDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRDROP>(arg0, 6, b"Airdrop", b"Airdrop ", x"2d70726f6a6563742064657369676e656420746f206769766520796f752066726565206d6f6e6579200a2d7765656b6c792064726f707320666f7220686f6c6465727320616e6420206c702070726f766964657273200a2d6c657473206d616b652069742068617070656e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732919600915.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIRDROP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRDROP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

