module 0xe69db4cd31a976bf8f05ced446715d350548307c7778656f96d534eaebf5944f::lore {
    struct LORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORE>(arg0, 6, b"LORE", b"pepelore", b"pepelore on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MA_Ko99_W_400x400_3cefa0b02c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

