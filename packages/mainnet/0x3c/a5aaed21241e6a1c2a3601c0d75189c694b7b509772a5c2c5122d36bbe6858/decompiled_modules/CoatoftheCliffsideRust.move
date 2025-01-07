module 0x3ca5aaed21241e6a1c2a3601c0d75189c694b7b509772a5c2c5122d36bbe6858::CoatoftheCliffsideRust {
    struct COATOFTHECLIFFSIDERUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: COATOFTHECLIFFSIDERUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COATOFTHECLIFFSIDERUST>(arg0, 0, b"COS", b"Coat of the Cliffside Rust", b"Ah! For what is a life in the mining camps, if not a joyful tarnishing?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Coat_of_the_Cliffside_Rust.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COATOFTHECLIFFSIDERUST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COATOFTHECLIFFSIDERUST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

