module 0x734b86077cf12db3336f893a0070b6cef57bbc21828135e1b3588adce65fa14d::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN>(arg0, 9, b"WIN", b"1win", x"3177696e206973206e6f74206a757374206120636c69636b65722c2069742069732070617274206f6620616e20656e746972652065636f73797374656d2e20506c61792c20696e637265617365207061737369766520696e636f6d652c20636f6d706c657465207461736b7320616e64206561726e207265616c20746f6b656e732e2047657420726561647920746f20696e74656772617465207468656d20696e746f20746865203177696e20706c6174666f726d210a506c61792077697468203177696e2c2077696e2077697468203177696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b5edf77-8c99-4ffa-9573-80661b69677e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

