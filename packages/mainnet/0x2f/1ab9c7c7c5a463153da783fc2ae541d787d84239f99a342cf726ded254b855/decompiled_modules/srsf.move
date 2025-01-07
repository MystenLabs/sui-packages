module 0x2f1ab9c7c7c5a463153da783fc2ae541d787d84239f99a342cf726ded254b855::srsf {
    struct SRSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRSF>(arg0, 6, b"SRSF", b"Sui Running Solana Falling", x"536f6c616e613a202249206e65656420746f20726573746172742c20677579732c206a7573742061206d6f6d656e7421220a0a5375693a2022496d20616c72656164792074686572652c2073656520796f7520617420746865206e65787420626c6f636b2e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirunner_c5dfc99998.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

