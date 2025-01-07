module 0xcb73bfe7469fecc6a4de66c2785d6d34b31edc2a6e1098ff81193fc102f4ecf::RUGGEDBYRAMRAM {
    struct RUGGEDBYRAMRAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGGEDBYRAMRAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGGEDBYRAMRAM>(arg0, 0, b"COS", b"RUGGED BY RAMRAM", b"Limited-edition Aurahma swag from the Exclusive Battle Prototype event held in May 2023-the first playtesting experience for our Founding StarGarden holders-featuring a phrase uttered by a Legion member after being defeated in battle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/RUGGED_BY_RAMRAM.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUGGEDBYRAMRAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGGEDBYRAMRAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

