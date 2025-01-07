module 0xc9851862455a5d714ecd919a3c161e05553d58b7b9fa722a54180f2be03642b5::mewsui {
    struct MEWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWSUI>(arg0, 9, b"MEWSUI", b"JustinMoon", b"Mew mew mew !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/458a69d7-695a-4f29-8090-2759cdb90830.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

