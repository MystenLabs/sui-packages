module 0x65a47f54a8f867af1e89b4ca601f25c50e4c3be034171c0dbfc550c339887c4a::tfml {
    struct TFML has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFML>(arg0, 9, b"TFML", b"The frog of Mysten Labs", x"486520776173206e6576657220737570706f73656420746f206c6561766520746865206c61622e2e2e20427574206f6e65206661746566756c206465766e6574206e696768742c20612066726f6720736c6970706564206f7574206f662061204d797374656e204c6162732074657374207475626520e2809420616e6420726967687420696e746f20796f75722077616c6c65742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/Pepeonsui/refs/heads/main/PEPEONSUI.GIF")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TFML>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFML>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TFML>>(0x2::coin::mint<TFML>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun lock_forever(arg0: 0x2::coin::TreasuryCap<TFML>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TFML>>(arg0);
    }

    // decompiled from Move bytecode v6
}

