module 0x6f4fd749d33c34d7b45da6c83ae8c54d9112d1e998ddd05de4ab138e0d78e102::waf {
    struct WAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAF>(arg0, 9, b"WAF", b"WAIFU Too", b"King Waifu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/922174dc-2f18-4812-b4c7-22e3ffcf1ed1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

