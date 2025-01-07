module 0x29f0d08566414417fc40e871a3c102d0cc6a9cd3c75d6c1d05eb746317fdfbb::ctb {
    struct CTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTB>(arg0, 9, b"CTB", b"CryptoBros", b"we are crypto maniac", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c80f8436-8feb-45dd-a38d-1e514235325f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

