module 0x4e4bdfcb0d56d36c0c72d28e3b0b3debec2dc0306e922fd4b24a00f838859f5::a2345 {
    struct A2345 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A2345, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A2345>(arg0, 9, b"A2345", b"motherfuck", b"123453", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7d71d2d-4e7f-4e8d-ac22-f359cd9571da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A2345>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A2345>>(v1);
    }

    // decompiled from Move bytecode v6
}

