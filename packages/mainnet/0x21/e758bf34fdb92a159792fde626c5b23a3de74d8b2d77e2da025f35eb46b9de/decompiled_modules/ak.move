module 0x21e758bf34fdb92a159792fde626c5b23a3de74d8b2d77e2da025f35eb46b9de::ak {
    struct AK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AK>(arg0, 9, b"AK", b"Alal", b"Ql", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7b5659a-e18c-4697-a56b-b54bdbecb676.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AK>>(v1);
    }

    // decompiled from Move bytecode v6
}

