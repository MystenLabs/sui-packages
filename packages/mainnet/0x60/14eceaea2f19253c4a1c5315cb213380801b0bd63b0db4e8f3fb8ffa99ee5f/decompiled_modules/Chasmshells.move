module 0x6014eceaea2f19253c4a1c5315cb213380801b0bd63b0db4e8f3fb8ffa99ee5f::Chasmshells {
    struct CHASMSHELLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHASMSHELLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHASMSHELLS>(arg0, 0, b"COS", b"Chasmshells", b"The shells, my atlas... the chasm, paradise...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Chasmshells.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHASMSHELLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHASMSHELLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

