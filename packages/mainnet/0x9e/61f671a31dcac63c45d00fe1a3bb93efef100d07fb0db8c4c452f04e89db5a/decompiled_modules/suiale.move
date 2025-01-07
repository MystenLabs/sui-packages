module 0x9e61f671a31dcac63c45d00fe1a3bb93efef100d07fb0db8c4c452f04e89db5a::suiale {
    struct SUIALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIALE>(arg0, 6, b"SUIALE", b"Sui Whale $SUIALE", x"535549414c452069732061206c6567656e64617279206469676974616c207768616c65206c6976696e67206f6e207468652053554920626c6f636b636861696e2c2061207661737420646563656e7472616c697a6564206f6365616e206f6620736d61727420636f6e74726163747320616e64206469676974616c206173736574732c20617320612073796d626f6c206f6620737472656e6774682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Leonardo_Phoenix_2_D_art_of_a_majestic_blue_whale_with_a_gentle_0_6a8f556ef9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

