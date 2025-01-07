module 0x50544c9825a1f2a9c931371b24d5dd9b5d6cf57f266aa8741cb096095e3b8f10::kjki {
    struct KJKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJKI>(arg0, 9, b"KJKI", b"KOKO", b"AMAZIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1dad738-9e01-41c1-86d1-15e6754b096a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KJKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

