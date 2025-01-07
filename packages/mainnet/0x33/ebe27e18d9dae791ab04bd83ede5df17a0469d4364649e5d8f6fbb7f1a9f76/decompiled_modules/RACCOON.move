module 0x33ebe27e18d9dae791ab04bd83ede5df17a0469d4364649e5d8f6fbb7f1a9f76::RACCOON {
    struct RACCOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACCOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACCOON>(arg0, 0, b"COS", b"RACCOON", b"Limited-edition Aurahma swag from the Exclusive Battle Prototype event held in May 2023-the first playtesting experience for our Founding StarGarden holders-featuring the sworn enemy of Mick Fear Son.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/RACCOON.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RACCOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACCOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

