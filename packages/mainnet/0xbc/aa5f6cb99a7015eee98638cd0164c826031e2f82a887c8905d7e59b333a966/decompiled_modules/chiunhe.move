module 0xbcaa5f6cb99a7015eee98638cd0164c826031e2f82a887c8905d7e59b333a966::chiunhe {
    struct CHIUNHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIUNHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIUNHE>(arg0, 9, b"CHIUNHE", b"Chiuluon", b"Thu xem sao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2208459-4a29-4dcc-ada1-0f4d3fe1210f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIUNHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIUNHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

