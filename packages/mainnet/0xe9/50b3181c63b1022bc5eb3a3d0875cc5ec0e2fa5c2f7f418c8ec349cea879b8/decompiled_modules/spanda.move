module 0xe950b3181c63b1022bc5eb3a3d0875cc5ec0e2fa5c2f7f418c8ec349cea879b8::spanda {
    struct SPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPANDA>(arg0, 6, b"SPANDA", b"Sleepy Panda", x"546865204f726967696e616c20536c656570792050616e6461206f6e2053756920245350414e44410a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l49_O_Zyd0_400x400_b5912ee42e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

