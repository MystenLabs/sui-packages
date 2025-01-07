module 0x4e8042323aa3de907fe2cf738506faad1c867e596f96104e30e335b94de45096::sadi {
    struct SADI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADI>(arg0, 6, b"SADI", b"SAD Cat", b"Sad cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sadi_9400c65812.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADI>>(v1);
    }

    // decompiled from Move bytecode v6
}

