module 0x1eb53784879291af69678455135ae0c1bf5e88c2754972ee70e963b2bbc31c4b::potus {
    struct POTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTUS>(arg0, 9, b"POTUS", b"Camela", b"MAGA MUSK HEDGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34931c09-6c07-4044-bc7f-e0458c6a2468.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

