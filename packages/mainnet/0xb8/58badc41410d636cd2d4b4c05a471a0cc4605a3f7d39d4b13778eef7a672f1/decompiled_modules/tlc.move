module 0xb858badc41410d636cd2d4b4c05a471a0cc4605a3f7d39d4b13778eef7a672f1::tlc {
    struct TLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLC>(arg0, 9, b"TLC", b"TrumpLCoin", b"Trump Lin Coin is our the Future! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c16e572e-5dd1-4433-a2bd-e024221492cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

