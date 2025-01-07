module 0xffdf9a6d8570b8462c2dc5841e95a030939fd649124afb08adcb31ada8e4c756::pook {
    struct POOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOK>(arg0, 9, b"POOK", b"Pook", b"Just some pook", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b5edbc8-0a14-4677-854a-df1b26ec8467.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

