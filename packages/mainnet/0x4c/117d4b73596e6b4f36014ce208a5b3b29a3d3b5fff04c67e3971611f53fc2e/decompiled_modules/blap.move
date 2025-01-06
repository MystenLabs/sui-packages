module 0x4c117d4b73596e6b4f36014ce208a5b3b29a3d3b5fff04c67e3971611f53fc2e::blap {
    struct BLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAP>(arg0, 6, b"BLAP", b"Blap Reborn", b"BLAP is a hybrid character formed from the combination of the four members of the Boys Club: Brett, Pepe, Andy, and Landwolf. Each member contributes their unique strengths and traits, creating BLAP as an unpredictable and energetic entity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241127_233400_2_7ea2db9568.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

