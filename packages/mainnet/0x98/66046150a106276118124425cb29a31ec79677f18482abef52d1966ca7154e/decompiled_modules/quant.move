module 0x9866046150a106276118124425cb29a31ec79677f18482abef52d1966ca7154e::quant {
    struct QUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANT>(arg0, 6, b"QUANT", b"Quantimodo", x"48652069732074686520776f727374207175616e74206f6e207468652053756920626c6f636b636861696e2e0a416c6c20746f702d626c617374732c2066756d626c6573202620726f756e6474726970732e0a486973206e616d65206973205175616e74696d6f646f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O0_SKYK_Sx_400x400_a5c244c726.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

