module 0x102fb3efe947c824a34fada4d2bcff5bff4c9a9366937702e1762a71bcb50ae::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP>(arg0, 9, b"XRP", b"XRP King", b"The best blockchain. The king of Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3616784c-10fc-4268-9b44-4b1545a50e01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

