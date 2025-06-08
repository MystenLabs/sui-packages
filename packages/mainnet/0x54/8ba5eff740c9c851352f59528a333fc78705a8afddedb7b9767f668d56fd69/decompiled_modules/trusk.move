module 0x548ba5eff740c9c851352f59528a333fc78705a8afddedb7b9767f668d56fd69::trusk {
    struct TRUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUSK>(arg0, 6, b"TRUSK", b"TRUMPMUSK", x"20245452554d504d55534b20e2809420746865206d656d65636f696e206f662067616c61637469632065676f7320616e6420726f636b65742d706f7765726564207477656574732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749230825680.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

