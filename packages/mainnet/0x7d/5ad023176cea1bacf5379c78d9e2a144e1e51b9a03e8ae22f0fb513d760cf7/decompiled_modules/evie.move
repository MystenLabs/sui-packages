module 0x7d5ad023176cea1bacf5379c78d9e2a144e1e51b9a03e8ae22f0fb513d760cf7::evie {
    struct EVIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVIE>(arg0, 6, b"EVIE", b"Evie AI", x"5768657468657220796f75206e65656420736d61727420616e73776572732c2063617375616c2076696265732c206f72206120667269656e646c7920636861742c2045564945206973206865726520746f206163636f6d70616e7920796f752c207468652077617920796f7520636f6e6e6563742c205365616d6c6573732c204661737420616e6420496e74656c6c6967656e742e20f09f9a800a0a5361792068656c6c6f20746f20746865202445564945202120f09f92ace29ca8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735930747942.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

