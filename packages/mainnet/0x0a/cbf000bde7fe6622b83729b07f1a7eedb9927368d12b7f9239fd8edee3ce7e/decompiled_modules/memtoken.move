module 0xacbf000bde7fe6622b83729b07f1a7eedb9927368d12b7f9239fd8edee3ce7e::memtoken {
    struct MEMTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMTOKEN>(arg0, 9, b"MEMTOKEN", b"STM ", b"STM MEMTOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce63ca04-e503-4a9e-b37f-92240c5f827e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

