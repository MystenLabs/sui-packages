module 0x4e86091d5cdfd88b7c4d85e83a3447c16fe56ebad08aa4b13810cc9f2b090e8f::pkh {
    struct PKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKH>(arg0, 9, b"PKH", b"HDA", b"EU and I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15c7afea-18ea-47b3-94be-036e1974bf64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

