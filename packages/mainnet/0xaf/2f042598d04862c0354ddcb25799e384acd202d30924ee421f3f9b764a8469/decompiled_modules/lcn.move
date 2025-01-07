module 0xaf2f042598d04862c0354ddcb25799e384acd202d30924ee421f3f9b764a8469::lcn {
    struct LCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCN>(arg0, 9, b"LCN", b"LOCOIN", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d7fb5cc-6531-40d6-92f3-3801d01dc21a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

