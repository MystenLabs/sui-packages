module 0x36248a06fe518dc2edb6cab8717061da9600bc73181b6ee6d03d65b028aad4aa::neil {
    struct NEIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIL>(arg0, 6, b"Neil", b"Neil The Suiel", x"546865204d6f73742046616d6f7573205365616c2046726f6d2054696b20546f6b204973204e6f77204f6e205375692c2035302070657263656e74206f6620746865207465616d2077616c6c65742077696c6c206265207573656420746f20646f6e61746520746f204e65696c0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_20_26_58_e7045bc592_55f0d34a22.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

