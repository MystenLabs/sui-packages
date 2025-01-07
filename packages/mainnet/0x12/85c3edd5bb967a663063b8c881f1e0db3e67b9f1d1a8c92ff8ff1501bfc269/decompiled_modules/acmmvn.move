module 0x1285c3edd5bb967a663063b8c881f1e0db3e67b9f1d1a8c92ff8ff1501bfc269::acmmvn {
    struct ACMMVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACMMVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACMMVN>(arg0, 9, b"ACMMVN", b"Acmm", b"Tokenhot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5f9a4af-d933-49b3-a65c-261a5663db24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACMMVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACMMVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

