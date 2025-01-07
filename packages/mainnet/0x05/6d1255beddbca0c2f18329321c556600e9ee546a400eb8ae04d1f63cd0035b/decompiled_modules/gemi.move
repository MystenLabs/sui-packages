module 0x56d1255beddbca0c2f18329321c556600e9ee546a400eb8ae04d1f63cd0035b::gemi {
    struct GEMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMI>(arg0, 9, b"GEMI", b"GemsInc", b"Gems incubator ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66e37a13-5542-40e0-83b2-0ffab02c6eed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

