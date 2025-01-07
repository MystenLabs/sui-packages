module 0x3768ba8d4683528760c1c5fdb41aff02312647fb8f09c4106d5d5e615fbb2461::TroddenWinterpineCap {
    struct TRODDENWINTERPINECAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRODDENWINTERPINECAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRODDENWINTERPINECAP>(arg0, 0, b"COS", b"Trodden Winterpine Cap", b"Tinged with the light of adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Trodden_Winterpine_Cap.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRODDENWINTERPINECAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRODDENWINTERPINECAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

