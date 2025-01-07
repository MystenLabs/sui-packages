module 0xac00625bc2221e839ec805bfdb1916853370fed5d4cd664ad857216ce757d985::ce {
    struct CE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CE>(arg0, 9, b"CE", b"CEagle", b"Crypto for all eagles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b4d8bfa-ea0a-4a90-9d32-687a4e95b4a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CE>>(v1);
    }

    // decompiled from Move bytecode v6
}

