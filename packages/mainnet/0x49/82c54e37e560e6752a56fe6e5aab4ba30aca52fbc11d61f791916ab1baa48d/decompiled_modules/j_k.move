module 0x4982c54e37e560e6752a56fe6e5aab4ba30aca52fbc11d61f791916ab1baa48d::j_k {
    struct J_K has drop {
        dummy_field: bool,
    }

    fun init(arg0: J_K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J_K>(arg0, 9, b"J_K", b"JOKER", x"426520612053696d706c652047757920696e204c6966652c202020202020202020202020202020202020202020202020202020202020202020202020202020204c696b652061204a4f4b455220f09fa4a120202020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32f91649-0278-435d-a07e-e1d084a07e76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J_K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J_K>>(v1);
    }

    // decompiled from Move bytecode v6
}

