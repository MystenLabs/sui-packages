module 0x65b249f42f5544e87d0c8bf88b3c69f915107cc9c9cf1500c7c5301fbdf22815::ali {
    struct ALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALI>(arg0, 9, b"ALI", b"Alibabab", b"Alibaba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec471c16-0896-44fb-be47-d1d108148700.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALI>>(v1);
    }

    // decompiled from Move bytecode v6
}

