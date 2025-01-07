module 0x5a35cd7a1bcea6006f7dd1db2cc82d1fd4a635c628e96c8bf736c87ab2fac50b::rica {
    struct RICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICA>(arg0, 9, b"RICA", b"Arco", b"Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/237746f5-308f-4ccb-b781-65e5d9b26320.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

