module 0x57f6c33d2f92e9f912c473acdd0463aa48b3d11fd5b077cd3bd533eecd74d9c0::yeto {
    struct YETO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETO>(arg0, 6, b"YETO", b"LOFITHEYETO", b"LOFI THE YETO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidamezxgvynfo7gzz5s2kbgt6rjeigmnxzr3wxlbt3fgkelwm2rwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YETO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

