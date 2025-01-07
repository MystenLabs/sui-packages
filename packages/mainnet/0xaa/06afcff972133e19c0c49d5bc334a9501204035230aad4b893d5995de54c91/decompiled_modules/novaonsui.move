module 0xaa06afcff972133e19c0c49d5bc334a9501204035230aad4b893d5995de54c91::novaonsui {
    struct NOVAONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVAONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVAONSUI>(arg0, 9, b"Novaonsui", b"Nova", x"546865206661737465737420616e642073696d706c6573742077617920746f207377617020636f696e73206f6e200a405375694e6574776f726b0a2064657369676e65642062792074686520636f6d6d756e69747920666f722074686520636f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e49b7ad038b6ed7e0153cef1e6550279blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOVAONSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVAONSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

