module 0x55a223b4975b12cc4017cb837792276f8480979ce66a0f5928def8429da96cd8::ln {
    struct LN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LN>(arg0, 9, b"LN", b"Leonas", b"Leonas actor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d16740c7-0e19-495f-ada2-2e9b91806ef1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LN>>(v1);
    }

    // decompiled from Move bytecode v6
}

