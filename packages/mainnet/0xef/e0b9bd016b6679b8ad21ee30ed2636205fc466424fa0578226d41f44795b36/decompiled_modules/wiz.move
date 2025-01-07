module 0xefe0b9bd016b6679b8ad21ee30ed2636205fc466424fa0578226d41f44795b36::wiz {
    struct WIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZ>(arg0, 6, b"WIZ", b"Wizard", x"496e74726f647563696e67202457495a2c20746865206d61676963616c20626f74207468617420636f6e6a7572657320616e64206465706c6f797320796f7572204149206167656e74732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pqm_X7_Mr0_400x400_965fd12dc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

