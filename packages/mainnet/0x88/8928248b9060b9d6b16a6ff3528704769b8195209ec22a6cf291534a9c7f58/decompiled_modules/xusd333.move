module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::xusd333 {
    struct XUSD333 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XUSD333>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XUSD333>>(0x2::coin::mint<XUSD333>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: XUSD333, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUSD333>(arg0, 9, b"XUSD333", b"XUSD Commodity", x"5855534420436f6d6d6f6469747920746f6b656e20e28094204669626f6e6163636920737570706c793a203337372e20496e737572616e63653a203130306270732e2058616861753a20724c674244576b4e48514a58546f5745767142717a33333864517164696b436d3273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/xusd333.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XUSD333>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUSD333>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

