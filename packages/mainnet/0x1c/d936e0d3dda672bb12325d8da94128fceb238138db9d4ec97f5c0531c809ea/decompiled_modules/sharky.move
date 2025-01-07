module 0x1cd936e0d3dda672bb12325d8da94128fceb238138db9d4ec97f5c0531c809ea::sharky {
    struct SHARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKY>(arg0, 6, b"Sharky", b"Sui Sharky", x"24534841524b592049732061206a6565746e69766f726f7573206269670a0a666973682077697468206120646565702073746f6d6163680a0a6f6e2074686520535549204e4554574f524b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_shark_687a32c6b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

