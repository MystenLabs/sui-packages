module 0x630cd610dfbd61fa7e5f6ff898585823bfc64ea28e9aec71422478df9ae6fd63::liu888 {
    struct LIU888 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIU888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIU888>(arg0, 9, b"LIU888", b"XXX", b"rsghfbfbbfbfb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1edfd2a2-e56e-4e5e-a8d9-b5ad3eb3e5bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIU888>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIU888>>(v1);
    }

    // decompiled from Move bytecode v6
}

