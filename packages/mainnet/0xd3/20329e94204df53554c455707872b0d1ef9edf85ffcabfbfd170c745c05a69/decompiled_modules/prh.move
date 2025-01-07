module 0xd320329e94204df53554c455707872b0d1ef9edf85ffcabfbfd170c745c05a69::prh {
    struct PRH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRH>(arg0, 6, b"PRH", b"PiranHype on Sui", x"496e20245052482c20776520616c776179732063616c63756c6174650a6d696c6c696f6e2d646f6c6c617220636f6e76657273696f6e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_29_at_2_00_06a_pm_699cb8291b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRH>>(v1);
    }

    // decompiled from Move bytecode v6
}

