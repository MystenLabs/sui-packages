module 0xd7bf43dcb6c7d1942a97d6e1c1ce4811603f0773b5d83e63f732c2d64f68b23b::AncientVision {
    struct ANCIENTVISION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANCIENTVISION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANCIENTVISION>(arg0, 0, b"COS", b"Ancient Vision", b"Guard-sealed by the stamp of a new kingdom... a new dominion...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Ancient_Vision.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANCIENTVISION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANCIENTVISION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

