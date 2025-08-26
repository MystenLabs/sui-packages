module 0x9584556df947714eaf7f6588c199e704dd8a2b62ee33576b5532ed9d8f7d23ea::Hello_World {
    struct HELLO_WORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO_WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO_WORLD>(arg0, 9, b"HLOW", b"Hello World", b"say hello to the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3KB4W1D9TECCJQA0AD9ME05.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO_WORLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO_WORLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

