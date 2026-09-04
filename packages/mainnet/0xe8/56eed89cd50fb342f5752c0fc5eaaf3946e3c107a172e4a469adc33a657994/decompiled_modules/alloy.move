module 0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy {
    struct ALLOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLOY>(arg0, 3, b"ALLOY", b"Alloy", x"416c6c6f7920e2809420726566696e6564207374727563747572616c206d6574616c2066726f6d207468652057617374657327206265747465722067726f756e642e204d696e656420627920726967732c2062616e6b656420617420746865206e696768746c7920666c7573682c207370656e742061742074686520666f756e64727920616e6420666f7267652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://boombots-production.up.railway.app/art/resources/alloy.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALLOY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLOY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

