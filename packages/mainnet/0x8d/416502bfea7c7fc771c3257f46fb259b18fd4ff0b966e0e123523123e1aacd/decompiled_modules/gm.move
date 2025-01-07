module 0x8d416502bfea7c7fc771c3257f46fb259b18fd4ff0b966e0e123523123e1aacd::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 9, b"GM", b"GME", b"GME SUII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0945480d-6974-44c6-a643-7e08b88df6aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}

