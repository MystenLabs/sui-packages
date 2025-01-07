module 0xe7d5e994a962d46cfcac466f442f8b71ca83db400e0fb2346b5896bcf5d6c2b0::dophin {
    struct DOPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPHIN>(arg0, 6, b"DOPHIN", b"DopinTheDolphin", x"54686520646f70656420636f6d6d756e6974792070726f6a656374206d616b696e67207761766573206f6e20535549200a405375694e6574776f726b0a20f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958434679.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPHIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPHIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

