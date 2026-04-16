module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::rub666 {
    struct RUB666 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RUB666>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RUB666>>(0x2::coin::mint<RUB666>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RUB666, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUB666>(arg0, 9, b"RUB666", b"RUBBISH", x"5275626269736820746f6b656e20e28094204669626f6e6163636920737570706c793a20313539372e20496e737572616e63653a203130306270732e2058616861753a20727365356a66567078546b41776e6567666d6e5678594e42586a71684c7743767231", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/rub666.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUB666>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUB666>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

