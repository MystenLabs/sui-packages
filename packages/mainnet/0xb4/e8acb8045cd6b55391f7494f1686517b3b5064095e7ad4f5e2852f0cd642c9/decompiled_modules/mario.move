module 0xb4e8acb8045cd6b55391f7494f1686517b3b5064095e7ad4f5e2852f0cd642c9::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIO>(arg0, 9, b"Mario", b"SuperMario", b"This is a meme in honor of Mario Bros, the bravest plumber who ever existed, who inspired one of the best games in gaming history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c7b7c0ba6ab6b6e178823bb68466b41ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

