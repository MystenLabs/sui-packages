module 0xaf742fdbc858c5412bc01590022a2e615d188f8d1b0429bdf33d2e65abb66b0::echo {
    struct ECHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHO>(arg0, 6, b"ECHO", b"ECHO the Seal", x"4543484f20746865205365616c200a0a4272696e67696e67207468652053554920436f6d6d756e69747920746f676574686572206e617669676174696e672074686520686967682073656173206f6620535549200a0a4543484f200a0a4541524e2043525950544f20484f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_500_x_500_px_306e9746df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

