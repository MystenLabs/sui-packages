module 0xcc6bfb52b951061e2fa0f05878ebba7e7e61a0ed71e4b9a6f7efbda5e8d40a52::mnsh {
    struct MNSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNSH>(arg0, 9, b"MNSH", b"MOONSH", x"496d6167696e652061206e6175746963616c207468656d6564206272616e6420746861742063617074757265732074686520737069726974206f66206578706c6f726174696f6e20616e6420746865206f70656e206f6365616e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8daedbfc-0d9b-4edb-8454-a59d978d889d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

