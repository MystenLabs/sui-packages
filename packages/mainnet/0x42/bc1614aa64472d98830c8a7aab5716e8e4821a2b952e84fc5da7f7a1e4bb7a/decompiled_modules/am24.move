module 0x42bc1614aa64472d98830c8a7aab5716e8e4821a2b952e84fc5da7f7a1e4bb7a::am24 {
    struct AM24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AM24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AM24>(arg0, 9, b"AM24", b"America 24", b"This is the token of the Americas Presidential election.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab6b20d6-1070-4e35-9ecc-cf9619c00ee2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AM24>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AM24>>(v1);
    }

    // decompiled from Move bytecode v6
}

