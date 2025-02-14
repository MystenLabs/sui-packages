module 0x49a91a4712bcdce42168551cba3050ebe63671f94751103e08d821ba9c408625::md29 {
    struct MD29 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD29, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD29>(arg0, 9, b"MD29", b"Mindi2911", b"funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42e8a32f-6df9-410e-8bcb-83d5ecf55214.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD29>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MD29>>(v1);
    }

    // decompiled from Move bytecode v6
}

