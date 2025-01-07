module 0x38c32af115e9df33d33e5b834b740687ef5a1a9904d535d083e34b0ba0449a12::weg {
    struct WEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEG>(arg0, 9, b"WEG", b"Emmanuel ", b"Wewe account ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3096c667-1ae1-4905-97f8-ae3d88b6a168.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

