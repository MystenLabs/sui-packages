module 0x4c5f85473b6e35d4cb52341a19ecc737f0345fa33e5227c5a4bf32aa99db57cd::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<IKA>(arg0, 6, b"IKA", b"Ikadotsxyz", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,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"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

