module 0xda6158fbfe1db9802c4d36091f7cb07f7597f4a62e25eb66c471a0ca6a560837::slork {
    struct SLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLORK>(arg0, 6, b"SLORK", b"SLORK COIN", x"534c4f524b2024534c4f524b206973206120537569206261736564206d656d6520636f696e20666561747572696e6720616e20696d616765206f66206120736c6565707920536c6f74682e2049742069732064657369676e656420746f206272696e672068756d6f7220616e64206c697175696469747920746f205375690a0a68747470733a2f2f742e6d652f534c4f524b5355490a68747470733a2f2f782e636f6d2f534c4f524b5355490a68747470733a2f2f736c6f726b7375692e78797a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3608_968887045e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

