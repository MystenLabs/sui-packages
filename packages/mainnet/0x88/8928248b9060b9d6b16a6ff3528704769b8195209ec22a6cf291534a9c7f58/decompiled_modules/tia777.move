module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::tia777 {
    struct TIA777 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TIA777>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TIA777>>(0x2::coin::mint<TIA777>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TIA777, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIA777>(arg0, 9, b"TIA777", b"TIAMAT", x"5469616d617420746f6b656e20e28094204669626f6e6163636920737570706c793a20323538342e20496e737572616e63653a203130306270732e2058616861753a20724e4d6d34584179436d69364836445463745a78633478375a764e36746d4338796f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/tia777.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIA777>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIA777>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

