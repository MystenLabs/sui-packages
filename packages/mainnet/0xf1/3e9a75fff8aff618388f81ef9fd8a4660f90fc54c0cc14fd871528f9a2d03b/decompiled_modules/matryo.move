module 0xf13e9a75fff8aff618388f81ef9fd8a4660f90fc54c0cc14fd871528f9a2d03b::matryo {
    struct MATRYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATRYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATRYO>(arg0, 9, b"MATRYO", b"Matryoshka", b"a wooden toy in the form of a painted doll containing smaller dolls similar to it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aeca8cfb-c196-4ae5-a989-a2474522a505.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATRYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATRYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

