module 0xf7d742e0f476af7419532e4e601ba5ab1607bd3863574c464301e66b14c67464::bububu {
    struct BUBUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBUBU>(arg0, 9, b"BUBUBU", b"bu10k", b"BUBUBU11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c077238-02b6-49c0-b5e5-5391e8d9862c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

