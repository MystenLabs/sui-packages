module 0x7bbe1721f869adf5f4f9ab0be2682112e1f97b3266bd994980550bf6b0e83a24::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOO>(arg0, 6, b"Boo", b"The world cutest dog", b"My name is Boo. I am a dog. Life is good. The world's cutest dog, Boo, has died of a broken heart. This token dedicated for bringing back boo from dead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958905619.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

