module 0x105f8651c91ea61308cdc00ab872b68f0629cfd18f8b5431ebc87f6bf6ffaea2::shrk {
    struct SHRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRK>(arg0, 9, b"SHRK", b"shamrock", b"Lucky, happy, funny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0badb4b-e186-48e5-882b-06bc26c56656.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

