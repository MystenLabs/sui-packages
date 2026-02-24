module 0x677e33ebf3c8b774e43dab75da948cb707350396cc791e46d66f0f0fb4e88ec7::mfc {
    struct MFC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MFC>, arg1: 0x2::coin::Coin<MFC>) {
        0x2::coin::burn<MFC>(arg0, arg1);
    }

    fun init(arg0: MFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFC>(arg0, 6, b"MFC", b"MFC", b"The official binx token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fZpgjr7.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MFC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MFC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MFC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

