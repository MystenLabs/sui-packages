module 0xce10ebb0c48c1500af74132a498dc8d5d164c10a5e16d3a501b31c949d3af3c9::lhjkjhkhkh {
    struct LHJKJHKHKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LHJKJHKHKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LHJKJHKHKH>(arg0, 9, b"LHJKJHKHKH", b"hhjkhkjhkj", b"jhkjhkhjhkjh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3792581f-02b5-402d-b6a0-264d164c38c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LHJKJHKHKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LHJKJHKHKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

