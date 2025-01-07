module 0xe8838cafc0df2a81e3da8c2eb8c369eab97c150c94022e3969c3f73cb456598a::GraceoftheGates {
    struct GRACEOFTHEGATES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHEGATES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHEGATES>(arg0, 0, b"COS", b"Grace of the Gates", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Gates.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHEGATES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHEGATES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

