module 0x2c7cf92efaccf16a35b1c07bc630702adbafa7d4abc87fd09bf6ef6f23d5b985::esc {
    struct ESC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESC>(arg0, 6, b"ESC", b"ESC SUI", x"455343284150452920746865204d617065747269782e200a47656e657261706574696f6e616c207765616c7468206e6f742067756172616e7465656420627574206d617065622e204e4641", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U50v_Bc_Oq_400x400_b2236c06de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESC>>(v1);
    }

    // decompiled from Move bytecode v6
}

