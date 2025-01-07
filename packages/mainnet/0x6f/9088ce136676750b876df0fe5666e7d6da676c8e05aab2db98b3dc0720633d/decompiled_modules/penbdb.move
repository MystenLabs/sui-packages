module 0x6f9088ce136676750b876df0fe5666e7d6da676c8e05aab2db98b3dc0720633d::penbdb {
    struct PENBDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENBDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENBDB>(arg0, 9, b"PENBDB", b"isjdbd", b"dhbdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1444f7ea-f9b2-40f8-9332-b2896c8f249c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENBDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENBDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

