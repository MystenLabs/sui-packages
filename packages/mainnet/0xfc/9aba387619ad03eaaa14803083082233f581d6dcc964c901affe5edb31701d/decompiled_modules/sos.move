module 0xfc9aba387619ad03eaaa14803083082233f581d6dcc964c901affe5edb31701d::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SOS>(arg0, 6, b"SOS", b"Suite Sentinel by SuiAI", x"537569746553656e74696e656c206973206d6f7265207468616e206a757374206120636861726163746572e280946974e280997320612073796d626f6c206f662066696e616e6369616c20696e74656c6c6967656e63652c20626c6f636b636861696e20696e6e6f766174696f6e2c20616e64207374726174656769632067726f7774682077697468696e20746865205375692065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3623_0182f01651.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

