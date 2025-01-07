module 0x711d80eef7e410a0c032cdc08991d3549637a1f5bee483480fce321ba082fb0c::CanopyBramble {
    struct CANOPYBRAMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANOPYBRAMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANOPYBRAMBLE>(arg0, 0, b"COS", b"Canopy Bramble", b"Discarded, abandoned, forgotten... yet so kind...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Canopy_Bramble.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CANOPYBRAMBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANOPYBRAMBLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

