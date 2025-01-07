module 0xee6c4c0d2a1ca8b8dd58ec1d3a2705becb08c3be6a6cbf71236220bbd7eb02c9::agbai {
    struct AGBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGBAI>(arg0, 9, b"AGBAI", b"AG", b"Agbai is an ordinary boy born in the trenches but aims and fights to be the richest and the greatest man ever liveth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1831fb8a-403a-4d2d-8b19-88c47207d40f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

