module 0x1a0e03ffa9bf1b5a4286f07a42726c64dbaafeb9afc107c6dff9a22fca46f7a0::wawesui {
    struct WAWESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWESUI>(arg0, 9, b"WAWESUI", b"wavesui", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f13fdbed-4246-46e1-9515-931bde9eb603.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

