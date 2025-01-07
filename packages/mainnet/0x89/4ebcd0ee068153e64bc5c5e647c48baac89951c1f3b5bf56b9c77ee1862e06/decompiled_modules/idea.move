module 0x894ebcd0ee068153e64bc5c5e647c48baac89951c1f3b5bf56b9c77ee1862e06::idea {
    struct IDEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDEA>(arg0, 9, b"IDEA", b"IDEA 4 FUN", b"IDEA FOR FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f7260bc-4ff1-4f8a-b61d-7cd0db0a7ae8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

