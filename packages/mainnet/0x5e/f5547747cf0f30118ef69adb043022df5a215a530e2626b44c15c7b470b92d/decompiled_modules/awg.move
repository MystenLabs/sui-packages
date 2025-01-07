module 0x5ef5547747cf0f30118ef69adb043022df5a215a530e2626b44c15c7b470b92d::awg {
    struct AWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWG>(arg0, 6, b"AWG", b"ABYSS WORLD GAME", x"556d20756e69766572736f206465206a6f676f732064652066616e746173696120736f6d62726961204f6d6e692d636861696e20414141206d756c7469676e65726f2e2024415754200a40636861696e6c696e6b0a20434f4e5354525541206f20436f6c6973657520414920646f20416269736d6f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ABYSS_cb647a1df3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

