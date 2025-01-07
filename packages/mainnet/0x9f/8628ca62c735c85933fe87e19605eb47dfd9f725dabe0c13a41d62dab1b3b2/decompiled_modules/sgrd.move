module 0x9f8628ca62c735c85933fe87e19605eb47dfd9f725dabe0c13a41d62dab1b3b2::sgrd {
    struct SGRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGRD>(arg0, 9, b"SGRD", b"Asgard", b"New render", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48c4c9e8-2723-4ebb-ad96-e897d8c6f24a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

