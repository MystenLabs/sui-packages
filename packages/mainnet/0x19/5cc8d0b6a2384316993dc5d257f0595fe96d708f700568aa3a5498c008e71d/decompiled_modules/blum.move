module 0x195cc8d0b6a2384316993dc5d257f0595fe96d708f700568aa3a5498c008e71d::blum {
    struct BLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUM>(arg0, 9, b"BLUM", b"Blum ", b"Your easy, fun crypto trading app for buying and trading any crypto on the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a31ccae0-011e-4028-919c-d3e56aaf41f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

