module 0xd7c740e62ad24ae6088a33ccd54c36c9f169043b6dc0ce618aa5381918ebf2f9::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"Momo", b"MOMO", x"596f752077616e74204c69636b20f09f9884204d6f6d6f20746865204d656d65204361740a4c69636b20796f7572204c75636b202c436f6d6520436f6d6520436f6d65200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1759447696219.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

