module 0x6173c9950c4b0591ed5d118fc3c6b25af5585181968c9ee39409d30b435eb293::adaml {
    struct ADAML has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAML>(arg0, 9, b"ADAML", b"THAILE", b"hELO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10cc9d7b-506f-4cc1-a125-ee189017bf1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADAML>>(v1);
    }

    // decompiled from Move bytecode v6
}

