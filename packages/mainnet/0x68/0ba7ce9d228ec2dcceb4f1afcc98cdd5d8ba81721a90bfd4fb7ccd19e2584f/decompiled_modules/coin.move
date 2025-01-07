module 0x680ba7ce9d228ec2dcceb4f1afcc98cdd5d8ba81721a90bfd4fb7ccd19e2584f::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, 6, b"SCAT", b"Sui Cat", b"Sui Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://207.148.66.213:4137/uploads/sui_asset_06eb47424f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

