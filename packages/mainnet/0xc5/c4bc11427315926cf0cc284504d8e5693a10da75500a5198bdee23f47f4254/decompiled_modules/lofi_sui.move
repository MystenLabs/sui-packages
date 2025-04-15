module 0xc5c4bc11427315926cf0cc284504d8e5693a10da75500a5198bdee23f47f4254::lofi_sui {
    struct LOFI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFI_SUI>(arg0, 9, b"lofiSUI", b"LOFI Staked SUI", x"41206c6971756964207374616b696e6720746f6b656e206372656174656420627920746865204c4f464920636f6d6d756e69747920f09fa5b6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://walrus.tusky.io/6zT1vl3FQHvBr69yckPqlfS3Q38927JsI3Q8BgfLInw")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOFI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

