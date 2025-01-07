module 0x76dbd91b3215eb9b2ffe6eb381113e2d61e3224b850938571577b4711caedb34::tlc {
    struct TLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLC>(arg0, 9, b"TLC", b"TrumpLCoin", b"Trump Lin Coin is our the Future! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb420165-da9d-4af7-8958-78e67ba18222.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

