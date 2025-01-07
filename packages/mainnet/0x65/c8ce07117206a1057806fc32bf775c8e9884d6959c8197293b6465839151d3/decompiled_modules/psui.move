module 0x65c8ce07117206a1057806fc32bf775c8e9884d6959c8197293b6465839151d3::psui {
    struct PSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUI>(arg0, 9, b"PSUI", b"Prison", b"For knowledge ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96720c60-9c7a-47e9-b260-e18173d90e1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

