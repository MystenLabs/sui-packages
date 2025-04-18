module 0xf6b61e1a67a870e851a45e93a899f6280eda276335547fdbe4abf643f9b33cbd::dems {
    struct DEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMS>(arg0, 9, b"DEMS", b"DeMS-13", b"https://x.com/WarlordDilley/status/1913252448182948106?t=5P8qyG8WHJs66TT2l7BoOw&s=19", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e10c5cc-e4c1-4ac7-a550-c51987d4e44b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

