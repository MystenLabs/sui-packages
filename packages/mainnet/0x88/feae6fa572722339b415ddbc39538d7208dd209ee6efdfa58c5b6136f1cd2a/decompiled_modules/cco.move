module 0x88feae6fa572722339b415ddbc39538d7208dd209ee6efdfa58c5b6136f1cd2a::cco {
    struct CCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCO>(arg0, 9, b"CCO", b"COCONUT", b"Kelapa Muda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bf3ff7b-2ff1-4149-9675-d6f9ce6d77b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

