module 0x2d8490f72a81c7316261bcf13d1f05d8b96f871dcc85c23b07fad47dd495d7e8::clob {
    struct CLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOB>(arg0, 9, b"CLOB", b"CLOB onSUI", b"Central Liquidity Ordered Book, exclusive on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e02ce58-c1a3-44d0-a111-1e0dc89ef391.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

