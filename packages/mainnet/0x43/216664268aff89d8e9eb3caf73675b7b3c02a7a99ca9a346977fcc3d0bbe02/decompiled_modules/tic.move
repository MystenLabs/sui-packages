module 0x43216664268aff89d8e9eb3caf73675b7b3c02a7a99ca9a346977fcc3d0bbe02::tic {
    struct TIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TIC>(arg0, 6, b"TIC", b"ALLytic Ai by SuiAI", x"43727970746f20616e616c797a6572207573696e67204149207265617361726368206f6e20736f6369616c206d656469612e2e43727970746f204149206167656e74732063616e206175746f6d617465207461736b73206c696b6520616e616c797a696e6720626c6f636b636861696e20646174612c20747261636b696e6720736f6369616c206d65646961207472656e64732c20616e6420657865637574696e672074726164657320e28094206d616b696e672063727970746f20696e76657374696e6720656173696572207468616e206576657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_2_e6008eaca2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TIC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

