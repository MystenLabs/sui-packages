module 0x66f2ae19d91d29f65620790cfe9827893802515eb7eee8de03b1d3c0aeb91c28::loki {
    struct LOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOKI>(arg0, 6, b"LOKI", b"Loki", x"4c4f4b492c20546865204c4f4649204b696c6c6572200a0a426f726e206f6e207468652053554920436861696e2c20666f726765642066726f6d2069636520616e642077617465722c20244c4f4b4920726973657320746f2074616b6520697473207468726f6e652e2041206e65772065726120626567696e732e204c4f46497320726569676e206973206f7665722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/475523287_956608523083578_5666639369546303688_n_1_d4c59a8c5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

