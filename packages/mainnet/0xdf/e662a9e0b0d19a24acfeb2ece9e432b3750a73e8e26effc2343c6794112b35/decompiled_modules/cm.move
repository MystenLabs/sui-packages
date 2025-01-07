module 0xdfe662a9e0b0d19a24acfeb2ece9e432b3750a73e8e26effc2343c6794112b35::cm {
    struct CM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CM>(arg0, 9, b"CM", b"CHRISTMAS", b"Buy this coin it will pump through out the Christmas period", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26beecf5-1524-4a34-a495-c15969b3a8eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CM>>(v1);
    }

    // decompiled from Move bytecode v6
}

