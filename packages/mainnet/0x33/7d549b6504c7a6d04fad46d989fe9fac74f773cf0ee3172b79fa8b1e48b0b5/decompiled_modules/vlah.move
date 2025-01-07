module 0x337d549b6504c7a6d04fad46d989fe9fac74f773cf0ee3172b79fa8b1e48b0b5::vlah {
    struct VLAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLAH>(arg0, 9, b"VLAH", b"VILLAZH", x"496d6167696e652061206c75787572696f75732076696c6c612d7468656d6564206272616e6420746861742063617074757265732074686520657373656e6365206f662072656c61786174696f6e2c206578636c7573697669747920616e642068696768206c6976696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f237076d-49bb-4c2f-aa3e-c1b2e40ca8ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VLAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

