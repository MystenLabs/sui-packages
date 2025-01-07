module 0xaa889e02c733a0fd0bd8c1bcbc2617a55843bda3fcdc870ff5e900e850febb6e::mtb {
    struct MTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTB>(arg0, 6, b"MTB", b"MutantBlub", b"MutantBlub, the Degeneration of Blub! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_02_15_37_52_93fa5f0a5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

