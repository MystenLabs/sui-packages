module 0x88fabf6312ea5aab852fb5adde14819dba4aea94280f26f889bef7b2911e7611::fuk {
    struct FUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUK>(arg0, 9, b"FUK", b"FUk", b"Fuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c358026e-4fbe-4aea-bb48-1208d8ed9ec0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

