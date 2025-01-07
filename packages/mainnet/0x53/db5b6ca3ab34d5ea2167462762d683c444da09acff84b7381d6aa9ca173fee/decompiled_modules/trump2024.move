module 0x53db5b6ca3ab34d5ea2167462762d683c444da09acff84b7381d6aa9ca173fee::trump2024 {
    struct TRUMP2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP2024>(arg0, 6, b"TRUMP2024", b"Mr. President", x"546865204f726967696e616c204d722e507265736964656e7420746f6b656e2069737375656420746f20737570706f727420446f6e616c642773205472756d702043616d706169676e206f6e20686973207761792074686520426174746c6520666f722074686520576869746520486f7573652e20427579696e67207468697320746f6b656e2077696c6c206e6f74206f6e6c7920737570706f727420446f6e616c64205472756d70206275742077696c6c20616c736f2067657420796f752066757475726520726577617264732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_Uuht00m_400x400_aae06f24dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP2024>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

