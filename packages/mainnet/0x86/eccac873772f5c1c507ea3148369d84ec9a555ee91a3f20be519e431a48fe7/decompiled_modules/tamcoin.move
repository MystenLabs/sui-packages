module 0x86eccac873772f5c1c507ea3148369d84ec9a555ee91a3f20be519e431a48fe7::tamcoin {
    struct TAMCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMCOIN>(arg0, 9, b"TAMCOIN", b"TammyMille", b"trading wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0eb178c-99d5-4758-b125-4668b0a52f7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAMCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

