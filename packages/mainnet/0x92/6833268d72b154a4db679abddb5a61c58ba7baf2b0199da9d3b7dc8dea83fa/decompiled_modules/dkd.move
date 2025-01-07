module 0x926833268d72b154a4db679abddb5a61c58ba7baf2b0199da9d3b7dc8dea83fa::dkd {
    struct DKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKD>(arg0, 9, b"DKD", b"Ysjak", b"Dkdkkdjk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3cb8da1b-7c4c-4578-bdc0-baa854df45ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

