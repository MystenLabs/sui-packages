module 0x61e101d6a0fcfdffc28a5a43e0baac24ac86d3895514142fd2478f59b102b3e3::zerebrosui {
    struct ZEREBROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEREBROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEREBROSUI>(arg0, 9, b"ZEREBROSUI", b"ZEREBRO", b"Zerebro is a new network of AI agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e22a3953-92dc-4c12-81d7-e1ccfd338f07.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEREBROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEREBROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

