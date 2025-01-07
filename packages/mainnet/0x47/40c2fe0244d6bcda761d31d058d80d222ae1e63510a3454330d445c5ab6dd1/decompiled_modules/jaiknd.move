module 0x4740c2fe0244d6bcda761d31d058d80d222ae1e63510a3454330d445c5ab6dd1::jaiknd {
    struct JAIKND has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAIKND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAIKND>(arg0, 9, b"JAIKND", b"Jjjans", b"Naomndnda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a796a119-eb92-43ad-9a7b-f0d3e249d069.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAIKND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAIKND>>(v1);
    }

    // decompiled from Move bytecode v6
}

