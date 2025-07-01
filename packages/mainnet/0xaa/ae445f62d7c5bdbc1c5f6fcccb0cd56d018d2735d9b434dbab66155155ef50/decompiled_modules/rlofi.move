module 0xaaae445f62d7c5bdbc1c5f6fcccb0cd56d018d2735d9b434dbab66155155ef50::rlofi {
    struct RLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RLOFI>(arg0, 6, b"RLOFI", b"ROBOTI THE YETI", x"526f626f746920746865205965746920697320616e6f74686572206272616e63682066726f6d204c4f46492074686520796574692e0a0a576520636f6d6d697420746f206f757220646f6e6174696f6e732c20616e642074686973206973207468652066617374207061737320746f20746865206e657874204e4654206c61756e636820666f72206f7572204c4f4649206368617261637465722e0a0a2d206579657a656e686f7572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigktjucqlhbfrkdq4pxyfubannacorqb4z2d2reow7ggyrfgx7bki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RLOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RLOFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

