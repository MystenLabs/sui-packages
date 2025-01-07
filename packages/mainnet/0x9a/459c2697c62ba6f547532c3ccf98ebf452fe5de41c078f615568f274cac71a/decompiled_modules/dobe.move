module 0x9a459c2697c62ba6f547532c3ccf98ebf452fe5de41c078f615568f274cac71a::dobe {
    struct DOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBE>(arg0, 9, b"DOBE", b"Doberman", b"Dog who belive he is doberman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9d56ff9-92d9-48a5-b9a4-d8ebf36b5a5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

