module 0xb340e7aaf4a6f1f4dd505c7e16534c5acc30787133ed1e427c73d0ce438a484e::memek_qfi {
    struct MEMEK_QFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_QFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_QFI>(arg0, 6, b"MEMEKQFI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_QFI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_QFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_QFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

