module 0xafca9a55f5e545083d1af063248b17ef82d02f33a47b01fc7b0a26538d2e873e::quant {
    struct QUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANT>(arg0, 6, b"QUANT", b"Quantimodo", x"48652069732074686520776f727374207175616e74206f6e207468652053756920626c6f636b636861696e2e200a416c6c20746f702d626c617374732c2066756d626c6573202620726f756e6474726970732e200a486973206e616d65206973205175616e74696d6f646f2e200a57656c636f6d6520746f20746865207265616c20636f756e74657263756c7475726520f09f92b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735995428655.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

