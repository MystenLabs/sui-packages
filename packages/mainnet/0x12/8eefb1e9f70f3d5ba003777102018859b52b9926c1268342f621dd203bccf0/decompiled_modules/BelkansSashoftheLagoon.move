module 0x128eefb1e9f70f3d5ba003777102018859b52b9926c1268342f621dd203bccf0::BelkansSashoftheLagoon {
    struct BELKANSSASHOFTHELAGOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELKANSSASHOFTHELAGOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELKANSSASHOFTHELAGOON>(arg0, 0, b"COS", b"Belkan's Sash of the Lagoon", b"Left behind near a glowing portal...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Belkan's_Sash_of_the_Lagoon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELKANSSASHOFTHELAGOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELKANSSASHOFTHELAGOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

