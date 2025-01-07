module 0x2ecc294d16428c8dfcbc7aa6340c9481f36dbeccef9dee7b8b05e89833964090::ocn {
    struct OCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCN>(arg0, 9, b"OCN", b"OCEAN", b"there is no such thing as too much water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e3c43e5-ff90-44b8-bb0b-b595988cd02d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

