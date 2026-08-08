module 0xcda48a43624f9a4747b33a5348f308d17c8361697d1d3ae5c4ac7b664d0aae45::most {
    struct MOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOST>(arg0, 9, b"MOST", b"MOONSTAR", x"4d4f535420726570726573656e7473206d6f6d656e74756d20e28094207468652064726976696e6720666f726365206f6620696e6e6f766174696f6e206163726f737320646563656e7472616c697a65642065636f73797374656d732e0a4974e2809973206e6f74206a757374206120746f6b656e3b206974e280997320612073796d626f6c206f6620646174612076656c6f6369747920616e6420747275737420696e20746865205355492065636f2073797374656d2073796e657267792e", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MOST>>(0x2::coin::mint<MOST>(&mut v2, 9000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOST>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

