module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::zdc555 {
    struct ZDC555 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZDC555>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZDC555>>(0x2::coin::mint<ZDC555>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZDC555, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZDC555>(arg0, 9, b"ZDC555", b"ZEDEC Equity", x"5a454445432045717569747920746f6b656e20e28094204669626f6e6163636920737570706c793a203938372e20496e737572616e63653a203130306270732e2058616861753a20727731684837716b6e72754348697035536a7854395a784a433875647041564c5656", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/zdc555.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZDC555>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZDC555>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

