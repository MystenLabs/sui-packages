module 0xa8109b0286a655cf05ab6f8aaf4feedfa7cfe07a74b75141639613c943f060d6::sashaa {
    struct SASHAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHAA>(arg0, 9, b"SASHAA", b"SASHA ", x"0a5468697320746f6b656e20697320676f6f6420746f6b656e2c616e6420616c736f206973206120676f6f6420666561747572657320746f6b656e2061626f7574205361736861206c69666520616e642068697320636f6e747269627574696f6e206f6e2074656c656772616d20646576656c6f706d656e7420616e642068697320636f6e747269627574696f6e206f6e206e6f74636f696e2c207468697320697320612074656c656772616d20636f6d6d756e697479206261736520746f6b656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9aaf185b-74af-4174-a5bc-c8f2d9d36bf1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

