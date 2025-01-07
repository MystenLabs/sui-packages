module 0xa300e89ef24263180b847e9d8e391bfd9e49621664f427310cad5378a84429cd::syc {
    struct SYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYC>(arg0, 9, b"SYC", b"Sycap", b"A potential airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b950dcc-0939-41c5-8608-1424ffddb7d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

