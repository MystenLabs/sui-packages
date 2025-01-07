module 0x8f2425cfa076c83c51abef880f20a44558b9905e442cfefb7eee6d81921f72ea::PROROCKHOPPER {
    struct PROROCKHOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROROCKHOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROROCKHOPPER>(arg0, 0, b"COS", b"PRO ROCK HOPPER", b"Limited-edition Aurahma swag from the Exclusive Battle Prototype event held in May 2023-the first playtesting experience for our Founding StarGarden holders-to honor those who showed off their rock-hopping prowess.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/PRO_ROCK_HOPPER.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROROCKHOPPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROROCKHOPPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

