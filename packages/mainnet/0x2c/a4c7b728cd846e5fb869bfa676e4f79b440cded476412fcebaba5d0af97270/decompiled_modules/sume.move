module 0x2ca4c7b728cd846e5fb869bfa676e4f79b440cded476412fcebaba5d0af97270::sume {
    struct SUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUME>(arg0, 6, b"SUME", b"SUIME", x"245355494d45202331206d656d65636f696e206f6e200a405375694e6574776f726b0a2e205375696d65206973206e6f74206a7573742061206d656d652c20697427732061206d6f76656d656e7421204f757220636f6d6d756e69747920697320756e6974656420746f2068656c70205375696d65206163726f737320746865205375696e616d69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_MEME_73c5ee7637.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUME>>(v1);
    }

    // decompiled from Move bytecode v6
}

