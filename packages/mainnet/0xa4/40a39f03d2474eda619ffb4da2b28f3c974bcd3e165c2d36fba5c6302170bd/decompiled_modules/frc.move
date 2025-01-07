module 0xa440a39f03d2474eda619ffb4da2b28f3c974bcd3e165c2d36fba5c6302170bd::frc {
    struct FRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRC>(arg0, 9, b"FRC", b"FearCoin", b"Tis Token Is Scary ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f49f276-6197-4d1a-a646-58ce66090428.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

