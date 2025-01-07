module 0x71c5ae271e37b64ff330bbea0f9c5ad929bef024d4d88669a090bfc2e9967b4c::pora {
    struct PORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORA>(arg0, 9, b"PORA", b"Pora cat", b"Poracat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec14b737-d902-4602-8ac6-f021bb7ef9c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

