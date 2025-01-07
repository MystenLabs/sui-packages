module 0xb16db4d14d8b6a2406a6715198dddaf610529d1e1b997d9c73b7d0b9a5e65f9d::EarsoftheCliffsideRust {
    struct EARSOFTHECLIFFSIDERUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARSOFTHECLIFFSIDERUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARSOFTHECLIFFSIDERUST>(arg0, 0, b"COS", b"Ears of the Cliffside Rust", b"Over the vents with you! Through the mountain of fire! Set forth!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Ears_of_the_Cliffside_Rust.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARSOFTHECLIFFSIDERUST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARSOFTHECLIFFSIDERUST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

