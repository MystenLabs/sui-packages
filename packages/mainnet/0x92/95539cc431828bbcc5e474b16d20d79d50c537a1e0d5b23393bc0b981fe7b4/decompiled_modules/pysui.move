module 0x9295539cc431828bbcc5e474b16d20d79d50c537a1e0d5b23393bc0b981fe7b4::pysui {
    struct PYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYSUI>(arg0, 9, b"pysui", b"polysui", x"e68ea8e8bf9b737569e5b0bde5bfabe58f91e5b195e9a284e6b58be5b882e59cba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PYSUI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYSUI>>(v2, @0x484d487128eb69739897bf71528d6310cf9215e6b5bc4570c9496cd6a2d490f5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

