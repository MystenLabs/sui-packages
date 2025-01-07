module 0xc35c61358ba69c13fbf3a6b862c2a9ee6c8676135a17d66e5fe3966a6dff375f::owndb {
    struct OWNDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWNDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWNDB>(arg0, 9, b"OWNDB", b"djndb", b"ehbev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d912f7dc-6b59-4ed3-a83f-51f2a03b7ed8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWNDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWNDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

