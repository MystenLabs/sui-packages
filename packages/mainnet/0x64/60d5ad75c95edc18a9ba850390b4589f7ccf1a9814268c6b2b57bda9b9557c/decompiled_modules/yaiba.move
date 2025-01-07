module 0x6460d5ad75c95edc18a9ba850390b4589f7ccf1a9814268c6b2b57bda9b9557c::yaiba {
    struct YAIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAIBA>(arg0, 9, b"YAIBA", b"KIMETSU", b"HEHEHE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bcf192dc-0e9c-49ce-a3b3-b7487b5d1a2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

