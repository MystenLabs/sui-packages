module 0xdd861094f6f5da8dabce0ae4b462a8e9cc570c05d0512e7f168cc7f299bf3d2f::tlc {
    struct TLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLC>(arg0, 9, b"TLC", b"TrumpLCoin", b"Trump Lin Coin is our the Future! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a643a86-19d3-420e-877d-9cef7b3800fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

