module 0xce337bf134602b43e7c4c7b2e671fee36a0011c10459f2e2f0022f3718e85120::stl {
    struct STL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STL>(arg0, 9, b"STL", b"Starlink", b"Internet from spece for human on Earth. Engineered by @SpaceX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e68c428-06d5-4db0-a8c0-5ae1950ec029.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STL>>(v1);
    }

    // decompiled from Move bytecode v6
}

