module 0x6a755544d3b74f6a79f0ff02c2bda06bcb055fd7ffbb742e1ba6a05462f068a8::karma {
    struct KARMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARMA>(arg0, 6, b"Karma", b"Karma Coin", b"Generating good karma, cultivating inner peace, and contributing positively to the SUI community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749157150687.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KARMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

