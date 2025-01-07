module 0xeb3d999be98f576fef8f85a4627583e686bf6ce13324db5d2c994ce1051059af::wasao {
    struct WASAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASAO>(arg0, 6, b"WASAO", b"WASAO dog", b"Statue unveiled commemorating popular \"ugly-yet-cute\" Akita dog Wasao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e2031181_b3b5_41e2_aab6_7093833294f0_7adaa31566.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

