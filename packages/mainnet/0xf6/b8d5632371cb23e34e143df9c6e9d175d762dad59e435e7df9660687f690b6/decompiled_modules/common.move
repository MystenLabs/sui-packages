module 0xf6b8d5632371cb23e34e143df9c6e9d175d762dad59e435e7df9660687f690b6::common {
    struct COMMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMON>(arg0, 9, b"COMMON", b"Common", b"Everything is common, no rare, epic, legendary, mythic even special", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4dcdf8f0-0dfc-4b42-8500-1e5ce6d592f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

